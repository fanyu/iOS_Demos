//
//  DashLineView.h
//  DashLine Demo
//
//  Created by FanYu on 9/21/16.
//  Copyright © 2016 SRT. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, FYDottedLineOrientation) {
    FYDottedLineOrientationHorizontal,
    FYDottedLineOrientationVertical
};

@interface DashLineView : UIView
- (instancetype)initWithFrame:(CGRect)frame
                  orientation:(FYDottedLineOrientation)orientation
                        color:(UIColor *)color;

- (void)drawWithDotLength:(CGFloat)dotLength
           intervalLength:(CGFloat)intervalLength;

@end
