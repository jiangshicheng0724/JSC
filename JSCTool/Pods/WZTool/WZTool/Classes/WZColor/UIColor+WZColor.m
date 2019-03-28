//
//  UIColor+WZColor.m
//  ZSPeopleConnectedInternet
//
//  Created by 班文政 on 2019/3/12.
//  Copyright © 2019 班文政. All rights reserved.
//

#import "UIColor+WZColor.h"

@implementation UIColor (WZColor)

//16进制颜色(html颜色值)字符串转为UIColor
+(UIColor *)getColorWithHexString:(NSString *)stringToConvert alpha:(CGFloat)alpha {
    //删除字符串中的空格
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6)
    {
        return [UIColor blackColor];
    }
    // strip 0X if it appears
    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"])
    {
        cString = [cString substringFromIndex:2];
    }
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"])
    {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6)
    {
        return [UIColor blackColor];
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
    
}

//默认alpha值为1
+ (UIColor *)getColorWithHexString:(NSString *)stringToConvert {
    return [self getColorWithHexString:stringToConvert alpha:1.0f];
}


//渐变色
+ (UIColor *)getGradientRed:(CGFloat)a green:(CGFloat)b blue:(CGFloat)c alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:((10 * a) / 255.0) green:((20 * b)/255.0) blue:((30 * c)/255.0) alpha:alpha];
}

//随机色
+ (UIColor *)getRandomColorAlpha:(CGFloat)alpha {
    return [UIColor colorWithRed:arc4random() % 256 / 255.0 green: arc4random() % 256 / 255.0 blue: arc4random() % 256 / 255.0 alpha:alpha];
}

@end
