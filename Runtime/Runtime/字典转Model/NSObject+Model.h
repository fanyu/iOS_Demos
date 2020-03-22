//
//  NSObject+Model.h
//  Runtime
//
//  Created by Yu Fan on 2019/5/21.
//  Copyright © 2019 Yu Fan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Model)
+ (instancetype)modelWithDict:(NSDictionary *)dict;
+ (instancetype)modelWithJSON:(id)json;
+ (NSDictionary *)keyMapper;
@end

NS_ASSUME_NONNULL_END
