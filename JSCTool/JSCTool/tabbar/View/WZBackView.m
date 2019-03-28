//
//  WZBackView.m
//  BuDeJie
//
//  Created by 班文政 on 2019/2/27.
//  Copyright © 2019 班文政. All rights reserved.
//

#import "WZBackView.h"
#import "UIView+WZFrame.h"

@implementation WZBackView

+ (instancetype)backViewWithImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action title:(NSString *)title{
    
    // 设置返回按钮
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setTitle:title forState:UIControlStateNormal];
    [backButton setImage:image forState:UIControlStateNormal];
    [backButton setImage:highImage forState:UIControlStateHighlighted];
    [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [backButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [backButton sizeToFit];
    backButton.wz_x = 0;
    
    WZBackView *view = [[WZBackView alloc] initWithFrame:backButton.bounds];
    [view addSubview:backButton];
    return view;
}

@end
