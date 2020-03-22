//
//  WeiboCell.h
//  WeiboList
//
//  Created by Yu Fan on 2019/5/17.
//  Copyright © 2019 Yu Fan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYKit.h"
#import "WeiboUser.h"
#import "WeiboLayout.h"

@class WeiboCell;
@protocol WeiboCellDelegate <NSObject>
@optional
/// 点击cell
- (void)cellDidTap:(WeiboCell *)cell;
/// 点击Card
- (void)cellDidTapCard:(WeiboCell *)cell;
/// 点击转发内容
- (void)cellDidTapRetweet:(WeiboCell *)cell;
/// 点击菜单
- (void)cellDidTapMenu:(WeiboCell *)cell;
/// 点击关注
- (void)cellDidTapFollow:(WeiboCell *)cell;
/// 点击转发
- (void)cellDidTapRepost:(WeiboCell *)cell;
/// 点击评论
- (void)cellDIdTapComment:(WeiboCell *)cell;
/// 点击赞
- (void)cellDidTapLike:(WeiboCell *)cell;
/// 点击Tag
- (void)cellDidTapTag:(WeiboCell *)cell;
/// 点击用户
- (void)cell:(WeiboCell *)cell didTapUser:(WeiboUser *)user;
/// 点击图片
- (void)cell:(WeiboCell *)cell didTapImageAtIndex:(NSUInteger)index;
/// 点击链接
- (void)cell:(WeiboCell *)cell didTapLabel:(YYLabel *)label textRange:(NSRange)textRange;
@end

NS_ASSUME_NONNULL_BEGIN

@interface WeiboCell : UITableViewCell
@property (nonatomic, weak) id<WeiboCellDelegate> delegate;
@property (nonatomic, strong) WeiboLayout *layout;
@end

NS_ASSUME_NONNULL_END
