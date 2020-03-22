//
//  UIViewController+LifeCycle.m
//  Runtime
//
//  Created by Yu Fan on 2019/5/24.
//  Copyright © 2019 Yu Fan. All rights reserved.
//

#import "UIViewController+LifeCycle.h"
#import "NSObject+Swizzling.h"
#import "objc/runtime.h"

@implementation UIViewController (LifeCycle)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleSelector:@selector(viewDidLoad) withSwizzledSelector:@selector(runtime_viewDidLoad)];
        [self swizzleSelector:@selector(viewDidDisappear:) withSwizzledSelector:@selector(runtime_viewDidDisappear:)];
    });
}

- (void)runtime_viewDidLoad {
    [self runtime_viewDidLoad];
}

- (void)runtime_viewDidDisappear:(BOOL)animated {
    [self runtime_viewDidDisappear: animated];
    
    // hide progress view or HUD
}

@end
