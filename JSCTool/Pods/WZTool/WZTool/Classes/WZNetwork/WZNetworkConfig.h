//
//  WZNetworkConfig.h
//  Pods-WZTool_Tests
//
//  Created by 班文政 on 2019/3/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 *  配置类：配置服务器地址，token，debug模式等
 *
 *
 */
@interface WZNetworkConfig : NSObject

/**  请求域名 默认为nil*/
@property (nonatomic , strong) NSString  *_Nullable baseUrl;

/**  请求参数,默认为nil */
@property (nonatomic , strong) NSDictionary  *_Nullable defailtParameters;

/**  自定义请求头，n默认为nil */
@property (nonatomic , strong, readonly) NSDictionary  *_Nullable customHeaders;

/**  请求超时时间，默认为30秒 */
@property (nonatomic , assign) NSTimeInterval  timeoutSeconds;

/**  debug模式下是否打印日志 */
@property (nonatomic , assign) BOOL  debugMode;


/**
 单例

 @return 创建WZNetworkConfig实例
 */
+ (WZNetworkConfig *_Nullable)sharedConfig;


/**
 添加请求头

 @param header 自定义添加请求头
 */
- (void)addCustomHeader:(NSDictionary *_Nonnull)header;

@end

NS_ASSUME_NONNULL_END
