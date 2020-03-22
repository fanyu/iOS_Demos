//
//  UILabel+Font.m
//  Runtime
//
//  Created by Yu Fan on 2019/5/23.
//  Copyright © 2019 Yu Fan. All rights reserved.
//

#import "UILabel+Font.h"
#import "NSObject+Swizzling.h"
#import "objc/runtime.h"

@implementation UILabel (Font)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleSelector:@selector(setFont:)
         withSwizzledSelector:@selector(runtime_setFontSize:)];
    });
}

- (void)runtime_setFontSize:(UIFont *)font {
    if (@"当前控制器 == 要修改的控制器") {
        [self runtime_setFontSize:[UIFont systemFontOfSize:20]];
    } else {
        [self runtime_setFontSize:font];
    }
}

- (UIViewController *)viewController {    
    for (UIView *next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}


@end
