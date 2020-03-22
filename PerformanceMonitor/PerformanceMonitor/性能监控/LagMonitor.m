//
//  LagMonitor.m
//  Scimall
//
//  Created by Yu Fan on 2019/5/29.
//  Copyright © 2019 贾培军. All rights reserved.
//

#import "LagMonitor.h"
#import "CPUMonitor.h"
#import <CrashReporter/CrashReporter.h>
#import <CrashReporter/PLCrashReportTextFormatter.h>
#import "SMCallStack.h"
#import "SMCallStackModel.h"
#import "StackInfo.h"
#import <UIKit/UIKit.h>

static const CGFloat STUCKMONITORRATE = 88;

@interface LagMonitor () {
    int timeoutCount;
    CFRunLoopObserverRef runLoopObserver;
    @public
    dispatch_semaphore_t dispatchSemaphore;
    CFRunLoopActivity runLoopActivity;
}
@property (nonatomic, strong) NSTimer *cpuMonitorTimer;
@end

@implementation LagMonitor

+ (instancetype)sharedInstance {
    static LagMonitor *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[LagMonitor alloc] init];
    });
    return _sharedInstance;
}

- (void)beginMonitor {
    self.isMonitoring = YES;
    // 检测 CPU 消耗
    self.cpuMonitorTimer = [NSTimer scheduledTimerWithTimeInterval:3
                                                            target:self
                                                          selector:@selector(updateCPUInfo)
                                                          userInfo:nil
                                                           repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.cpuMonitorTimer forMode:NSRunLoopCommonModes];
    // 已经监控卡顿
    if (runLoopObserver) {
        return;
    }
    // 初始信号量 0
    dispatchSemaphore = dispatch_semaphore_create(0);
    // 观察者
    CFRunLoopObserverContext context = {0,(__bridge void*)self,NULL,NULL};
    runLoopObserver = CFRunLoopObserverCreate(kCFAllocatorDefault, kCFRunLoopAllActivities, YES, 0, &runLoopObserverCallBack, &context);
    // 观察者添加到主线程runloop的common模式下的观察中
    CFRunLoopAddObserver(CFRunLoopGetMain(), runLoopObserver, kCFRunLoopCommonModes);
    // 创建子线程监控
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 持续的loop来进行监控
        while (YES) {
            // 等待 STUCKMONITORRATE 时间，代码不往下进行
            long semaphoreWait = dispatch_semaphore_wait(self->dispatchSemaphore, dispatch_time(DISPATCH_TIME_NOW, STUCKMONITORRATE * NSEC_PER_MSEC));
            // 不等于0，等待时间超时在次期间未收到信号量（也就是状态没有变化），卡顿了，继续执行
            // 等于0，说明在等待时间收到信号量了，runloop状态有变化，继续执行
            if (semaphoreWait != 0) {
                if (!self->runLoopObserver) {
                    self->timeoutCount = 0;
                    self->dispatchSemaphore = 0;
                    self->runLoopActivity = 0;
                    return;
                }
                //两个runloop的状态，BeforeSources和AfterWaiting这两个状态区间时间能够检测到是否卡顿
                if (self->runLoopActivity == kCFRunLoopBeforeSources ||
                    self->runLoopActivity == kCFRunLoopAfterWaiting) {
                    //出现三次出结果
                    if (++self->timeoutCount < 3) {
                        continue;
                    }
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
                        NSString *stackStr = [SMCallStack callStackWithType:SMCallStackTypeMain];
                        NSLog(@"Lag stick: %@", stackStr);
                        
                        [StackInfo logSackInfo:StackInfoTypeLag];
                    });
                } //end activity
            }
            self->timeoutCount = 0;
        }
    });
}

- (void)endMonitor {
    self.isMonitoring = NO;
    [self.cpuMonitorTimer invalidate];
    if (!runLoopObserver) {
        return;
    }
    CFRunLoopRemoveObserver(CFRunLoopGetMain(), runLoopObserver, kCFRunLoopCommonModes);
    CFRelease(runLoopObserver);
    runLoopObserver = NULL;
}

#pragma mark - Private
- (void)updateCPUInfo {
    [CPUMonitor updateCPU];
}

static void runLoopObserverCallBack(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info){
    LagMonitor *lagMonitor = (__bridge LagMonitor*)info;
    lagMonitor->runLoopActivity = activity;
    // 检查到 activity 进行信号量增加1
    dispatch_semaphore_t semaphore = lagMonitor->dispatchSemaphore;
    dispatch_semaphore_signal(semaphore);
}
@end
