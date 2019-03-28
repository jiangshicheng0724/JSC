//
//  UIImage+WZRender.m
//  BuDeJie
//
//  Created by 班文政 on 2019/2/25.
//  Copyright © 2019 班文政. All rights reserved.
//

#import "UIImage+WZRender.h"

@implementation UIImage (WZRender)

+ (UIImage *)imageNameWithOriginal:(NSString *)name{
    
    UIImage *originalImage = [UIImage imageNamed:name];
    originalImage = [originalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return originalImage;
}

@end
