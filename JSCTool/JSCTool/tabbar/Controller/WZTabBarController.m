//
//  WZTabBarController.m
//  BuDeJie
//
//  Created by 班文政 on 2019/2/26.
//  Copyright © 2019 班文政. All rights reserved.
//

#import "WZTabBarController.h"
//#import "WZNavigationViewController.h"
#import "RYNavigationViewController.h"

#import "YYMHomeViewController.h"
#import "YYMClassifyViewController.h"
#import "YYMShopCarViewController.h"
#import "YYMMineViewController.h"

#import "UIImage+WZRender.h"
#import "WZTabBar.h"

@interface WZTabBarController ()

@end

@implementation WZTabBarController

+ (void)load{
    
    //获取当前类的tabBarItem
    UITabBarItem *item = [UITabBarItem appearanceWhenContainedInInstancesOfClasses:@[self]];
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSForegroundColorAttributeName] = ThemeColor;
    [item setTitleTextAttributes:attr forState:UIControlStateSelected];
    
    NSMutableDictionary *attrnor = [NSMutableDictionary dictionary];
    attrnor[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrnor[NSForegroundColorAttributeName] = [UIColor getColorWithHexString:@"#999999"];
    [item setTitleTextAttributes:attrnor forState:UIControlStateNormal];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 添加所有子控制器
    [self setupAllChildViewController];
    
    // 设置tabBar上对应按钮内容 -> 由对应的子控制器的tabBarItem 决定
    [self setupAllTileButton];
    
    // 自定义tabBar
    [self setupTabBar];
}

#pragma mark - 自定义tabBar
- (void)setupTabBar
{
    WZTabBar *tabBar = [[WZTabBar alloc] init];
    tabBar.backgroundColor = WhiteColor;
    // 替换系统的tabBar KVC:设置readonly属性
    [self setValue:tabBar forKey:@"tabBar"];
}

#pragma mark - 添加所有的子控制器
- (void)setupAllChildViewController{
    
    YYMHomeViewController *homeVc = [[YYMHomeViewController alloc] init];
    RYNavigationViewController *nav = [[RYNavigationViewController alloc] initWithRootViewController:homeVc];
    [self addChildViewController:nav];
    
    YYMClassifyViewController *classifyVc = [[YYMClassifyViewController alloc] init];
    RYNavigationViewController *nav1 = [[RYNavigationViewController alloc] initWithRootViewController:classifyVc];
    [self addChildViewController:nav1];
    
    YYMShopCarViewController *shopCarVc = [[YYMShopCarViewController alloc] init];
    RYNavigationViewController *nav3 = [[RYNavigationViewController alloc] initWithRootViewController:shopCarVc];
    [self addChildViewController:nav3];
    
    YYMMineViewController *meVc = [[YYMMineViewController alloc] init];
    RYNavigationViewController *nav4 = [[RYNavigationViewController alloc] initWithRootViewController:meVc];
    [self addChildViewController:nav4];
}

#pragma mark - 设置所有标题按钮内容
- (void)setupAllTileButton{
    
    // 0:首页
    UINavigationController *nav = self.childViewControllers[0];
    // 标题
    nav.tabBarItem.title = @"首页";
    // 图片
    nav.tabBarItem.image = [UIImage imageNamed:@"tab_icon_home_mr"];
    // 选中
    nav.tabBarItem.selectedImage = [UIImage imageNameWithOriginal:@"tab_icon_sy_xz"];
    
    // 1:分类
    UINavigationController *nav1 = self.childViewControllers[1];
    // 标题
    nav1.tabBarItem.title = @"分类";
    // 图片
    nav1.tabBarItem.image = [UIImage imageNamed:@"tab_icon_fl_mr"];
    // 选中
    nav1.tabBarItem.selectedImage = [UIImage imageNameWithOriginal:@"tab_icon_fl_xz"];
    
    // 3:购物车
    UINavigationController *nav3 = self.childViewControllers[2];
    // 标题
    nav3.tabBarItem.title = @"购物车";
    // 图片
    nav3.tabBarItem.image = [UIImage imageNamed:@"tab_icon_gwc_mr"];
    // 选中
    nav3.tabBarItem.selectedImage = [UIImage imageNameWithOriginal:@"tab_icon_gwc_xz"];
    
    // 4:我
    UINavigationController *nav4 = self.childViewControllers[3];
    // 标题
    nav4.tabBarItem.title = @"我的";
    // 图片
    nav4.tabBarItem.image = [UIImage imageNamed:@"tab_icon_wd_mr"];
    // 选中
    nav4.tabBarItem.selectedImage = [UIImage imageNameWithOriginal:@"tab_icon_grzx_xz"];
}

@end
