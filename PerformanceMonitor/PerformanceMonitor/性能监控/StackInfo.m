//
//  StackInfo.m
//  Scimall
//
//  Created by Yu Fan on 2019/5/29.
//  Copyright © 2019 贾培军. All rights reserved.
//

#import "StackInfo.h"
#import <CrashReporter/CrashReporter.h>
#import <CrashReporter/PLCrashReportTextFormatter.h>

@implementation StackInfo

+ (void)logSackInfo:(StackInfoType)type {
    PLCrashReporterConfig *config = [[PLCrashReporterConfig alloc]
                                     initWithSignalHandlerType:PLCrashReporterSignalHandlerTypeBSD symbolicationStrategy:PLCrashReporterSymbolicationStrategyAll];
    PLCrashReporter *reporter = [[PLCrashReporter alloc] initWithConfiguration:config];
    NSData *data = [reporter generateLiveReport];
    if (data) {
        PLCrashReport *report = [[PLCrashReport alloc] initWithData:data error:nil];
        NSString *reportStr = [PLCrashReportTextFormatter stringValueForCrashReport:report
                                                                     withTextFormat:PLCrashReportTextFormatiOS];
        NSString *typeStr = nil;
        switch (type) {
            case StackInfoTypeCPU:
                typeStr = @"CPU";
                break;
            case StackInfoTypeLag:
                typeStr = @"Lag";
                break;
            case StackInfoTypeCrash:
                typeStr = @"Crash";
                break;
        }
        
        NSLog(@"%@ Stack Info: ----- \n %@ ------\n", typeStr, reportStr);
    }
}

@end
