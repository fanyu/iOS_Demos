//
//  NSObject+Model.m
//  Runtime
//
//  Created by Yu Fan on 2019/5/21.
//  Copyright © 2019 Yu Fan. All rights reserved.
//

#import "NSObject+Model.h"
#import "objc/message.h"

@implementation NSObject (Model)

// 思路：利用 runtime 遍历模型中所有属性，根据模型中属性, 去字典中取出对应的value给模型属性赋值

// @{@"mapKey" : @"originalKey"}
+ (NSDictionary *)keyMapper {
    return @{};
}

+ (instancetype)modelWithDict:(NSDictionary *)dict {
    // 创建 objc
    id objc = [[self alloc] init];
    // 获取所有变量
    unsigned int count = 0;
    Ivar *ivarList = class_copyIvarList(self, &count);
    // 遍历所有成员变量
    for (int i = 0; i < count; i++) {
        // 取出成员变量
        Ivar ivar = ivarList[i];
        
        // 获取名字 去掉 _  Ivar：成员变量,以下划线开头
        NSString *ivarName = [NSString stringWithUTF8String:ivar_getName(ivar)];
        NSString *key = [ivarName substringFromIndex:1];
        
        // 获取类型 替换: @\"Person\" -> Person
        NSString *ivarType = [NSString stringWithUTF8String:ivar_getTypeEncoding(ivar)];
        ivarType = [ivarType stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        ivarType = [ivarType stringByReplacingOccurrencesOfString:@"@" withString:@""];
        
        // 是否有映射Key
        NSString *tempKey = key;
        if ([self keyMapper].count) {
            NSArray *mapKeys = [[self keyMapper] allKeys];
            if ([mapKeys containsObject:key]) {
                tempKey = [self keyMapper][key];
            }
        }
    
        // 从字典中取值 value
        id value = dict[tempKey];
        
        // value 是字典, 并且是自定义对象才需要转换
        if ([value isKindOfClass:[NSDictionary class]] && ![ivarType hasPrefix:@"NS"]) {
            Class classModel = NSClassFromString(ivarType);
            if (classModel) {
                value = [classModel modelWithDict:value];
            }
        }
        
        // value 是数组, 并且数组元素里是字典,  NSArray<protocol>
        if ([value isKindOfClass:[NSArray class]] &&
            [[(NSArray *)value firstObject] isKindOfClass:[NSDictionary class]] &&
            [ivarType containsString:@"<"]) {
            
            NSString *protocolName = [ivarType componentsSeparatedByString:@"<"].lastObject;
            protocolName = [protocolName componentsSeparatedByString:@">"].firstObject;
            
            Class classModel = NSClassFromString(protocolName);
            NSMutableArray *arrays = [NSMutableArray array];
            for (NSDictionary *dict in value) {
                id model = [classModel modelWithDict:dict];
                [arrays addObject:model];
            }
            value = arrays;
        }
        
        // 给 key 设置 value
        if (value) {
            [objc setValue:value forKey:key];
        }
    }
    
    return objc;
}

+ (instancetype)modelWithJSON:(id)json {
    NSDictionary *dict = [self _dictionaryWithJSON:json];
    return [self modelWithDict:dict];
}

+ (NSDictionary *)_dictionaryWithJSON:(id)json {
    if (!json || json == (id)kCFNull) return nil;
    NSDictionary *dic = nil;
    NSData *jsonData = nil;
    // 字典类型
    if ([json isKindOfClass:[NSDictionary class]]) {
        dic = json;
    }
    // string 类型
    else if ([json isKindOfClass:[NSString class]]) {
        jsonData = [(NSString *)json dataUsingEncoding: NSUTF8StringEncoding];
    }
    // data 类型
    else if ([json isKindOfClass:[NSData class]]) {
        jsonData = json;
    }
    // 序列化
    if (jsonData) {
        dic = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:NULL];
        if (![dic isKindOfClass:[NSDictionary class]]) dic = nil;
    }
    
    return dic;
}

@end
