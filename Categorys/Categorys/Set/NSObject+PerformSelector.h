//
//  NSObject+PerformSelector.h
//  Categorys
//
//  Created by Yu Fan on 2019/5/21.
//  Copyright © 2019 Yu Fan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EndMark : NSObject
+ (id)end;
@end

@interface NSObject (PerformSelector)
- (id)performSelector:(SEL)aSelector withObjects:(id)object, ...;
@end

NS_ASSUME_NONNULL_END
