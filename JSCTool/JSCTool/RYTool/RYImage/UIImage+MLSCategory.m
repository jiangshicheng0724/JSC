//
//  UIImage+MLSCategory.m
//  MoLiSangCar
//
//  Created by 班文政 on 2018/10/17.
//  Copyright © 2018 班文政. All rights reserved.
//

#import "UIImage+MLSCategory.h"

@implementation UIImage (MLSCategory)

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}

@end
