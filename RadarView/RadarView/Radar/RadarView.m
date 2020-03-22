//
//  RadarView.m
//  RadarView
//
//  Created by Yu Fan on 2019/5/27.
//  Copyright © 2019 Yu Fan. All rights reserved.
//

#import "RadarView.h"

@interface RadarView ()
@property (nonatomic, strong) RadarConfiguration *configuration;
@property (nonatomic, strong) CAShapeLayer *lineShapeLayer;
@property (nonatomic, strong) CAShapeLayer *reginShapeLayer;
@property (nonatomic, strong) CAShapeLayer *textShapeLayer;
@property (nonatomic, strong) CAShapeLayer *dotShapeLayer;
@end

@implementation RadarView

- (instancetype)initWithConfiguration:(RadarConfiguration *)configuration {
    self = [super init];
    if (self) {
        self.configuration = configuration;
        [self setupUI];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self updateLayer];
}


#pragma mark - UI
- (void)setupUI {
    
}

#pragma mark - Layout
- (void)updateLayer {
    CGMutablePathRef path = CGPathCreateMutable();
    CGFloat side = self.configuration.side;
    CGFloat radiuSpace = self.configuration.radius / (side - 1);
    CGFloat angle = M_PI * 2 / side;
    CGPoint centerPoint = CGPointMake(self.center.x, self.center.y);
    
    for (NSUInteger circle = 0; circle < side; circle++) {
        CGFloat currentRadius = circle * radiuSpace;
        NSMutableArray *array = [NSMutableArray array];
        for (NSUInteger node = 0; node < side; node++) {
            CGFloat x = currentRadius * sinf(angle / 2 + angle * node) + centerPoint.x;
            CGFloat y = currentRadius * cosf(angle / 2 + angle * node) + centerPoint.y;
            CGPoint currentPoint = CGPointMake(x, y);
            [array addObject:@(currentPoint)];
            //[path ];
        }
    }
    
}

@end
