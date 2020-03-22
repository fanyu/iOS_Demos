//
//  WeiboCardView.m
//  WeiboList
//
//  Created by Yu Fan on 2019/5/17.
//  Copyright © 2019 Yu Fan. All rights reserved.
//

#import "WeiboCardView.h"

@interface WeiboCardView ()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImageView *badgeImageView;
@property (nonatomic, strong) YYLabel *label;
@property (nonatomic, strong) UIButton *button;
@end

@implementation WeiboCardView
- (instancetype)initWithFrame:(CGRect)frame {
    if (frame.size.width == 0 && frame.size.height == 0){
        frame.size.width = kScreenWidth;
        frame.origin.x = kWBCellPadding;
    }
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

#pragma mark - UI
- (void)setupUI {
    self.exclusiveTouch = YES;
    self.backgroundColor = kWBCellInnerViewColor;
    self.layer.borderWidth = CGFloatFromPixel(1);
    self.layer.borderColor = [UIColor colorWithWhite:0.000 alpha:0.070].CGColor;
    
    self.imageView = [UIImageView new];
    self.imageView.clipsToBounds = YES;
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:self.imageView];

    self.badgeImageView = [UIImageView new];
    self.badgeImageView.clipsToBounds = YES;
    self.badgeImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:self.badgeImageView];

    self.label = [YYLabel new];
    self.label.textVerticalAlignment = YYTextVerticalAlignmentCenter;
    self.label.numberOfLines = 3;
    self.label.ignoreCommonProperties = YES;
    self.label.displaysAsynchronously = YES;
    self.label.fadeOnAsynchronouslyDisplay = NO;
    self.label.fadeOnHighlight = NO;
    [self addSubview:self.label];

    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.button];
}

@end
