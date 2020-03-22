//
//  RadarItem.m
//  RadarView
//
//  Created by Yu Fan on 2019/5/27.
//  Copyright © 2019 Yu Fan. All rights reserved.
//

#import "RadarItem.h"

@implementation RadarItem

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.fontSize = 17;
        self.fontColor = [UIColor redColor];
    }
    return self;
}

@end
