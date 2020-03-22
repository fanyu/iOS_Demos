//
//  WeiboToolbarView.h
//  WeiboList
//
//  Created by Yu Fan on 2019/5/17.
//  Copyright © 2019 Yu Fan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class WeiboCell;

@interface WeiboToolbarView : UIView
@property (nonatomic, weak) WeiboCell *cell;

- (void)setWithLayout:(WeiboLayout *)layout;
- (void)setLiked:(BOOL)liked withAnimation:(BOOL)animation;
@end

NS_ASSUME_NONNULL_END
