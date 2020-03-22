//
//  LagMonitor.h
//  Scimall
//
//  Created by Yu Fan on 2019/5/29.
//  Copyright © 2019 贾培军. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LagMonitor : NSObject
@property (nonatomic) BOOL isMonitoring;

- (void)beginMonitor; //开始监视卡顿
- (void)endMonitor;   //停止监视卡顿

@end

NS_ASSUME_NONNULL_END
