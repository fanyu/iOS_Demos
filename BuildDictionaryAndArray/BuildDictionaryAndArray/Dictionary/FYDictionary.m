//
//  FYDictionary.m
//  BuildDictionaryAndArray
//
//  Created by Yu Fan on 2019/5/15.
//  Copyright © 2019 Yu Fan. All rights reserved.
//

#import "FYDictionary.h"

#pragma mark - FYDictionary

@interface FYDictionary ()
@property (nonatomic, assign) NSUInteger size;
@property (nonatomic, assign) NSUInteger count;
@property (nonatomic, strong) NSMapTable *mapTable;
@end

@implementation FYDictionary

- (id)initWithSize:(NSUInteger)size {
    if (self = [super init]) {
        self.size = size;
        self.mapTable = [[NSMapTable alloc] init];
    }
    return self;
}

- (id)objectForKey:(id)key {
    NSUInteger bucketIndex = [key hash] % self.size;
    FYDictionaryBucket *bucket = [self.mapTable objectForKey:@(bucketIndex)];
    while (bucket) {
        if ([bucket.key isEqual:key]) {
            return bucket;
        }
        bucket = bucket.next;
    }
    return nil;
}

- (void)setObject:(id)obj forKey:(id)key {
    FYDictionaryBucket *newBucket = [[FYDictionaryBucket alloc] init];
    newBucket.key = key;
    newBucket.obj = obj;
    
    NSUInteger bucketIndex = [key hash] % self.size;
    
    FYDictionaryBucket *bucket = [self.mapTable objectForKey:@(bucketIndex)];
    FYDictionaryBucket *preBucket = nil;
    if (bucket) {
        while (bucket) {
            if ([bucket.key isEqual:key]) {
                bucket.obj = obj;
                return;
            }
            preBucket = bucket;
            bucket = bucket.next;
        }
        
        preBucket.next = newBucket;
        
    } else {
        [self.mapTable setObject:newBucket forKey:@(bucketIndex)];
    }
}

- (void)removeObjectForKey:(id)key {
    NSUInteger bucketIndex = [key hash] % self.size;
    FYDictionaryBucket *preBucket = nil;
    FYDictionaryBucket *bucket = [self.mapTable objectForKey:@(bucketIndex)];
    while (bucket) {
        if ([bucket.key isEqual:key]) {
            // 第一个就是要移除的对象
            if (preBucket == nil) {
                FYDictionaryBucket *next = bucket.next;
                [self.mapTable setObject:next forKey:@(bucketIndex)];
            } else {
                preBucket.next = bucket.next;
            }
            bucket = nil;
            return;
        }
        preBucket = bucket;
        bucket = bucket.next;
    }
}

@end
