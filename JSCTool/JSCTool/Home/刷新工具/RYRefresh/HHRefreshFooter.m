//
//  HHRefreshFooter.m
//  Honghai
//
//  Created by 班文政 on 2017/3/20.
//  Copyright © 2017年 Nado. All rights reserved.
//

#import "HHRefreshFooter.h"

@implementation HHRefreshFooter

- (void)prepare
{
    [super prepare];
    // 不要自动刷新
    //self.automaticallyRefresh = YES;
    self.automaticallyChangeAlpha = YES;
}

@end
