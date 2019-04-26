//
//  UIButton+RYExtensions.h
//  RefreshYouth
//
//  Created by 班文政 on 2018/10/30.
//  Copyright © 2018 班文政. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (RYExtensions)

/**
 上部分是图片，下部分是文字
 @param space 间距
 */
- (void)setUpImageAndDownLableWithSpace:(CGFloat)space;


/**
 左边是文字，右边是图片（和原来的样式翻过来）
 @param space 间距
 */
- (void)setLeftTitleAndRightImageWithSpace:(CGFloat)space;


/**
 设置角标的个数（右上角）
 @param badgeValue 角标数字
 */
- (void)setBadgeValue:(NSInteger)badgeValue;


/**
 自定义button
 
 @param normalTitle 普通状态下的文字
 @param selectTitle 选中状态下的文字
 @param normalImg b普通状态下的图片
 @param selectImg 选中状态下的图片
 @param normalTitleColor 普通状态下文字颜色
 @param selectTitleColor 选中状态下文字颜色
 @param font 字体大小
 @param backGroundColor 背景色
 @param superView 添加的父控件
 @return 返回一个按钮
 */
+ (instancetype)buttonWithNormalTitle:(NSString *)normalTitle selectTitle:(NSString *)selectTitle normalImg:(UIImage *)normalImg selectImg:(UIImage *)selectImg normalTitleColor:(UIColor *)normalTitleColor selectTitleColor:(UIColor *)selectTitleColor font:(UIFont *)font backGroundColor:(UIColor *)backGroundColor superView:(UIView *)superView;

@end

NS_ASSUME_NONNULL_END
