//
//  FYDictionaryBucket.h
//  BuildDictionaryAndArray
//
//  Created by Yu Fan on 2019/5/15.
//  Copyright © 2019 Yu Fan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FYDictionaryBucket : NSObject
@property (nonatomic, copy) id key;
@property (nonatomic, strong) id obj;
@property (nonatomic, strong) FYDictionaryBucket *next;
@end

NS_ASSUME_NONNULL_END
