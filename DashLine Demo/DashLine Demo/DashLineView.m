//
//  DashLineView.m
//  DashLine Demo
//
//  Created by FanYu on 9/21/16.
//  Copyright © 2016 SRT. All rights reserved.
//

#import "DashLineView.h"


@interface DashLineView()

@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, assign) FYDottedLineOrientation orientation;
@property (nonatomic, strong) UIColor *color;

@end

@implementation DashLineView

- (instancetype)initWithFrame:(CGRect)frame
                  orientation:(FYDottedLineOrientation)orientation
                        color:(UIColor *)color
{
    self = [super initWithFrame:frame];
    if (self) {
        self.color = color;
        self.orientation = orientation;
        _lineView = [[UIView alloc] initWithFrame:frame];
        [self addSubview:_lineView];
    }
    return self;
}


- (void)drawWithDotLength:(CGFloat)dotLength intervalLength:(CGFloat)intervalLength {
    if (!self.color) {
        return;
    }
//
//    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
//    [shapeLayer setBounds:self.lineView.bounds];
//    [shapeLayer setPosition:self.lineView.center];
//    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
//
//    // 设置虚线衔接方式
//    [shapeLayer setLineJoin:kCALineJoinRound];
//    // 设置每条线的间距
//    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:dotLength], [NSNumber numberWithInt:intervalLength], nil]];
//    // 设置虚线颜色
//    [shapeLayer setStrokeColor:self.color.CGColor];
//    // 设置虚线路径
//    CGMutablePathRef path = CGPathCreateMutable();
//    CGPathMoveToPoint(path, NULL, 0, 0);
//    CGFloat lineWidth = 1.f;
//    if (self.orientation == FYDottedLineOrientationHorizontal) {
//        lineWidth = CGRectGetHeight(self.lineView.bounds);
//        CGPathAddLineToPoint(path, NULL, CGRectGetWidth(self.lineView.bounds), 0);
//    } else {
//        lineWidth = CGRectGetWidth(self.lineView.bounds);
//        CGPathAddLineToPoint(path, NULL, 0, CGRectGetHeight(self.lineView.bounds));
//    }
//    [shapeLayer setPath:path];
//    CGPathRelease(path);
//    // 设置虚线的宽度
//    [shapeLayer setLineWidth:lineWidth];
//
//    [[self.lineView layer] addSublayer:shapeLayer];
    
    CAShapeLayer *border = [CAShapeLayer layer];
    [border setBounds:self.lineView.bounds];
    [border setPosition:self.lineView.center];

    //虚线的颜色
    [border setStrokeColor:[UIColor redColor].CGColor];
    border.opacity = 0.5;
    //填充的颜色
    [border setFillColor:[UIColor clearColor].CGColor];
    //虚线的宽度
    border.lineWidth = 1.f;
    [border setLineJoin:kCALineCapRound];
    border.lineDashPhase = 0.0;
    //虚线的间隔
    border.lineDashPattern = @[@4, @2];
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.lineView.bounds cornerRadius:6];
    //设置路径
    [border setPath:path.CGPath];
    
    [self.lineView.layer addSublayer:border];
    //self.lineView.layer.cornerRadius = 6.f;
    //self.lineView.layer.masksToBounds = YES;

}

@end
