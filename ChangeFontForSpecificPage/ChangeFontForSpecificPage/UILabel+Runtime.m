//
//  UILabel+Runtime.m
//  Scimall
//
//  Created by Yu Fan on 2019/5/14.
//  Copyright © 2019 贾培军. All rights reserved.
//

#import "UILabel+Runtime.h"
#import <objc/runtime.h>
#import "TestViewController.h"

@implementation UILabel (Runtime)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL originalSel = @selector(setFont:);
        SEL swizzledSel = @selector(runtime_setFontSize:);
        
        Method originalMethod = class_getInstanceMethod(self, originalSel);
        Method swizzledMethod = class_getInstanceMethod(self, swizzledSel);
        
        BOOL didAddMethod = class_addMethod(self,
                                            originalSel,
                                            method_getImplementation(swizzledMethod),
                                            method_getTypeEncoding(swizzledMethod));
        
        if (didAddMethod) {
            // 没有实现原方法
            class_replaceMethod(self,
                                swizzledSel,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
            
        } else {
            // 已经实现了原方法，直接进行交换
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
        
    });
}

- (void)runtime_setFontSize:(UIFont *)font {
    UIViewController *currentVC = [self topViewController];
    
    if ([currentVC isKindOfClass:[TestViewController class]]) {
        [self runtime_setFontSize:[UIFont systemFontOfSize:30]];
    } else {
        [self runtime_setFontSize:font];
    }
}

- (UIViewController *)topViewController {
    return [self topViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
}

- (UIViewController *)topViewController:(UIViewController *)rootViewController {
    
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController* tabBarController = (UITabBarController*)rootViewController;
        return [self topViewController:tabBarController.selectedViewController];
        
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController* navigationController = (UINavigationController*)rootViewController;
        return [self topViewController:navigationController.visibleViewController];
        
    } else if (rootViewController.presentedViewController) {
        UIViewController* presentedViewController = rootViewController.presentedViewController;
        if ([presentedViewController isKindOfClass:[UIAlertController class]]) {
            UIWindow *window =  [UIApplication sharedApplication].delegate.window;
            UIViewController *vc = window.rootViewController;
            return [self topViewController:vc];
        }
        return [self topViewController:presentedViewController];
        
    } else {
        
        return rootViewController;
    }
}

@end
