//
//  UICollectionView+Placeholder.m
//  Runtime
//
//  Created by Yu Fan on 2019/5/23.
//  Copyright © 2019 Yu Fan. All rights reserved.
//

#import "UICollectionView+Placeholder.h"
#import "objc/runtime.h"
#import "NSObject+Swizzling.h"

@implementation UICollectionView (Placeholder)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleSelector:@selector(reloadData) withSwizzledSelector:@selector(placeholder_reloadData)];
    });
}

- (void)placeholder_reloadData {
    if (!self.firstReload) {
        [self checkDataEmpty];
    }
    self.firstReload = NO;
    [self placeholder_reloadData];
}

- (void)checkDataEmpty {
    BOOL isEmpty = YES;
    
    id <UICollectionViewDataSource> dataSource = self.dataSource;
    NSInteger sections = 1;
    if ([dataSource respondsToSelector:@selector(numberOfSectionsInCollectionView:)]) {
        sections = [dataSource numberOfSectionsInCollectionView:self] - 1;
    }
    
    for (NSInteger i = 0; i <= sections; i++) {
        NSInteger rows = [dataSource collectionView:self numberOfItemsInSection:i];
        if (rows) {
            isEmpty = NO;
        }
    }
    
    if (isEmpty) {
        // 默认
        if (!self.placeholderView) {
            [self addDefaultPlaceholderView];
        }
        // 没有 super 则添加
        if (!self.placeholderView.superview) {
            [self addSubview:self.placeholderView];
        }
        self.placeholderView.hidden = NO;
    } else {
        self.placeholderView.hidden = YES;
    }
}

- (void)addDefaultPlaceholderView {
    if (self.reloadBlock) {
        self.reloadBlock();
    }
}

#pragma mark - Associated
- (UIView *)placeholderView {
    return objc_getAssociatedObject(self, @selector(placeholderView));
}

- (void)setPlaceholderView:(UIView *)placeholderView {
    objc_setAssociatedObject(self, @selector(placeholderView), placeholderView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)firstReload {
    return [objc_getAssociatedObject(self, @selector(firstReload)) boolValue];
}

- (void)setFirstReload:(BOOL)firstReload {
    objc_setAssociatedObject(self, @selector(firstReload), @(firstReload), OBJC_ASSOCIATION_ASSIGN);
}

- (void (^)(void))reloadBlock {
    return objc_getAssociatedObject(self, @selector(reloadBlock));
}

- (void)setReloadBlock:(void (^)(void))reloadBlock {
    objc_setAssociatedObject(self, @selector(reloadBlock), reloadBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end
