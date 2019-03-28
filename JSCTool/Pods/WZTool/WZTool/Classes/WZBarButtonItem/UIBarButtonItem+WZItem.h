//
//  UIBarButtonItem+WZItem.h
//  BuDeJie
//
//  Created by 班文政 on 2019/2/26.
//  Copyright © 2019 班文政. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIBarButtonItem (WZItem)

/**
 创建一个有高亮状态的导航栏按钮

 @param image 普通状态下的按钮图标
 @param highImage 高亮状态下的按钮图标
 */
+ (UIBarButtonItem *)itemWithImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action;

/**
 创建一个有选择状态的导航栏按钮

 @param image 普通状态下的按钮图标
 @param selImage 选中状态的按钮图标
 */
+ (UIBarButtonItem *)itemWithImage:(UIImage *)image selImage:(UIImage *)selImage target:(id)target action:(SEL)action;

/**
 创建一个有选择状态的导航栏按钮
 
 @param title 普通状态下
 @param selTitle 选中状态
 */
+ (UIBarButtonItem *)itemWithTitle:(NSString *)title selTitle:(NSString *)selTitle titleColor:(UIColor *)titleColor selTitleColor:(UIColor *)selTitleColor font:(UIFont *)font target:(id)target action:(SEL)action;
@end

NS_ASSUME_NONNULL_END
