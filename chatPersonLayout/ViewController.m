//
//  ViewController.m
//  chatPersonLayout
//
//  Created by DecentSmart on 2021/1/6.
//

#import "ViewController.h"
#import "DSGroupVideoLayout.h"
#import "ChatCollectionViewCell.h"

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *mainCollectionView;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, assign) NSInteger endId;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = @[@1,@2,@3,@4,@5,@6,@7,@8,@9].mutableCopy;
    self.endId = 10;
    DSGroupVideoLayout *layout = [[DSGroupVideoLayout alloc] init];
    self.mainCollectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    self.mainCollectionView.backgroundColor = [UIColor darkGrayColor];
    [self.mainCollectionView registerClass:[ChatCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    self.mainCollectionView.delegate = self;
    self.mainCollectionView.dataSource = self;
    [self.view addSubview:self.mainCollectionView];
    
}

- (IBAction)subAction:(UIBarButtonItem *)sender {
    
}

- (IBAction)addAction:(UIBarButtonItem *)sender {
    if (self.dataSource.count == 9) {
        return;
    }
    NSNumber *end = @(self.endId);
    [self.dataSource insertObject:end atIndex:0];
    self.endId += 1;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.mainCollectionView insertItemsAtIndexPaths:@[indexPath]];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(void)changeChat:(NSIndexPath *)indexPath object:(id)object{
    [self.dataSource removeObject:object];
    [self.mainCollectionView deleteItemsAtIndexPaths:@[indexPath]];
}

-(void)changeChatl:(NSNumber *)userID{
    
   __block NSInteger index = 0;
    [self.dataSource enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([userID isEqualToNumber:obj]) {
            index = idx;
            *stop = YES;
        }
    }];
    [self.dataSource removeObjectAtIndex:index];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    [self.mainCollectionView deleteItemsAtIndexPaths:@[indexPath]];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return  self.dataSource.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ChatCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    __weak __typeof(&*self)weakSelf = self;
    cell.closeTap = ^(NSNumber * _Nonnull userID) {
        [weakSelf changeChatl:userID];
    };
   
    cell.backgroundColor = [self randomColor];
    return cell;
}

- (UIColor *)randomColor {
    static BOOL seeded = NO;
    if (!seeded) {
        seeded = YES;
        (time(NULL));
    }
    CGFloat red = (CGFloat)random() / (CGFloat)RAND_MAX;
    CGFloat green = (CGFloat)random() / (CGFloat)RAND_MAX;
    CGFloat blue = (CGFloat)random() / (CGFloat)RAND_MAX;
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];
}

@end
