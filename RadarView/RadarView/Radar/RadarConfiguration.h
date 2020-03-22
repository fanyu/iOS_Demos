//
//  RadarConfiguration.h
//  RadarView
//
//  Created by Yu Fan on 2019/5/27.
//  Copyright © 2019 Yu Fan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RadarConfiguration : NSObject
/// 边数
@property (nonatomic, assign) NSUInteger side;
@property (nonatomic, strong) UIColor *sideColor;
@property (nonatomic, assign) CGFloat sideWidth;

@property (nonatomic, strong) UIColor *longSideColor;
@property (nonatomic, assign) CGFloat longSideWidth;

@property (nonatomic, assign) CGFloat gap;

@property (nonatomic, strong) UIFont *font;
@property (nonatomic, strong) UIColor *fontColor;

@property (nonatomic, assign) CGFloat radius;
@end

NS_ASSUME_NONNULL_END
