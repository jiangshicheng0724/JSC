//
//  UIImage+MLSCategory.h
//  MoLiSangCar
//
//  Created by 班文政 on 2018/10/17.
//  Copyright © 2018 班文政. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (MLSCategory)

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;
@end

NS_ASSUME_NONNULL_END
