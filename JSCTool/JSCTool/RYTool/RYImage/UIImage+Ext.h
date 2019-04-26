//
//  UIImage+Ext.h
//  WuXianTaiZhou
//
//  Created by mmc on 12-8-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Ext)
- (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize;

- (UIImage *)shrinkImage:(CGSize) size;

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;

@end
