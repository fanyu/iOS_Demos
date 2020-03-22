//
//  WeiboCardView.h
//  WeiboList
//
//  Created by Yu Fan on 2019/5/17.
//  Copyright © 2019 Yu Fan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class WeiboCell;

@interface WeiboCardView : UIView
@property (nonatomic, weak) WeiboCell *cell;
@end

NS_ASSUME_NONNULL_END
