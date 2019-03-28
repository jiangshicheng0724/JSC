//
//  UIView+WZFrame.m
//  BuDeJie
//
//  Created by 班文政 on 2019/2/26.
//  Copyright © 2019 班文政. All rights reserved.
//

#import "UIView+WZFrame.h"

@implementation UIView (WZFrame)

- (CGFloat)wz_width{
    
    return self.frame.size.width;
}

- (void)setWz_width:(CGFloat)wz_width{
    
    CGRect rect = self.frame;
    rect.size.width = wz_width;
    self.frame = rect;
}

- (CGFloat)wz_height{
    
    return self.frame.size.height;
}

- (void)setWz_height:(CGFloat)wz_height{
    
    CGRect rect = self.frame;
    rect.size.height = wz_height;
    self.frame = rect;
}

- (CGFloat)wz_x{
    
    return self.frame.origin.x;
}

- (void)setWz_x:(CGFloat)wz_x{
    
    CGRect rect = self.frame;
    rect.origin.x = wz_x;
    self.frame = rect;
}

- (CGFloat)wz_y{
    
    return self.frame.origin.y;
}

- (void)setWz_y:(CGFloat)wz_y{
    
    CGRect rect = self.frame;
    rect.origin.y = wz_y;
    self.frame = rect;
}

- (CGFloat)wz_centerX{
    
    return self.center.x;
}

- (void)setWz_centerX:(CGFloat)wz_centerX{
    
    CGPoint center = self.center;
    center.x = wz_centerX;
    self.center = center;
}

- (CGFloat)wz_centerY{
    
    return self.wz_centerY;
}

- (void)setWz_centerY:(CGFloat)wz_centerY{
    
    CGPoint center = self.center;
    center.y = wz_centerY;
    self.center = center;
}

+ (instancetype)wz_viewFromXib{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
}
@end
