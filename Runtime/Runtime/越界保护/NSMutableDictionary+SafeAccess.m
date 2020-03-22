//
//  NSMutableDictionary+SafeAccess.m
//  Scimall
//
//  Created by Yu Fan on 2019/5/23.
//  Copyright © 2019 贾培军. All rights reserved.
//

#import "NSMutableDictionary+SafeAccess.h"
#import "objc/runtime.h"
#import "NSObject+Swizzling.h"

@implementation NSMutableDictionary (SafeAccess)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [objc_getClass("__NSDictionaryM") swizzleSelector:@selector(setObject:forKey:) withSwizzledSelector:@selector(safeSetObject:forKey:)];
         [objc_getClass("__NSDictionaryM") swizzleSelector:@selector(setObject:forKeyedSubscript:) withSwizzledSelector:@selector(safeSetObject:forKeyedSubscript:)];
    });
}

- (void)safeSetObject:(id)anObject forKey:(id<NSCopying>)aKey {
    if (!aKey) {
        NSLog(@"字典key为空 %s",__FUNCTION__);
        return;
    }
    if (!anObject) {
        anObject = [NSNull null];
        NSLog(@"字典value为空 %s",__FUNCTION__);
    }
    [self safeSetObject:anObject forKey:aKey];
}

- (void)safeSetObject:(id)obj forKeyedSubscript:(id<NSCopying>)key {
    if (!key) {
        NSLog(@"字典key为空 %s",__FUNCTION__);
        return;
    }
    if (!obj) {
        obj = [NSNull null];
        NSLog(@"字典value为空 %s",__FUNCTION__);
    }
    [self safeSetObject:obj forKeyedSubscript:key];
}

@end
