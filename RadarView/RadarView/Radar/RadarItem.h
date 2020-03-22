//
//  RadarItem.h
//  RadarView
//
//  Created by Yu Fan on 2019/5/27.
//  Copyright © 2019 Yu Fan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RadarItem : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) CGFloat percent;
@property (nonatomic, strong) UIColor *fontColor;
@property (nonatomic, assign) CGFloat fontSize;
@end

NS_ASSUME_NONNULL_END
