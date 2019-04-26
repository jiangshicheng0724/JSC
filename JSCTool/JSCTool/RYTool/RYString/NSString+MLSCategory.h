//
//  NSString+MLSCategory.h
//  MoLiSangCar
//
//  Created by 班文政 on 2018/10/17.
//  Copyright © 2018 班文政. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (MLSCategory)

/**
 *  去掉首尾空字符串
 */
- (NSString *)replaceSpaceOfHeadTail;
- (NSString *)replaceUnicode;

/**
 获取缓存路径
 
 @return 将当前字符串拼接到cache目录后面
 */
- (NSString *)cacheDic;

/**
 获取document路径
 
 @return 将当前字符串拼接到document目录后面
 */
- (NSString *)docDic;

/**
 获取tmp路径
 
 @return 将当前字符串拼接到tmp目录后面
 */
- (NSString *)tmpDic;

@end

NS_ASSUME_NONNULL_END
