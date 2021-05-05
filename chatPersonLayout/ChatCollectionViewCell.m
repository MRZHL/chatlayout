//
//  ChatCollectionViewCell.m
//  chatPersonLayout
//
//  Created by DecentSmart on 2021/1/13.
//

#import "ChatCollectionViewCell.h"

@implementation ChatCollectionViewCell

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (self.closeTap) {
        self.closeTap(self.userID);
    }
}

@end
