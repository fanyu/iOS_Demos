//
//  Person.h
//  Runtime
//
//  Created by Yu Fan on 2019/5/22.
//  Copyright © 2019 Yu Fan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person1 : NSObject<NSCoding>
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *age;
@property (nonatomic, copy) NSString *title;
@end

NS_ASSUME_NONNULL_END
