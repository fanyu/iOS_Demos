//
//  UIImage+SetImageResult.m
//  Runtime
//
//  Created by Yu Fan on 2019/5/21.
//  Copyright © 2019 Yu Fan. All rights reserved.
//

#import "UIImage+SetImageResult.h"
#import "objc/message.h"

@implementation UIImage (SetImageResult)

+ (void)load {
    // 方法交换
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method originalMethod = class_getClassMethod(self, @selector(imageNamed:));
        Method swizzingMethod = class_getClassMethod(self, @selector(result_imageNamed:));
        method_exchangeImplementations(originalMethod, swizzingMethod);
    });
}

- (UIImage *)result_imageNamed:(NSString *)name {
    UIImage *image = [self result_imageNamed:name];
    if (image) {
        NSLog(@"load success");
    } else {
        NSLog(@"load failed");
    }
    return image;
}

@end
