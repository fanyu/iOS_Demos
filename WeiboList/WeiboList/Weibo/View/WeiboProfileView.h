//
//  WeiboProfileView.h
//  WeiboList
//
//  Created by Yu Fan on 2019/5/17.
//  Copyright © 2019 Yu Fan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WeiboCell;

NS_ASSUME_NONNULL_BEGIN

@interface WeiboProfileView : UIView 
@property (nonatomic, weak) WeiboCell *cell;
@property (nonatomic, assign) WeiboUserVerifyType verifyType;
@end

NS_ASSUME_NONNULL_END
