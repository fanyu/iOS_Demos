//
//  CrashMonitor.m
//  Titan
//
//  Created by Yu Fan on 2019/4/13.
//  Copyright © 2019 Yu Fan. All rights reserved.
//

#import "CrashMonitor.h"
#import <UIKit/UIKit.h>
#include <libkern/OSAtomic.h>
#include <execinfo.h>
#import "StackInfo.h"
#import "SMCallStack.h"
#import "SMCallStackModel.h"

NSString * const kSignalExceptionName = @"kSignalExceptionName";
NSString * const kSignalKey = @"kSignalKey";
NSString * const kCaughtExceptionStackInfoKey = @"kCaughtExceptionStackInfoKey";

void HandleException(NSException *exception);
void SignalHandler(int signal);

@implementation CrashMonitor
+ (CrashMonitor*)sharedInstance {
    static dispatch_once_t once;
    static CrashMonitor *sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[CrashMonitor alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setCatchExceptionHandler];
    }
    return self;
}

- (void)setCatchExceptionHandler {
    // 捕获一些异常导致的崩溃
    NSSetUncaughtExceptionHandler(&HandleException);
    // 捕获非异常情况导致的崩溃，通过signal传递出来的崩溃
    signal(SIGABRT, SignalHandler);
    signal(SIGILL, SignalHandler);
    signal(SIGSEGV, SignalHandler);
    signal(SIGFPE, SignalHandler);
    signal(SIGBUS, SignalHandler);
    signal(SIGPIPE, SignalHandler);
}

+ (NSArray *)backtrace {
    void* callstack[128];
    int frames = backtrace(callstack, 128);
    char **strs = backtrace_symbols(callstack, frames);
    
    NSMutableArray *backtrace = [NSMutableArray arrayWithCapacity:frames];
    for (int i = 0; i < frames; i++) {
        [backtrace addObject:[NSString stringWithUTF8String:strs[i]]];
    }
    free(strs);
    
    return backtrace;
}

- (void)handleException:(NSException *)exception {
    NSString *message = [NSString stringWithFormat:@"崩溃原因如下:\n%@\n%@",
                         [exception reason],
                         [[exception userInfo] objectForKey:kCaughtExceptionStackInfoKey]];
    NSLog(@"%@",message);
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"程序崩溃了" message:@"如果你能让程序起死回生，那你的决定是？" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"崩就蹦吧" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        self->ignore = YES;
    }];
    UIAlertAction *other = [UIAlertAction actionWithTitle:@"起死回生" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:cancel];
    [alert addAction:other];
    
    CFRunLoopRef runLoop = CFRunLoopGetCurrent();
    CFArrayRef allModes = CFRunLoopCopyAllModes(runLoop);
    
    while (!ignore) {
        for (NSString *mode in (__bridge NSArray *)allModes) {
            CFRunLoopRunInMode((CFStringRef)mode, 0.001, false);
        }
    }
    
    CFRelease(allModes);
    
    NSSetUncaughtExceptionHandler(NULL);
    signal(SIGABRT, SIG_DFL);
    signal(SIGILL, SIG_DFL);
    signal(SIGSEGV, SIG_DFL);
    signal(SIGFPE, SIG_DFL);
    signal(SIGBUS, SIG_DFL);
    signal(SIGPIPE, SIG_DFL);
    
    if ([[exception name] isEqual:kSignalExceptionName]) {
        kill(getpid(), [[[exception userInfo] objectForKey:kSignalKey] intValue]);
    } else {
        [exception raise];
    }
}
@end

#pragma mark - Handler
void HandleException(NSException *exception) {
    NSString *stackStr = [SMCallStack callStackWithType:SMCallStackTypeMain];
    NSLog(@"dm Crash: %@", stackStr);
    
    [StackInfo logSackInfo:StackInfoTypeCrash];

    // 获取异常的堆栈信息
    NSArray *callStack = [exception callStackSymbols];
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    [userInfo setObject:callStack forKey:kCaughtExceptionStackInfoKey];
    
    CrashMonitor *crashObject = [CrashMonitor sharedInstance];
    NSException *customException = [NSException exceptionWithName:[exception name] reason:[exception reason] userInfo:userInfo];
    [crashObject performSelectorOnMainThread:@selector(handleException:) withObject:customException waitUntilDone:YES];
}

void SignalHandler(int signal) {
    NSString *stackStr = [SMCallStack callStackWithType:SMCallStackTypeMain];
    NSLog(@"dm Crash: %@", stackStr);
    
    [StackInfo logSackInfo:StackInfoTypeCrash];

    // 这种情况的崩溃信息，就另某他法来捕获吧
    NSArray *callStack = [CrashMonitor backtrace];
    NSLog(@"信号捕获崩溃，堆栈信息：%@",callStack);
    
    
    CrashMonitor *crashObject = [CrashMonitor sharedInstance];
    NSException *customException = [NSException exceptionWithName:kSignalExceptionName
                                                           reason:[NSString stringWithFormat:NSLocalizedString(@"Signal %d was raised.", nil),signal]
                                                         userInfo:@{kSignalKey:[NSNumber numberWithInt:signal]}];
    
    [crashObject performSelectorOnMainThread:@selector(handleException:) withObject:customException waitUntilDone:YES];
}

