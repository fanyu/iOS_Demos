//
//  UITableView+Placeholder.h
//  Runtime
//
//  Created by Yu Fan on 2019/5/23.
//  Copyright © 2019 Yu Fan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (Placeholder)
@property (nonatomic, assign) BOOL firstReload;
@property (nonatomic, strong) UIView *placeholderView;
@property (nonatomic, copy) void (^reloadBlock) (void);
@end

NS_ASSUME_NONNULL_END
