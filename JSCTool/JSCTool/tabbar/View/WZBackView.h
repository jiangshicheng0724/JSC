//
//  WZBackView.h
//  BuDeJie
//
//  Created by 班文政 on 2019/2/27.
//  Copyright © 2019 班文政. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WZBackView : UIView

+ (instancetype)backViewWithImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action title:(NSString *)title ;

@end

NS_ASSUME_NONNULL_END
