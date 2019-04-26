//
//  UIButton+RYExtensions.m
//  RefreshYouth
//
//  Created by 班文政 on 2018/10/30.
//  Copyright © 2018 班文政. All rights reserved.
//

#import "UIButton+RYExtensions.h"

@implementation UIButton (RYExtensions)
/**
 上部分是图片，下部分是文字
 
 @param space 间距
 */
- (void)setUpImageAndDownLableWithSpace:(CGFloat)space{
    
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    
    // titleLabel的宽度不一定正确的时候，需要进行判断
    CGFloat labelWidth = self.titleLabel.intrinsicContentSize.width;
    if (titleSize.width < labelWidth) {
        titleSize.width = labelWidth;
    }
    
    // 文字距上边框的距离增加imageView的高度+间距，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
    [self setTitleEdgeInsets:UIEdgeInsetsMake(imageSize.height, -imageSize.width, -space, 0.0)];
    
    // 图片距右边框的距离减少图片的宽度，距离上面的间隔，其它不变
    [self setImageEdgeInsets:UIEdgeInsetsMake(-space*2, 0,0.0,-titleSize.width)];
    
//    CGPoint imageCenter = self.imageView.center;
//    imageCenter.x = self.frame.size.width/2;
//    imageCenter.y = (self.frame.size.height-self.imageView.frame.size.height)/2;
//    self.imageView.center = imageCenter;
    //
    //    // 更改label的中心坐标
    //    CGRect labelFrame = self.titleLabel.frame;
    //    labelFrame.origin.x = 0;
    //    labelFrame.origin.y = CGRectGetMaxY(self.imageView.frame) + space;
    //    labelFrame.size.width = self.frame.size.width;
    //
    //    self.titleLabel.frame = labelFrame;
    //    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
}

/**
 左边是文字，右边是图片（和原来的样式翻过来）
 
 @param space 间距
 */
- (void)setLeftTitleAndRightImageWithSpace:(CGFloat)space{
    
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    
    // titleLabel的宽度不一定正确的时候，需要进行判断
    CGFloat labelWidth = self.titleLabel.intrinsicContentSize.width;
    if (titleSize.width < labelWidth) {
        titleSize.width = labelWidth;
    }
    
    // 文字距左边框的距离减少imageView的宽度-间距，右侧增加距离imageView的宽度
    [self setTitleEdgeInsets:UIEdgeInsetsMake(0.0, -imageSize.width - space, 0.0, imageSize.width)];
    
    // 图片距左边框的距离增加titleLable的宽度,距右边框的距离减少titleLable的宽度
    [self setImageEdgeInsets:UIEdgeInsetsMake(0.0, titleSize.width,0.0,-titleSize.width)];
}

/**
 设置角标的个数（右上角）
 
 @param badgeValue 角标数字
 */
- (void)setBadgeValue:(NSInteger)badgeValue{
    
    CGFloat badgeW   = 12;
    CGSize imageSize = self.imageView.frame.size;
    CGFloat imageX   = self.imageView.frame.origin.x;
    CGFloat imageY   = self.imageView.frame.origin.y;
    
    UILabel *badgeLable = [[UILabel alloc]init];
    badgeLable.text = [NSString stringWithFormat:@"%ld",(long)badgeValue];
    badgeLable.textAlignment = NSTextAlignmentCenter;
    badgeLable.textColor = [UIColor whiteColor];
    badgeLable.font = [UIFont systemFontOfSize:12];
    badgeLable.layer.cornerRadius = badgeW*0.5;
    badgeLable.clipsToBounds = YES;
    badgeLable.backgroundColor = [UIColor redColor];
    
    CGFloat badgeX = imageX + imageSize.width - badgeW*0.5;
    CGFloat badgeY = imageY - badgeW*0.25;
    badgeLable.frame = CGRectMake(badgeX, badgeY, badgeW, badgeW);
    [self addSubview:badgeLable];
}


+ (instancetype)buttonWithNormalTitle:(NSString *)normalTitle selectTitle:(NSString *)selectTitle normalImg:(UIImage *)normalImg selectImg:(UIImage *)selectImg normalTitleColor:(UIColor *)normalTitleColor selectTitleColor:(UIColor *)selectTitleColor font:(UIFont *)font backGroundColor:(UIColor *)backGroundColor superView:(UIView *)superView
{
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:normalTitle forState:UIControlStateNormal];
    [button setTitle:selectTitle forState:UIControlStateSelected];
    [button setImage:normalImg forState:UIControlStateNormal];
    [button setImage:selectImg forState:UIControlStateSelected];
    [button setTitleColor:normalTitleColor forState:UIControlStateNormal];
    [button setTitleColor:selectTitleColor forState:UIControlStateSelected];
    button.titleLabel.font = font;
    button.backgroundColor = backGroundColor;
    [superView addSubview:button];
    return button;
}
@end
