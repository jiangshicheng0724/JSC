//
//  UIImage+RYImage.m
//  RefreshYouth
//
//  Created by 班文政 on 2018/10/31.
//  Copyright © 2018 班文政. All rights reserved.
//

#import "UIImage+RYImage.h"
#import <AVFoundation/AVFoundation.h>

@implementation UIImage (RYImage)

+ (UIImage *)imageWithColor:(UIColor *)color {
    
    //描述一个矩形
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    //开启图形上下文
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    
    //获得图形上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //使用color填充上下文
    CGContextSetFillColorWithColor(ctx, [color CGColor]);
    
    //渲染上下文
    CGContextFillRect(ctx, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    //关闭图形上下文
    UIGraphicsEndImageContext();
    
    return image;
    
}


- (void)was_roundImageWithSize:(CGSize)size fillColor:(UIColor *)fillColor opaque:(BOOL)opaque completion:(void (^)(UIImage *))completion {
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        //        NSTimeInterval start = CACurrentMediaTime();
        
        // 1. 利用绘图，建立上下文 BOOL选项为是否为不透明
        UIGraphicsBeginImageContextWithOptions(size, opaque, 0);
        
        CGRect rect = CGRectMake(0, 0, size.width, size.height);
        
        // 2. 设置填充颜色
        if (opaque) {
            [fillColor setFill];
            UIRectFill(rect);
        }
        
        // 3. 利用 贝赛尔路径 `裁切 效果
        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:rect];
        
        [path addClip];
        
        // 4. 绘制图像 如果图片为空那么为单色渲染
        if (self) {
            [self drawInRect:rect];
        }
        
        // 5. 取得结果
        UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
        
        // 6. 关闭上下文
        UIGraphicsEndImageContext();
        
        //        NSLog(@"%f", CACurrentMediaTime() - start);
        
        // 7. 完成回调
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completion != nil) {
                completion(result);
            }
        });
    });
}

//圆角矩形
- (void)was_roundRectImageWithSize:(CGSize)size fillColor:(UIColor *)fillColor opaque:(BOOL)opaque radius:(CGFloat)radius completion:(void (^)(UIImage *))completion {
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        //        NSTimeInterval start = CACurrentMediaTime();
        
        // 1. 利用绘图，建立上下文 BOOL选项为是否为不透明
        UIGraphicsBeginImageContextWithOptions(size, opaque, 0);
        
        CGRect rect = CGRectMake(0, 0, size.width, size.height);
        
        // 2. 设置填充颜色
        if (opaque) {
            [fillColor setFill];
            UIRectFill(rect);
        }
        
        // 3. 利用 贝赛尔路径 `裁切 效果
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius];
        //        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:rect];
        
        [path addClip];
        
        // 4. 绘制图像
        if (self) {
            [self drawInRect:rect];
        }
        
        // 5. 取得结果
        UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
        
        // 6. 关闭上下文
        UIGraphicsEndImageContext();
        
        //        NSLog(@"%f", CACurrentMediaTime() - start);
        
        // 7. 完成回调
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completion != nil) {
                completion(result);
            }
        });
    });
}

// 获取视频第一帧
+ (UIImage*)getVideoPreViewImage:(NSURL *)path
{
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:path options:nil];
    AVAssetImageGenerator *assetGen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    
    assetGen.appliesPreferredTrackTransform = YES;
    CMTime time = CMTimeMakeWithSeconds(0.0, 600);
    NSError *error = nil;
    CMTime actualTime;
    CGImageRef image = [assetGen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    UIImage *videoImage = [[UIImage alloc] initWithCGImage:image];
    CGImageRelease(image);
    return videoImage;
}

@end

#pragma mark - UIImageView
@implementation UIImageView (Extension)
//圆
- (void)was_setCircleImageWithUrlString:(NSString *)urlString placeholder:(UIImage *)image fillColor:(UIColor *)color{
    [self was_setCircleImageWithUrlString:urlString placeholder:image fillColor:color opaque:color];
}

//网络延迟下载--圆形 背景色为透明 无背景色
- (void)was_setCircleImageWithUrlString:(NSString *)urlString placeholder:(UIImage *)image{
    [self was_setCircleImageWithUrlString:urlString placeholder:image fillColor:nil opaque:NO];
}

//圆形矩阵
- (void)was_setRoundRectImageWithUrlString:(NSString *)urlString placeholder:(UIImage *)image fillColor:(UIColor *)color cornerRadius:(CGFloat) cornerRadius{
    [self was_setRoundRectImageWithUrlString:urlString placeholder:image fillColor:color opaque:color cornerRadius:cornerRadius];
}

//网络延迟下载--圆形矩阵 背景色为透明 无背景色
- (void)was_setRoundRectImageWithUrlString:(NSString *)urlString placeholder:(UIImage *)image cornerRadius:(CGFloat) cornerRadius{
    [self was_setRoundRectImageWithUrlString:urlString placeholder:image fillColor:nil opaque:NO cornerRadius:cornerRadius];
}

- (void)was_setCircleImageWithUrlString:(NSString *)urlString placeholder:(UIImage *)image fillColor:(UIColor *)color opaque:(BOOL)opaque{
    [self.superview layoutIfNeeded];
    NSURL *url = [NSURL URLWithString:urlString];
    //防止循环引用
    __weak typeof(self) weakSelf = self;
    CGSize size = self.frame.size;
    
    if (image) {
        //占位图片不为空的情况
        //1.现将占位图圆角化，这样就避免了如图片下载失败，使用占位图的时候占位图不是圆角的问题
        [image was_roundImageWithSize:size fillColor:color opaque:opaque completion:^(UIImage *radiusPlaceHolder) {
            
            //2.使用sd的方法缓存异步下载的图片
            [weakSelf sd_setImageWithURL:url placeholderImage:radiusPlaceHolder completed:^(UIImage *img, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                
                //3.如果下载成功那么讲下载成功的图进行圆角化
                [img was_roundImageWithSize:size fillColor:color opaque:opaque completion:^(UIImage *radiusImage) {
                    weakSelf.image = radiusImage;
                }];
                
            }];
            
        }];
    } else {
        //占位图片为空的情况
        //2.使用sd的方法缓存异步下载的图片
        [weakSelf sd_setImageWithURL:url placeholderImage:nil completed:^(UIImage *img, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
            //3.如果下载成功那么讲下载成功的图进行圆角化
            [img was_roundImageWithSize:size fillColor:color opaque:opaque completion:^(UIImage *radiusImage) {
                weakSelf.image = radiusImage;
            }];
        }];
    }
}

- (void)was_setRoundRectImageWithUrlString:(NSString *)urlString placeholder:(UIImage *)image fillColor:(UIColor *)color opaque:(BOOL)opaque cornerRadius:(CGFloat) cornerRadius{
    [self.superview layoutIfNeeded];
    NSURL *url = [NSURL URLWithString:urlString];
    //防止循环引用
    __weak typeof(self) weakSelf = self;
    CGSize size = self.frame.size;
    
    if (image) {
        //占位图片不为空的情况
        //1.现将占位图圆角化，这样就避免了如图片下载失败，使用占位图的时候占位图不是圆角的问题
        [image was_roundRectImageWithSize:size fillColor:color opaque:opaque radius:cornerRadius completion:^(UIImage *roundRectPlaceHolder) {
            
            //2.使用sd的方法缓存异步下载的图片
            [weakSelf sd_setImageWithURL:url placeholderImage:roundRectPlaceHolder completed:^(UIImage *img, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                
                //3.如果下载成功那么讲下载成功的图进行圆角化
                [img was_roundRectImageWithSize:size fillColor:color opaque:opaque radius:cornerRadius completion:^(UIImage *radiusImage) {
                    weakSelf.image = radiusImage;
                }];
                
            }];
            
        }];
    } else {
        //占位图片为空的情况
        //.使用sd的方法缓存异步下载的图片
        [weakSelf sd_setImageWithURL:url placeholderImage:nil completed:^(UIImage *img, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
            //3.如果下载成功那么讲下载成功的图进行圆角化
            [img was_roundRectImageWithSize:size fillColor:color opaque:opaque radius:cornerRadius completion:^(UIImage *radiusImage) {
                weakSelf.image = radiusImage;
            }];
        }];
    }
}

@end
