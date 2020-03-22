//
//  RadarConfiguration.m
//  RadarView
//
//  Created by Yu Fan on 2019/5/27.
//  Copyright © 2019 Yu Fan. All rights reserved.
//

#import "RadarConfiguration.h"

@implementation RadarConfiguration
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.sideColor = [UIColor lightGrayColor];
        self.sideWidth = 1;
        self.longSideColor = [UIColor lightGrayColor];
        self.longSideWidth = 1;
        self.gap = 5;
        self.fontColor = [UIColor lightGrayColor];
        self.font = [UIFont systemFontOfSize:17 weight:UIFontWeightLight];
    }
    return self;
}
@end
