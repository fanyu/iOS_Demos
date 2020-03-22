//
//  UIButton+SafeTap.m
//  Scimall
//
//  Created by Yu Fan on 2019/5/23.
//  Copyright © 2019 贾培军. All rights reserved.
//

#import "UIButton+SafeTap.h"
#import "objc/runtime.h"
#import "NSObject+Swizzling.h"

static const CGFloat defaultInterval = 1;

@interface UIButton ()
@property (nonatomic, assign) NSTimeInterval acceptEventTime;
@end

@implementation UIButton (SafeTap)
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleSelector:@selector(sendAction:to:forEvent:)
         withSwizzledSelector:@selector(safe_sendAction:to:forEvent:)];
    });
}

- (void)safe_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    if (self.isIgnore) {
        [self safe_sendAction:action to:target forEvent:event];
        return;
    }
    
    self.stickTimeInterval = self.stickTimeInterval == 0 ? defaultInterval : self.stickTimeInterval;
    // 点击时间差值
    BOOL needSendAction = (NSDate.date.timeIntervalSince1970 - self.acceptEventTime) >= self.stickTimeInterval;
    // 更新上次点击时间
    self.acceptEventTime = NSDate.date.timeIntervalSince1970;
    // 调用
    if (needSendAction) {
        [self safe_sendAction:action to:target forEvent:event];
        return;
    }
}

#pragma mark - Associated
- (NSTimeInterval)acceptEventTime {
    return [objc_getAssociatedObject(self, @selector(acceptEventTime)) doubleValue];
}

- (void)setAcceptEventTime:(NSTimeInterval)acceptEventTime {
    objc_setAssociatedObject(self, @selector(acceptEventTime), @(acceptEventTime), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSTimeInterval)stickTimeInterval {
    return [objc_getAssociatedObject(self, @selector(stickTimeInterval)) doubleValue];
}

- (void)setStickTimeInterval:(NSTimeInterval)stickTimeInterval {
    objc_setAssociatedObject(self, @selector(stickTimeInterval), @(stickTimeInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)isIgnore {
    return [objc_getAssociatedObject(self, @selector(isIgnore)) boolValue];
}

- (void)setIsIgnore:(BOOL)isIgnore {
    objc_setAssociatedObject(self, @selector(isIgnore), @(isIgnore), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
