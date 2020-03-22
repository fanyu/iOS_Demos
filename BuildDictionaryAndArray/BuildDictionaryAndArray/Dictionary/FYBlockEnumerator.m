//
//  FYBlockEnumerator.m
//  BuildDictionaryAndArray
//
//  Created by Yu Fan on 2019/5/15.
//  Copyright © 2019 Yu Fan. All rights reserved.
//

#import "FYBlockEnumerator.h"

@implementation FYBlockEnumerator
- (id)initWithBlock: (id (^)(void))block {
    if((self = [self init]))
        _block = [block copy];
    return self;
}

- (id)nextObject {
    return _block();
}
@end
