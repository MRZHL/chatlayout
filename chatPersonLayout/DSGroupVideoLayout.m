//
//  DSGroupVideoLayout.m
//  IMTest
//
//  Created by DecentSmart on 2020/8/6.
//  Copyright © 2020 zhengwenqing’s mac. All rights reserved.
//

#import "DSGroupVideoLayout.h"


@interface DSGroupVideoLayout ()
@property (nonatomic, strong) NSMutableArray<UICollectionViewLayoutAttributes*> * attrisArray;
@property (nonatomic, assign) CGFloat lastY;
@end



@implementation DSGroupVideoLayout


- (void)prepareLayout {
    [super prepareLayout];
    self.attrisArray = @[].mutableCopy;
    self.lastY = 0.0;
    
    NSInteger maxCount = [self.collectionView numberOfItemsInSection:0];
    
    for (int i = 0; i < maxCount; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        UICollectionViewLayoutAttributes *attribus = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.attrisArray addObject:attribus];
    }
    
}

- (CGSize)collectionViewContentSize{
    return CGSizeMake(0, self.lastY);
}


- (NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    return self.attrisArray;
}



// 对不同的 IndexPath 进行布局
/// 在 count = 2 和 1 的时候 布局像下便宜57
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewLayoutAttributes *attrbutes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    NSInteger count = [self.collectionView numberOfItemsInSection:0];;
    CGSize resultSize = [self itemSizeWithCount:count];
    
    CGRect rect = CGRectZero;
    CGFloat x;
    CGFloat y;
    NSInteger currentIndex = indexPath.row;
    if (count == 1) {
        rect = CGRectMake(0, 57.0, resultSize.width, resultSize.height);
    };
    
    // 2 , 4
    if (count == 2 || count == 4) {
        if (currentIndex % 2 == 0) {
            x = 0.0;
        }else{
            x = resultSize.width;
        }
        
        if (currentIndex / 2 < 1) {
            y = 0.0;
        }else{
            y = resultSize.width;
        }
        
        if (count == 2) {
            y = 57.0;
        }
        rect = CGRectMake(x, y, resultSize.width, resultSize.height);
    }
    
    // 3 的情况
    if (count == 3) {
        if (currentIndex < 2) {
            if (currentIndex == 0) {
                rect = CGRectMake(0.0, 0.0, resultSize.width, resultSize.height);
            }else{
                rect = CGRectMake(resultSize.width, 0.0, resultSize.width, resultSize.height);
            }
        }else{
            rect = CGRectMake(resultSize.width / 2, resultSize.width, resultSize.width, resultSize.width);
        }
    }
    
    
    // 5 的情况
    if (count == 5) {
        if (currentIndex / 3 < 1) {
            x = resultSize.width * currentIndex;
        }else{
            x = resultSize.width / 2 + currentIndex % 3 * resultSize.width;
        }
        
        y = currentIndex / 3 * resultSize.height;
        
        rect = CGRectMake(x, y, resultSize.width, resultSize.height);
    }
    
    
    if (count > 5) {
        
        x = currentIndex % 3 * resultSize.width;
        y = currentIndex / 3 * resultSize.height;
        
        rect = CGRectMake(x, y, resultSize.width, resultSize.height);
    }
    
    
    attrbutes.frame = rect;
    self.lastY = CGRectGetMaxY(rect);
    return attrbutes;
}

/// 根据 item 的个数返回item 的size
-(CGSize)itemSizeWithCount:(NSInteger)count{
    CGFloat kScreenW = [UIScreen mainScreen].bounds.size.width;
    if (count > 9) {
        return CGSizeZero;
    }
    if (count == 1) {
        return CGSizeMake(kScreenW, kScreenW);
    }
    if (count == 2 || count == 4 || count == 3) {
        CGFloat width = kScreenW / 2;
        return CGSizeMake(width, width);
    }
    
    if (count  > 4) {
        CGFloat width = kScreenW / 3;
        return CGSizeMake(width, width);
    }
    
    return CGSizeZero;
}

@end
