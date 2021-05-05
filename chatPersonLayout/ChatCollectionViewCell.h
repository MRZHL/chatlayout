//
//  ChatCollectionViewCell.h
//  chatPersonLayout
//
//  Created by DecentSmart on 2021/1/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^CloseTap)(NSNumber *userID);
@interface ChatCollectionViewCell : UICollectionViewCell
@property (nonatomic, copy) CloseTap closeTap;
@property (nonatomic, strong) NSNumber *userID;
@end

NS_ASSUME_NONNULL_END
