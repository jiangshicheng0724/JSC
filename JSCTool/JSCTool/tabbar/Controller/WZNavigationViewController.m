//
//  WZNavigationViewController.m
//  BuDeJie
//
//  Created by 班文政 on 2019/2/26.
//  Copyright © 2019 班文政. All rights reserved.
//

#import "WZNavigationViewController.h"
#import "WZNavigationBar.h"
#import "WZBackView.h"


@interface WZNavigationViewController ()<UIGestureRecognizerDelegate>

@end

@implementation WZNavigationViewController

+ (void)load
{
    // 获取当前类下的导航条
    UINavigationBar *navBar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[self]];
    // bug:
    // iOS7,iOS8 bug:把短信界面导航条改了,联系人界面会出现黑
    
    // 设置标题字体
    // 设置导航条标题字体 => 拿到导航条去设置
    [UINavigationBar appearance];
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSFontAttributeName] = [UIFont boldSystemFontOfSize:20];
    
    navBar.titleTextAttributes = attr;
        
    // 设置导航条背景图片
//    [navBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    [navBar setBackgroundColor:WhiteColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建自己的导航条
    WZNavigationBar *bar = [[WZNavigationBar alloc] initWithFrame:self.navigationBar.frame];
    bar.backgroundColor = WhiteColor;
    [self setValue:bar forKey:@"navigationBar"];
    
    // 滑动功能
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self.interactivePopGestureRecognizer.delegate action:@selector(handleNavigationTransition:)];
    [self.view addGestureRecognizer:pan];
    
    // 控制器手势什么时候触发
    pan.delegate = self;
    
    // 清空手势代理,恢复滑动返回功能
    self.interactivePopGestureRecognizer.enabled = NO;
    
}

#pragma mark - UIGestureRecognizerDelegate
// 是否触发手势
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    // 在根控制器下 不要 触发手势
    return self.childViewControllers.count > 1;
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count > 0) { // 非根控制器
        
        viewController.hidesBottomBarWhenPushed = YES;
        
        // 非根控制器才需要设置返回按钮
        WZBackView *backView = [WZBackView backViewWithImage:[UIImage imageNamed:@"goback"] highImage:[UIImage imageNamed:@"goback"] target:self action:@selector(back) title:@""];
        // 设置返回按钮
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backView];
        
    }
    
    // 这个方法才是真正执行跳转
    [super pushViewController:viewController animated:animated];
}

- (void)back
{
    [self popViewControllerAnimated:YES];
}

@end
