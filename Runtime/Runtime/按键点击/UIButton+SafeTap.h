//
//  UIButton+SafeTap.h
//  Scimall
//
//  Created by Yu Fan on 2019/5/23.
//  Copyright © 2019 贾培军. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (SafeTap)
/// 点击时间间隔 默认是 1秒
@property (nonatomic, assign) NSTimeInterval stickTimeInterval;
/// 单个按键不要被hook
@property (nonatomic, assign) BOOL isIgnore;
@end

NS_ASSUME_NONNULL_END
