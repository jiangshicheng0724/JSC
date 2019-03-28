//
//  UIImage+WZRender.h
//  BuDeJie
//
//  Created by 班文政 on 2019/2/25.
//  Copyright © 2019 班文政. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (WZRender)

/**
 加载一个不要被渲染图片

 @param name 图片名
 @return 返回一个不被渲染的图片
 */
+ (UIImage *)imageNameWithOriginal:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
