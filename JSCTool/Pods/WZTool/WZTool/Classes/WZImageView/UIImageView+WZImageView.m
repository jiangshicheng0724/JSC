//
//  UIImageView+WZImageView.m
//  Pods-WZTool_Tests
//
//  Created by 班文政 on 2019/3/13.
//

#import "UIImageView+WZImageView.h"

@implementation UIImageView (WZImageView)

+ (instancetype)imageViewWithSuperView:(UIView *)superView;
{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    [superView addSubview:imageView];
    return imageView;
}
@end
