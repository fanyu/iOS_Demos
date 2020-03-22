//
//  CPUMonitor.m
//  Scimall
//
//  Created by Yu Fan on 2019/5/28.
//  Copyright © 2019 贾培军. All rights reserved.
//

#import "CPUMonitor.h"
#import <CrashReporter/CrashReporter.h>
#import <CrashReporter/PLCrashReportTextFormatter.h>
#import "SMCallStack.h"
#import "SMCallStackModel.h"
#import "StackInfo.h"
#import <UIKit/UIKit.h>

static const CGFloat CPUMONITORRATE = 80;

//struct thread_basic_info {
//    time_value_t    user_time;      /* user 运行的时间 */
//    time_value_t    system_time;    /* system 运行的时间 */
//    integer_t       cpu_usage;      /* CPU 使用百分比 */
//    policy_t        policy;         /* 有效的计划策略 */
//    integer_t       run_state;      /* run state (see below) */
//    integer_t       flags;          /* various flags (see below) */
//    integer_t       suspend_count;  /* suspend count for thread */
//    integer_t       sleep_time;     /* 休眠时间 */
//};

@implementation CPUMonitor

+ (void)updateCPU {
    thread_act_array_t threads;
    mach_msg_type_number_t threadCount = 0;
    // 获取所有 threads count
    const task_t thisTask = mach_task_self();
    kern_return_t kr = task_threads(thisTask, &threads, &threadCount);
    if (kr != KERN_SUCCESS) {
        return;
    }
    // 轮询检查所有线程 cpu 情况
    for (int i = 0; i < threadCount; i++) {
        thread_info_data_t threadInfo;
        thread_basic_info_t threadBaseInfo;
        mach_msg_type_number_t threadInfoCount = THREAD_INFO_MAX;
        // 获取 thread info
        if (thread_info((thread_act_t)threads[i], THREAD_BASIC_INFO, (thread_info_t)threadInfo, &threadInfoCount) == KERN_SUCCESS) {
            threadBaseInfo = (thread_basic_info_t)threadInfo;
            if (!(threadBaseInfo->flags & TH_FLAGS_IDLE)) {
                integer_t cpuUsage = threadBaseInfo->cpu_usage / 10;
                //cup 消耗大于设置值时打印和记录堆栈
                if (cpuUsage > CPUMONITORRATE) {
                    // dm
                    NSString *reStr = smStackOfThread(threads[i]);
                    NSLog(@"dmCPU Stack: ----- \n %@ ------\n", reStr);
                    // pl
                    [StackInfo logSackInfo:StackInfoTypeCPU];
                }
            }
        }
    }
}


@end
