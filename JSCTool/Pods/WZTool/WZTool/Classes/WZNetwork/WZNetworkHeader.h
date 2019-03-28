//
//  WZNetworkHeader.h
//  Pods
//
//  Created by 班文政 on 2019/3/9.
//

#ifndef WZNetworkHeader_h
#define WZNetworkHeader_h

#if __has_include(<AFNetworking/AFNetworking.h>)
#import <AFNetworking/AFNetworking.h>
#else
#import "AFNetworking.h"
#endif

typedef void(^WZSuccessBlock)(id responseObject, BOOL isCacheObject);
typedef void (^WZFailureBlock)(NSURLSessionTask *task, NSError *error, NSInteger statusCode);


#endif /* WZNetworkHeader_h */
