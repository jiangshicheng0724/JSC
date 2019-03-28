//
//  WZNetworkUtils.h
//  Pods-WZTool_Tests
//
//  Created by 班文政 on 2019/3/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/*
 *  工具类：可以用于生成缓存路径，app版本号等
 */

extern NSString * _Nonnull const WYNetworkCacheBaseFolderName;
extern NSString * _Nonnull const WYNetworkCacheFileSuffix;
extern NSString * _Nonnull const WYNetworkCacheInfoFileSuffix;
extern NSString * _Nonnull const WYNetworkDownloadResumeDataInfoFileSuffix;

@interface WZNetworkUtils : NSObject


/**
 返回app版本号

 @return app版本号
 */
+ (NSString * _Nullable)appVersionStr;


/**
 给定字符串md5加密

 @param string 字符串
 @return 返回MD5加密字符串
 */
+ (NSString * _Nonnull)generateMD5StringFromString:(NSString *_Nonnull)string;


/**
 生产完整的请求url

 @param baseUrlStr 域名
 @param requestUrlStr 请求地址
 @return 完整请求地址
 */
+(NSString * _Nonnull)generateCompleteRequestUrlStrWithBaseUrlStr:(NSString * _Nonnull)baseUrlStr requestUrlStr:(NSString *_Nonnull)requestUrlStr;
@end

NS_ASSUME_NONNULL_END
