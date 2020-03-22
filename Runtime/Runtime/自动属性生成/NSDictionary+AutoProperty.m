//
//  NSDictionary+AutoProperty.m
//  Runtime
//
//  Created by Yu Fan on 2019/5/24.
//  Copyright © 2019 Yu Fan. All rights reserved.
//

#import "NSDictionary+AutoProperty.h"

@implementation NSDictionary (AutoProperty)

- (void)createPropetyCode {
    NSMutableString *codes = [NSMutableString string];
    // 遍历字典
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull value, BOOL * _Nonnull stop) {
        NSString *code = nil;
        if ([value isKindOfClass:[NSString class]]) {
            code = [NSString stringWithFormat:@"@property (nonatomic, strong) NSString *%@;",key];
        } else if ([value isKindOfClass:NSClassFromString(@"__NSCFBoolean")]){
            code = [NSString stringWithFormat:@"@property (nonatomic, assign) BOOL %@;",key];
        } else if ([value isKindOfClass:[NSNumber class]]) {
            code = [NSString stringWithFormat:@"@property (nonatomic, assign) NSInteger %@;",key];
        } else if ([value isKindOfClass:[NSArray class]]) {
            code = [NSString stringWithFormat:@"@property (nonatomic, strong) NSArray *%@;",key];
        } else if ([value isKindOfClass:[NSDictionary class]]) {
            code = [NSString stringWithFormat:@"@property (nonatomic, strong) NSDictionary *%@;",key];
        }
        // 拼接字符串
        [codes appendFormat:@"%@\n",code];
    }];
    // 输出内容，复制进行创建
    NSLog(@"%@",codes);
}

@end
