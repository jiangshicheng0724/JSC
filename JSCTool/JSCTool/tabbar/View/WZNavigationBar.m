//
//  WZNavigationBar.m
//  BuDeJie
//
//  Created by 班文政 on 2019/2/27.
//  Copyright © 2019 班文政. All rights reserved.
//

#import "WZNavigationBar.h"
#import "WZBackView.h"
#import "UIView+WZFrame.h"

@implementation WZNavigationBar

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    for (UIView *view in self.subviews) {
        
        if ([view isKindOfClass:[WZBackView class]]) {
            
            view.wz_x = 0;
        }
    }
}
@end
