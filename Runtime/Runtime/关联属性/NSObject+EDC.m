//
//  NSObject+EDC.m
//  Runtime
//
//  Created by Yu Fan on 2019/5/23.
//  Copyright © 2019 Yu Fan. All rights reserved.
//

#import "NSObject+EDC.h"
#import "objc/runtime.h"

@implementation NSObject (EDC)

- (NSString *)edc {
    return objc_getAssociatedObject(self, @"edc");
}

- (void)setEdc:(NSString *)edc {
    objc_setAssociatedObject(self, @"edc", edc, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
