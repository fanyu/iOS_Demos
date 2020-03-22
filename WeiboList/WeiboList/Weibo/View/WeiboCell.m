//
//  WeiboCell.m
//  WeiboList
//
//  Created by Yu Fan on 2019/5/17.
//  Copyright © 2019 Yu Fan. All rights reserved.
//

#import "WeiboCell.h"
#import "WeiboProfileView.h"
#import "WeiboCardView.h"
#import "WeiboTagView.h"
#import "WeiboToolbarView.h"
#import "WeiboImageView.h"

@interface WeiboCell ()
@property (nonatomic, strong) UIView *wrapView;
@property (nonatomic, strong) WeiboProfileView *profileView;
@property (nonatomic, strong) YYLabel *contentLabel;
@property (nonatomic, strong) NSArray<UIView *> *photoViews;
@property (nonatomic, strong) UIView *retweetContentView;
@property (nonatomic, strong) YYLabel *retweetContentLabel;
@property (nonatomic, strong) WeiboCardView *cardView;
@property (nonatomic, strong) WeiboTagView *tagView;
@property (nonatomic, strong) WeiboToolbarView *toolbarView;
@property (nonatomic, strong) UIButton *menuButton;
@property (nonatomic, strong) UIButton *followButton;  
@end

@implementation WeiboCell
{
    BOOL _touchRetweetView;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)setupUI {
    self.backgroundColor = [UIColor clearColor];
    self.exclusiveTouch = YES;
    
    @weakify(self);
    
    self.wrapView = [UIView new];
    self.wrapView.width = kScreenWidth;
    self.wrapView.height = 1;
    self.wrapView.backgroundColor = [UIColor whiteColor];
    
    static UIImage *topLineBG, *bottomLineBG;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        topLineBG = [UIImage imageWithSize:CGSizeMake(1, 3) drawBlock:^(CGContextRef context) {
            CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
            CGContextSetShadowWithColor(context, CGSizeMake(0, 0), 0.8, [UIColor colorWithWhite:0 alpha:0.08].CGColor);
            CGContextAddRect(context, CGRectMake(-2, 3, 4, 4));
            CGContextFillPath(context);
        }];
        bottomLineBG = [UIImage imageWithSize:CGSizeMake(1, 3) drawBlock:^(CGContextRef context) {
            CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
            CGContextSetShadowWithColor(context, CGSizeMake(0, 0.4), 2, [UIColor colorWithWhite:0 alpha:0.08].CGColor);
            CGContextAddRect(context, CGRectMake(-2, -2, 4, 2));
            CGContextFillPath(context);
        }];
    });
    
    UIImageView *topLine = [[UIImageView alloc] initWithImage:topLineBG];
    topLine.width = self.wrapView.width;
    topLine.bottom = 0;
    topLine.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
    [self.wrapView addSubview:topLine];
    
    
    UIImageView *bottomLine = [[UIImageView alloc] initWithImage:bottomLineBG];
    bottomLine.width = self.wrapView.width;
    bottomLine.top = self.wrapView.height;
    bottomLine.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    [self.wrapView addSubview:bottomLine];
    [self addSubview:self.wrapView];

    
    _profileView = [WeiboProfileView new];
    [self.wrapView addSubview:_profileView];
    
    _menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _menuButton.size = CGSizeMake(30, 30);
    [_menuButton setImage:[WeiboHelper imageNamed:@"timeline_icon_more"] forState:UIControlStateNormal];
    [_menuButton setImage:[WeiboHelper imageNamed:@"timeline_icon_more_highlighted"] forState:UIControlStateHighlighted];
    _menuButton.centerX = self.width - 20;
    _menuButton.centerY = 18;
    [_menuButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(id sender) {
     
    }];
    [self.wrapView addSubview:_menuButton];
    
    _retweetContentView = [UIView new];
    _retweetContentView.backgroundColor = kWBCellInnerViewColor;
    _retweetContentView.width = kScreenWidth;
    [self.wrapView addSubview:_retweetContentView];
    
    self.contentLabel = [YYLabel new];
    self.contentLabel.left = kWBCellPadding;
    self.contentLabel.width = kWBCellContentWidth;
    self.contentLabel.textVerticalAlignment = YYTextVerticalAlignmentTop;
    self.contentLabel.displaysAsynchronously = YES;
    self.contentLabel.ignoreCommonProperties = YES;
    self.contentLabel.fadeOnAsynchronouslyDisplay = NO;
    self.contentLabel.fadeOnHighlight = NO;
    self.contentLabel.highlightTapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
        
    };
    [self.wrapView addSubview:self.contentLabel];
    
    _retweetContentLabel = [YYLabel new];
    _retweetContentLabel.left = kWBCellPadding;
    _retweetContentLabel.width = kWBCellContentWidth;
    _retweetContentLabel.textVerticalAlignment = YYTextVerticalAlignmentTop;
    _retweetContentLabel.displaysAsynchronously = YES;
    _retweetContentLabel.ignoreCommonProperties = YES;
    _retweetContentLabel.fadeOnAsynchronouslyDisplay = NO;
    _retweetContentLabel.fadeOnHighlight = NO;
    _retweetContentLabel.highlightTapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
      
    };
    [self.wrapView addSubview:_retweetContentLabel];
    
    NSMutableArray *picViews = [NSMutableArray new];
    for (int i = 0; i < 9; i++) {
        WeiboImageView *imageView = [WeiboImageView new];
        imageView.size = CGSizeMake(100, 100);
        imageView.hidden = YES;
        imageView.clipsToBounds = YES;
        imageView.backgroundColor = kWBCellHighlightColor;
        imageView.exclusiveTouch = YES;
        imageView.touchBlock = ^(WeiboImageView *view, YYGestureRecognizerState state, NSSet *touches, UIEvent *event) {
            if (![weak_self.delegate respondsToSelector:@selector(cell:didTapImageAtIndex:)]) return;
            if (state == YYGestureRecognizerStateEnded) {
                UITouch *touch = touches.anyObject;
                CGPoint p = [touch locationInView:view];
                if (CGRectContainsPoint(view.bounds, p)) {
                    [weak_self.delegate cell:weak_self didTapImageAtIndex:i];
                }
            }
        };
        
        UIView *badge = [UIImageView new];
        badge.userInteractionEnabled = NO;
        badge.contentMode = UIViewContentModeScaleAspectFit;
        badge.size = CGSizeMake(56 / 2, 36 / 2);
        badge.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin;
        badge.right = imageView.width;
        badge.bottom = imageView.height;
        badge.hidden = YES;
        [imageView addSubview:badge];
        
        [picViews addObject:imageView];
        [_wrapView addSubview:imageView];
    }
    _photoViews = picViews;
    
    _cardView = [WeiboCardView new];
    _cardView.hidden = YES;
    [_wrapView addSubview:_cardView];
    
    _tagView = [WeiboTagView new];
    _tagView.left = kWBCellPadding;
    _tagView.hidden = YES;
    [_wrapView addSubview:_tagView];
    
    _toolbarView = [WeiboToolbarView new];
    [_wrapView addSubview:_toolbarView];
}

- (void)setLayout:(WeiboLayout *)layout {
    _layout = layout;
}

#pragma mark - 选中 转发 或者 原微博 的手势处理，以及选中状态背景色改变

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = touches.anyObject;
    CGPoint p = [touch locationInView:_retweetContentView];
    BOOL insideRetweet = CGRectContainsPoint(_retweetContentView.bounds, p);
    
    if (!_retweetContentView.hidden && insideRetweet) {
        [(_retweetContentView) performSelector:@selector(setBackgroundColor:) withObject:kWBCellHighlightColor afterDelay:0.15];
        _touchRetweetView = YES;
    } else {
        [(_wrapView) performSelector:@selector(setBackgroundColor:) withObject:kWBCellHighlightColor afterDelay:0.15];
        _touchRetweetView = NO;
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self touchesRestoreBackgroundColor];
    if (_touchRetweetView) {
        if ([self.delegate respondsToSelector:@selector(cellDidTapRetweet:)]) {
            [self.delegate cellDidTapRetweet:self];
        }
    } else {
        if ([self.delegate respondsToSelector:@selector(cellDidTap:)]) {
            [self.delegate cellDidTap:self];
        }
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [self touchesRestoreBackgroundColor];
}

- (void)touchesRestoreBackgroundColor {
    [NSObject cancelPreviousPerformRequestsWithTarget:_retweetContentView selector:@selector(setBackgroundColor:) object:kWBCellHighlightColor];
    [NSObject cancelPreviousPerformRequestsWithTarget:_wrapView selector:@selector(setBackgroundColor:) object:kWBCellHighlightColor];
    
    _wrapView.backgroundColor = [UIColor whiteColor];
    _retweetContentView.backgroundColor = kWBCellInnerViewColor;
}

@end
