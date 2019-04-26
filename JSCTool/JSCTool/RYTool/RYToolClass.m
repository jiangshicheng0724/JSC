//
//  RYToolClass.m
//  RefreshYouth
//
//  Created by 班文政 on 2018/10/30.
//  Copyright © 2018 班文政. All rights reserved.
//

#import "RYToolClass.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>


@implementation RYToolClass

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

//从颜色获得图片
+(UIImage*) createImageWithColor:(UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

//渐变色
+ (UIColor *)getGradientRed:(CGFloat)a green:(CGFloat)b blue:(CGFloat)c alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:((10 * a) / 255.0) green:((20 * b)/255.0) blue:((30 * c)/255.0) alpha:alpha];
}

//随机色
+ (UIColor *)getRandomColorAlpha:(CGFloat)alpha {
    return [UIColor colorWithRed:arc4random() % 256 / 255.0 green: arc4random() % 256 / 255.0 blue: arc4random() % 256 / 255.0 alpha:alpha];
}

/**
 *  判断字符串是否为空
 */
+ (BOOL)isBlankString:(NSString *)aStr {
    
    aStr = [NSString stringWithFormat:@"%@",aStr];
    
    if (!aStr) {
        return YES;
    }
    if ([aStr isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if (!aStr.length) {
        return YES;
    }
    if ([aStr isEqualToString:@"(null)"]) {
        return YES;
    }
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmedStr = [aStr stringByTrimmingCharactersInSet:set];
    if (!trimmedStr.length) {
        return YES;
    }
    return NO;
}

+ (NSString *)insertSpacesEveryFourDigitsIntoString:(NSString *)string value:(int)value
{
    string = [NSString stringWithFormat:@"%@",string];
    NSArray *stringArr = @[];
    NSString *intStr = @"";
    NSString *floatStr = @"";
    if ([string containsString:@"."]) {
        stringArr = [string componentsSeparatedByString:@"."];
        intStr = stringArr[0];
        floatStr = stringArr[1];
    }else{
        intStr = string;
    }
    
    if (string.length > 3) {
        
        NSMutableString *stringWithAddedSpaces = [NSMutableString new];
        for (NSUInteger i = 0; i < [intStr length]; i++) {
            if ((i > 0) && ((i % value) == 0)) {
                [stringWithAddedSpaces appendString:@","];
            }
            unichar     characterToAdd = [intStr characterAtIndex:[intStr length]-1-i];
            NSString    *stringToAdd =
            [NSString stringWithCharacters:&characterToAdd length:1];
            [stringWithAddedSpaces appendString:stringToAdd];
        }
        NSMutableString * reverseString = [NSMutableString string];
        for(int i = 0 ; i < stringWithAddedSpaces.length; i ++){
            //倒序读取字符并且存到可变数组数组中
            unichar c = [stringWithAddedSpaces characterAtIndex:stringWithAddedSpaces.length- i -1];
            [reverseString appendFormat:@"%c",c];
        }
        [reverseString appendString:[NSString stringWithFormat:@".%@",floatStr]];
        return reverseString;
    }else{
        return string;
    }
}

+ (NSDictionary *)md5ParameterWithDict:(NSDictionary *)dict{
    
    NSMutableDictionary *parameterMulDict = [[NSMutableDictionary alloc] init];
    NSDictionary *tempDict = [[NSDictionary alloc] init];
    
    parameterMulDict = [NSMutableDictionary dictionaryWithDictionary:dict];
    [parameterMulDict setValue:[NSString stringWithFormat:@"%.0f",[[NSDate date] timeIntervalSince1970]] forKey:@"time"];
    tempDict = [NSDictionary dictionaryWithDictionary:parameterMulDict];
    
    NSString *sign = [self stringWithDict:tempDict];
    //待加入token
    sign = [self getHmacmd5:sign withSecret:@""];
    [parameterMulDict setValue:sign forKey:@"sign"];
    
    return parameterMulDict;
}


+ (NSString*)stringWithDict:(NSDictionary*)dict{
    
    NSArray*keys = [dict allKeys];
    
    NSArray*sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1,id obj2) {
        return[obj1 compare:obj2 options:NSNumericSearch];//正序
    }];
    
    NSString*str =@"";
    
    for(NSString*categoryId in sortedArray) {
        
        if([str length] !=0) {
            
            str = [str stringByAppendingString:@"&"];
        }
        
        id value = [dict objectForKey:categoryId];
        
        if([value isKindOfClass:[NSDictionary class]]) {
            
            NSDictionary *dic = value;
            NSArray *keys = [dic allKeys];
            for (int i = 0 ; i < keys.count; i ++) {
                
                if (i !=0 ) {
                    str = [str stringByAppendingString:@"&"];
                }
                str = [str stringByAppendingFormat:@"%@[%@]=%@",categoryId,keys[i],dic[keys[i]]];
            }
            
        }else if ([value isKindOfClass:[NSArray class]]) {
            
            NSArray *arr = value;
            if (arr.count > 0) {
                
                for (int i = 0; i < arr.count; i ++) {
                    if (i !=0 ) {
                        str = [str stringByAppendingString:@"&"];
                    }
                    str = [str stringByAppendingFormat:@"%@[%d]=%@",categoryId,i,arr[i]];
                }
            }else{
                if([str length] > 0){
                    str = [str substringToIndex:([str length]-1)];// 去掉最后一个","
                }else{
                    str = str;
                }
            }
            
        }else{
            
            str = [str stringByAppendingFormat:@"%@=%@",categoryId,value];
        }
        
    }
    return str;
}

+ (NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), result );
    return [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

+ (NSString *)getHmacmd5:(NSString *)clearText withSecret:(NSString *)secret{
    CCHmacContext ctx;
    //使用GBK编码
    unsigned long encode = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingUTF8);
    const char *key = [secret cStringUsingEncoding:encode];
    const char *str = [clearText cStringUsingEncoding:encode];
    unsigned char mac[CC_MD5_DIGEST_LENGTH];
    char hexmac[2 * CC_MD5_DIGEST_LENGTH + 1];
    char *p;
    CCHmacInit(&ctx, kCCHmacAlgMD5, key, strlen(key));
    CCHmacUpdate(&ctx, str, strlen(str));
    CCHmacFinal(&ctx, mac);
    p = hexmac;
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH;i++) {
        
        snprintf(p,3,"%02x", mac[i]);
        
        p += 2;
    }
//    DLog(@"-------------------------------------------%@",[PCISave account].access_token);
    return [NSString stringWithCString:hexmac encoding:encode];
}



//手机序列号 唯一标示 UUID
+ (NSString *)getUUID {
    /**
     *  随机值
     */
    //    CFUUIDRef puuid = CFUUIDCreate( nil );
    //    CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
    //    NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
    //    return result;
    /**
     *  返回没有横线的uuid
     */
    NSUUID *UUID = [[UIDevice currentDevice] identifierForVendor];
    return [[UUID UUIDString] stringByReplacingOccurrencesOfString:@"-" withString:@""];
    /**
     *  返回有横线的uuid
     */
    //    NSUUID *UUID = [[UIDevice currentDevice] identifierForVendor];
    //    return [UUID UUIDString];
}


//版本号
+ (NSString *)getVersion {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
}


+ (NSString *)getNowTimeTimestamp{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss SSS"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    //设置时区,这个对于时间的处理有时很重要
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]*1000];
    
    return timeSp;
}

+ (void)telPhone:(NSString *)phone{
    
    NSMutableString* str=[[NSMutableString alloc] initWithFormat:@"tel:%@",phone];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [[self currentViewController].view addSubview:callWebview];
}


//判断手机号码格式是否正确
+ (BOOL)valiMobile:(NSString *)mobile
{
    mobile = [mobile stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (mobile.length != 11)
    {
        return NO;
    }else{
        /**
         * 移动号段正则表达式
         */
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        /**
         * 联通号段正则表达式
         */
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        /**
         * 电信号段正则表达式
         */
        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:mobile];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:mobile];
        
        if (isMatch1 || isMatch2 || isMatch3) {
            return YES;
        }else{
            return NO;
        }
    }
}
    
//判断银行卡格式是否正确
+ (BOOL)isBankCard:(NSString *)cardNumber
{
    if(cardNumber.length==0)
    {
        return NO;
    }
    NSString *digitsOnly = @"";
    char c;
    for (int i = 0; i < cardNumber.length; i++)
    {
        c = [cardNumber characterAtIndex:i];
        if (isdigit(c))
        {
            digitsOnly =[digitsOnly stringByAppendingFormat:@"%c",c];
        }
    }
    int sum = 0;
    int digit = 0;
    int addend = 0;
    BOOL timesTwo = false;
    for (NSInteger i = digitsOnly.length - 1; i >= 0; i--)
    {
        digit = [digitsOnly characterAtIndex:i] - '0';
        if (timesTwo)
        {
            addend = digit * 2;
            if (addend > 9) {
                addend -= 9;
            }
        }
        else {
            addend = digit;
        }
        sum += addend;
        timesTwo = !timesTwo;
    }
    int modulus = sum % 10;
    return modulus == 0;
}
@end
