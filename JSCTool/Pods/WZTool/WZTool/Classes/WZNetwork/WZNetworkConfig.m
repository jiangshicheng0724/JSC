//
//  WZNetworkConfig.m
//  Pods-WZTool_Tests
//
//  Created by 班文政 on 2019/3/9.
//

#import "WZNetworkConfig.h"

@interface WZNetworkConfig ()

@property (nonatomic, readwrite, strong) NSDictionary  *customHeaders;

@end

@implementation WZNetworkConfig

+ (WZNetworkConfig *)sharedConfig{
    
    static WZNetworkConfig *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
        sharedInstance.timeoutSeconds = 30;
    });
    return sharedInstance;
}

- (void)addCustomHeader:(NSDictionary *)header{
    
    if (![header isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    if ([[header allKeys] count] == 0) {
        return;
    }
    
    if (!_customHeaders) {
        
        _customHeaders = header;
        return;
    }
    
    NSMutableDictionary *headers_m = [_customHeaders mutableCopy];
    [header enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSString *value, BOOL * _Nonnull stop) {
       
        [headers_m setObject:value forKey:key];
    }];
    
    _customHeaders = [headers_m copy];
}
@end
