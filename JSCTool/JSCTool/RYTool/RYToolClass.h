//
//  RYToolClass.h
//  RefreshYouth
//
//  Created by 班文政 on 2018/10/30.
//  Copyright © 2018 班文政. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RYToolClass : NSObject

+ (UIColor *)getColorWithHexString: (NSString *)stringToConvert;

//从颜色获得图片
+(UIImage*) createImageWithColor:(UIColor*) color;

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

/**
 *  判断字符串是否为空
 */
+ (BOOL)isBlankString:(NSString *)aStr;
/**
 *  每3个字符串加一个,
 */
+ (NSString *)insertSpacesEveryFourDigitsIntoString:(NSString *)string value:(int)value;

/**
 网络请求参数加密
 
 @param dict 未加密字段
 @return 加密字段
 */
+ (NSDictionary *)md5ParameterWithDict:(NSDictionary *)dict;


/**
 *  手机UUID
 */
+ (NSString *)getUUID;
/**
 *  版本号
 */
+ (NSString *)getVersion;


/**
 获取当前时间戳
 */
+(NSString *)getNowTimeTimestamp;


/**
 拨打电话

 @param phone 电话
 */
+ (void)telPhone:(NSString *)phone;


/**
判断手机号码格式是否正确

@param mobile 判断手机号码格式是否正确
*/
+ (BOOL)valiMobile:(NSString *)mobile;
    
    
/**
 判断手机号码格式是否正确
 
 @param mobile 判断手机号码格式是否正确
 */
+ (BOOL)isBankCard:(NSString *)cardNumber;
@end

NS_ASSUME_NONNULL_END
