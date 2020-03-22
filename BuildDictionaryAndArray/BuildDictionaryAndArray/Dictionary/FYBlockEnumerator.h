//
//  FYBlockEnumerator.h
//  BuildDictionaryAndArray
//
//  Created by Yu Fan on 2019/5/15.
//  Copyright © 2019 Yu Fan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FYBlockEnumerator : NSEnumerator {
    id (^_block)(void);
}
- (id)initWithBlock: (id (^)(void))block;
@end

NS_ASSUME_NONNULL_END
