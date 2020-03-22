//
//  RaderModel.h
//  RadarView
//
//  Created by Yu Fan on 2019/5/27.
//  Copyright © 2019 Yu Fan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RadarItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface RaderModel : NSObject
@property (nonatomic, strong) NSArray<RadarItem *> *items;
@property (nonatomic, strong) UIColor *coverColor;
@end

NS_ASSUME_NONNULL_END
