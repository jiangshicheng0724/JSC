//
//  UIImage+RYImage.h
//  RefreshYouth
//
//  Created by 班文政 on 2018/10/31.
//  Copyright © 2018 班文政. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (RYImage)

/**
 *  根据颜色生成一张图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color;
//圆形
- (void)was_roundImageWithSize:(CGSize)size fillColor:(UIColor *)fillColor opaque:(BOOL)opaque completion:(void (^)(UIImage *))completion;
//圆角矩阵
- (void)was_roundRectImageWithSize:(CGSize)size fillColor:(UIColor *)fillColor opaque:(BOOL)opaque radius:(CGFloat)radius completion:(void (^)(UIImage *))completion;
// 获取视频第一帧
+ (UIImage*)getVideoPreViewImage:(NSURL *)path;
@end

@interface UIImageView (Extension)
//网络延迟下载--圆形 有背景色
- (void)was_setCircleImageWithUrlString:(NSString *)urlString placeholder:(UIImage *)image fillColor:(UIColor *)color;
//网络延迟下载--圆形矩阵 有背景色
- (void)was_setRoundRectImageWithUrlString:(NSString *)urlString placeholder:(UIImage *)image fillColor:(UIColor *)color cornerRadius:(CGFloat) cornerRadius;

//网络延迟下载--圆形    背景色为透明 无背景色
- (void)was_setCircleImageWithUrlString:(NSString *)urlString placeholder:(UIImage *)image;
//网络延迟下载--圆形矩阵 背景色为透明 无背景色
- (void)was_setRoundRectImageWithUrlString:(NSString *)urlString placeholder:(UIImage *)image cornerRadius:(CGFloat) cornerRadius;
@end


NS_ASSUME_NONNULL_END
