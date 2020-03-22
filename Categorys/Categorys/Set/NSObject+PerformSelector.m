//
//  NSObject+PerformSelector.m
//  Categorys
//
//  Created by Yu Fan on 2019/5/21.
//  Copyright © 2019 Yu Fan. All rights reserved.
//

#import "NSObject+PerformSelector.h"



@implementation EndMark
+ (id)end {
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] init];
    });
    return instance;
}
@end


@implementation NSObject (PerformSelector)

- (id)performSelector:(SEL)aSelector withObjects:(id)object, ... {
    NSMethodSignature *signature = [[self class] instanceMethodSignatureForSelector:aSelector];
    if (!signature) {
        NSAssert(NO, @"未找到 %@", NSStringFromSelector(aSelector));
    }
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    // 方法调用者
    invocation.target = self;
    // 方法的 SEL
    invocation.selector = aSelector;
    // 参数数量 去掉 self _cmd
    NSInteger paramsCount = signature.numberOfArguments - 2;
    // 参数
    va_list params;
    va_start(params, object);
    int i = 0;
    // [endmark end] 可以使得该方法接受 nil 作为参数
    for (id tempObject = object; (id)tempObject != [EndMark end]; tempObject = va_arg(params, id)) {
        // 防止越界
        if (i >= paramsCount) {
            break;
        }
        // 去掉 self _cmd
        [invocation setArgument:&tempObject atIndex:i + 2];
        i++;
    }
    va_end(params);
    // 方法调用
    [invocation invoke];
    // 获取返回值
    id returnValue = nil;
    if (signature.methodReturnLength) {
        [invocation getReturnValue:&returnValue];
    }
    return returnValue;
}

@end




