//
//  WeiboProfileView.m
//  WeiboList
//
//  Created by Yu Fan on 2019/5/17.
//  Copyright © 2019 Yu Fan. All rights reserved.
//

#import "WeiboProfileView.h"
#import "YYKit.h"
#import "WeiboLayout.h"

@interface WeiboProfileView () 
@property (nonatomic, strong) UIImageView *avatarView;
@property (nonatomic, strong) UIImageView *avatarBadgeView;
@property (nonatomic, strong) YYLabel *nameLabel;
@property (nonatomic, strong) YYLabel *sourceLabel;
@end

@implementation WeiboProfileView {
    BOOL _trackingTouch;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (frame.size.width == 0 && frame.size.height == 0) {
        frame.size.width = kScreenWidth;
        frame.size.height = kWBCellProfileHeight;
    }
    
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    
    return self;
}

#pragma mark - UI
- (void)setupUI {
    // 禁止多个按键同时点击
    self.exclusiveTouch = YES;
    WEAK_SELF
    self.avatarView = [UIImageView new];
    self.avatarView.size = CGSizeMake(40, 40);
    self.avatarView.origin = CGPointMake(kWBCellPadding, kWBCellPadding);
    self.avatarView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:self.avatarView];
    
    CALayer *avatarBorder = [CALayer layer];
    avatarBorder.frame = self.avatarView.frame;
    avatarBorder.borderWidth = CGFloatToPixel(1);
    avatarBorder.borderColor = [UIColor colorWithWhite:0.000 alpha:0.090].CGColor;
    avatarBorder.cornerRadius = self.avatarView.height / 2;
    avatarBorder.shouldRasterize = YES;
    avatarBorder.rasterizationScale = kScreenScale;
    [self.avatarView.layer addSublayer:avatarBorder];
    
    self.avatarBadgeView = [UIImageView new];
    self.avatarBadgeView.size = CGSizeMake(14, 14);
    self.avatarBadgeView.center = CGPointMake(self.avatarView.right - 6, self.avatarView.bottom - 6);
    self.avatarBadgeView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:self.avatarBadgeView];
    
    self.nameLabel = [YYLabel new];
    self.nameLabel.size = CGSizeMake(kWBCellNameWidth, 24);
    self.nameLabel.left = self.avatarView.right + kWBCellNamePaddingLeft;
    self.nameLabel.centerY = 27;
    self.nameLabel.displaysAsynchronously = YES;
    self.nameLabel.ignoreCommonProperties = YES;
    self.nameLabel.fadeOnAsynchronouslyDisplay = NO;
    self.nameLabel.fadeOnHighlight = NO;
    self.nameLabel.lineBreakMode = NSLineBreakByClipping;
    self.nameLabel.textVerticalAlignment = YYTextVerticalAlignmentCenter;
    [self addSubview:self.nameLabel];
    
    self.sourceLabel = [YYLabel new];
    self.sourceLabel.frame = _nameLabel.frame;
    self.sourceLabel.centerY = 47;
    self.sourceLabel.displaysAsynchronously = YES;
    self.sourceLabel.ignoreCommonProperties = YES;
    self.sourceLabel.fadeOnAsynchronouslyDisplay = NO;
    self.sourceLabel.fadeOnHighlight = NO;
    self.sourceLabel.highlightTapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
        STRONG_SELF
        if ([self.cell.delegate respondsToSelector:@selector(cell:didTapLabel:textRange:)]) {
            [self.cell.delegate cell:self.cell didTapLabel:(YYLabel *)containerView textRange:range];
        }
    };
    [self addSubview:self.sourceLabel];
}

- (void)setVerifyType:(WeiboUserVerifyType)verifyType {
    _verifyType = verifyType;
    switch (verifyType) {
        case WeiboUserVerifyTypeStandard: {
            self.avatarBadgeView.hidden = NO;
            self.avatarBadgeView.image = [WeiboHelper imageNamed:@"avatar_vip"];
            break;
        }
            
        case WeiboUserVerifyTypeClub: {
            self.avatarBadgeView.hidden = NO;
            self.avatarBadgeView.image = [WeiboHelper imageNamed:@"avatar_grassroot"];
            break;
        }
        default: {
            self.avatarBadgeView.hidden = YES;
            break;
        }
    }
}

#pragma mark - 不添加点击事件，直接用touch来判断点击位置
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    _trackingTouch = NO;
    UITouch *t = touches.anyObject;
    CGPoint p = [t locationInView:_avatarView];
    if (CGRectContainsPoint(_avatarView.bounds, p)) {
        _trackingTouch = YES;
    }
    p = [t locationInView:_nameLabel];
    if (CGRectContainsPoint(_nameLabel.bounds, p) && _nameLabel.textLayout.textBoundingRect.size.width > p.x) {
        _trackingTouch = YES;
    }
    if (!_trackingTouch) {
        [super touchesBegan:touches withEvent:event];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (!_trackingTouch) {
        [super touchesEnded:touches withEvent:event];
    } else {
        if ([self.cell.delegate respondsToSelector:@selector(cell:didTapUser:)]) {
            [self.cell.delegate cell:self.cell didTapUser:self.cell.layout.weibo.user];
        }
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    if (!_trackingTouch) {
        [super touchesCancelled:touches withEvent:event];
    }
}
@end
