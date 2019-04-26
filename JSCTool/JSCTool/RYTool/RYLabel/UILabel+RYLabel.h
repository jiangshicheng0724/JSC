//
//  UILabel+RYLabel.h
//  RefreshYouth
//
//  Created by 班文政 on 2018/10/31.
//  Copyright © 2018 班文政. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (RYLabel)
/**
 创建一个label
 
 @param text 内容
 @param font 字体大小
 @param textColor 字体颜色
 @param backGroundColor 背景颜色
 @param superView 添加的父控件
 @return 返回一个label
 */
+ (instancetype)labelWithText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor backGroundColor:(UIColor *)backGroundColor superView:(UIView *)superView;

/**
 *  改变行间距
 */
+ (void)changeLineSpaceForLabel:(UILabel *)label WithSpace:(float)space;

/**
 *  改变字间距
 */
+ (void)changeWordSpaceForLabel:(UILabel *)label WithSpace:(float)space;

/**
 *  改变行间距和字间距
 */
+ (void)changeSpaceForLabel:(UILabel *)label withLineSpace:(float)lineSpace WordSpace:(float)wordSpace;

@end

NS_ASSUME_NONNULL_END
