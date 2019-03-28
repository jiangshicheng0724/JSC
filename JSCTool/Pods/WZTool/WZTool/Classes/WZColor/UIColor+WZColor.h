//
//  UIColor+WZColor.h
//  ZSPeopleConnectedInternet
//
//  Created by 班文政 on 2019/3/12.
//  Copyright © 2019 班文政. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (WZColor)

+ (UIColor *)getColorWithHexString: (NSString *)stringToConvert;

/**
 *  可定义透明度
 *
 *  @param stringToConvert 十六进制颜色值
 *  @param alpha           颜色的透明度[0,1]
 *
 *  @return RGB颜色
 */
+(UIColor *)getColorWithHexString:(NSString *)stringToConvert alpha:(CGFloat)alpha;

/**
 *  渐变色
 *
 *  @param a     红色系数
 *  @param b     绿色系数
 *  @param c     蓝色色系数
 *  @param alpha 透明度
 *
 *  @return UIColor
 */
+ (UIColor *)getGradientRed:(CGFloat)a green:(CGFloat)b blue:(CGFloat)c alpha:(CGFloat)alpha;

/**
 *  随机色
 *
 *  @param alpha 透明度
 *
 *  @return UIColor
 */
+ (UIColor *)getRandomColorAlpha:(CGFloat)alpha;

@end

NS_ASSUME_NONNULL_END
