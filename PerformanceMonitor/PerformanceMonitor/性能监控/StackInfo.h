//
//  StackInfo.h
//  Scimall
//
//  Created by Yu Fan on 2019/5/29.
//  Copyright © 2019 贾培军. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, StackInfoType) {
    StackInfoTypeCPU,
    StackInfoTypeLag,
    StackInfoTypeCrash,
};

@interface StackInfo : NSObject
+ (void)logSackInfo:(StackInfoType)type;
@end

NS_ASSUME_NONNULL_END
