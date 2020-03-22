//
//  CrashMonitor.h
//  Titan
//
//  Created by Yu Fan on 2019/4/13.
//  Copyright © 2019 Yu Fan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CrashMonitor : NSObject {
    BOOL ignore;
}

+ (instancetype)sharedInstance;

@end

NS_ASSUME_NONNULL_END
