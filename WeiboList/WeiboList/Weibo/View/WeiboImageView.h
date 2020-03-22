//
//  WeiboImageView.h
//  WeiboList
//
//  Created by Yu Fan on 2019/5/17.
//  Copyright © 2019 Yu Fan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WeiboImageView : UIView
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, copy) void (^touchBlock)(WeiboImageView *view, YYGestureRecognizerState state, NSSet *touches, UIEvent *event);
@property (nonatomic, copy) void (^longPressBlock)(WeiboImageView *view, CGPoint point);
@end

NS_ASSUME_NONNULL_END
