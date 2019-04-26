//
//  UIImageView+RYImageView.m
//  RefreshYouth
//
//  Created by 班文政 on 2018/10/30.
//  Copyright © 2018 班文政. All rights reserved.
//

#import "UIImageView+RYImageView.h"

@implementation UIImageView (RYImageView)

+ (instancetype)imageViewWithSuperView:(UIView *)superView;
{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    [superView addSubview:imageView];
    return imageView;
}

@end
