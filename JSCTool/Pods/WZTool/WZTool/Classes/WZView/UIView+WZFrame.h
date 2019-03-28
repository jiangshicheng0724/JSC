//
//  UIView+WZFrame.h
//  BuDeJie
//
//  Created by 班文政 on 2019/2/26.
//  Copyright © 2019 班文政. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (WZFrame)

@property CGFloat wz_width;
@property CGFloat wz_height;
@property CGFloat wz_x;
@property CGFloat wz_y;
@property CGFloat wz_centerY;
@property CGFloat wz_centerX;

+ (instancetype)wz_viewFromXib;

@end

NS_ASSUME_NONNULL_END
