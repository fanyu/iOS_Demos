//
//  WeiboModel.h
//  WeiboList
//
//  Created by Yu Fan on 2019/5/17.
//  Copyright © 2019 Yu Fan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeiboUser.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, WeiboUserVerifyType) {
    WeiboUserVerifyTypeNone = 0,
    WeiboUserVerifyTypeStandard,
    WeiboUserVerifyTypeOrganization,
    WeiboUserVerifyTypeClub
};

@interface WeiboModel : NSObject
@property (nonatomic, strong) WeiboUser *user;
@end

NS_ASSUME_NONNULL_END
