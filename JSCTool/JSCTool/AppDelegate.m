//
//  AppDelegate.m
//  JSCTool
//
//  Created by zuosen on 2019/3/28.
//  Copyright © 2019 jsc. All rights reserved.
//

#import "AppDelegate.h"
#import "WZTabBarController.h"
#import <AVFoundation/AVFoundation.h>


//// 引入 JPush 功能所需头文件
//#import "JPUSHService.h"
//// iOS10 注册 APNs 所需头文件
////#ifdef NSFoundationVersionNumber_iOS_9_x_Max
//#import <UserNotifications/UserNotifications.h>
//#import "PCIMessageChildListViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
/*
     //给所有webview添加useragent
     NSString *oldUserAgent = [[[UIWebView alloc] init] stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
     NSLog(@"%@",oldUserAgent);
     NSString *customUserAgent =  [oldUserAgent stringByAppendingString:[NSString stringWithFormat:@" ChaoQiClient/%@",[RYToolClass getVersion]]];
     [[NSUserDefaults standardUserDefaults] registerDefaults:@{@"UserAgent":customUserAgent}];
     
     //解决ios11以后上啦加载上下跳动问题
     if (@available(iOS 11.0, *)) {
     UITableView.appearance.estimatedRowHeight = 0;
     UITableView.appearance.estimatedSectionFooterHeight = 0;
     UITableView.appearance.estimatedSectionHeaderHeight = 0;
     }
*/

  
/*
 //向微信注册（微信登陆）
 [WXApi registerApp:@"wx12790e595dfffcea"];
 */
   
    
/*
 // 1.注册系统通知
 if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]){
 UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert categories:nil];
 [application registerUserNotificationSettings:settings];
 }
 // 2.注册极光推送
 if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
 JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
 entity.types = UNAuthorizationOptionAlert|UNAuthorizationOptionBadge|UNAuthorizationOptionSound;
 [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
 }else if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
 //可以添加自定义categories
 [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
 UIUserNotificationTypeSound |
 UIUserNotificationTypeAlert)
 categories:nil];
 }
 [JPUSHService setupWithOption:launchOptions appKey:JPushAPPkey
 channel:@"Publish channel"
 apsForProduction:NO
 advertisingIdentifier:nil];
 
 // 接收应用内消息·
 NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
 [defaultCenter addObserver:self selector:@selector(networkDidReceiveMessage:) name:kJPFNetworkDidReceiveMessageNotification object:nil];
 // 极光推送登录成功后可以注册别名
 [defaultCenter addObserver:self selector:@selector(registerAlias:) name:kJPFNetworkDidLoginNotification object:nil];
 */

    
    
    //后台播放
    AVAudioSession *session = [AVAudioSession sharedInstance];
    
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    [session setActive:YES error:nil];
    
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    self.window.rootViewController = [[WZTabBarController alloc] init];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}


/*
    #pragma mark - JPUSHRegisterDelegate
    // iOS 10 Support，前台收到通知，后台不会执行这个方法
    - (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
        // Required
        NSDictionary * userInfo = notification.request.content.userInfo;
        if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
            [JPUSHService handleRemoteNotification:userInfo];
        }
        completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
        // 通知内容为：notification.request.content.body
    }


    // iOS 10 Support，用户点击了通知进入app
    - (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
        // Required
        NSDictionary * userInfo = response.notification.request.content.userInfo;
        if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
            [JPUSHService handleRemoteNotification:userInfo];
        }
 
        DLog(@"=======================通知内容=================%@",userInfo);
 
 
        [self jpushHandleWithData:@{}];
 
        completionHandler();  // 系统要求执行这个方法
 
        [JPUSHService handleRemoteNotification:userInfo];
    }

    - (void)jpushHandleWithData:(NSDictionary *)data{
 
        PCIMessageChildListViewController *vc = [[PCIMessageChildListViewController alloc] init];
        vc.navigationItem.title = @"消息";
        [[self currentViewController].navigationController pushViewController:vc animated:YES];
    }

    #pragma mark 绑定tag
    - (void)registerAlias:(NSNotification *)notification{
        // 注册别名
        //    [JPUSHService setAlias:[NSString stringWithFormat:@"%@",[RYSave account].user_id] callbackSelector:@selector(tagsAliasCallback:tags:alias:) object:self];
        NSString *alias = [NSString stringWithFormat:@"%@",[RYToolClass isBlankString:[PCISave account].user_id] ? @"" : [PCISave account].user_id];
        [JPUSHService setAlias:[NSString stringWithFormat:@"%@",alias] completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
            DLog(@"极光别名注册的回调方法rescode: %ld, \n, \n alias: %@\n", (long)iResCode , iAlias);
            if (iResCode == 0) {
                // 注册成功
            }
        } seq:1];
    }

    - (void)updateJPushRegisterId{
 
 
        //    if (![RYToolClass isBlankString:[RYSave account].token]) {
        //
        //        [ZSHTTPRequest updateJPushRegisterIdWithParameters:@{@"registration_id":[JPUSHService registrationID]} isCache:NO success:^(id response) {
        //
        //            if ([response[@"error_code"] isEqualToString:@"SUCCESS"]) {
        //
        //            }
        //            else{
        //
        //                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(600 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //
        //                    [self updateJPushRegisterId];
        //                });
        //            }
        //        } failure:^(NSError *error) {
        //
        //        }];
        //    }
    }

    // 极光别名注册的回调方法
    -(void)tagsAliasCallback:(int)iResCode
                        tags:(NSSet*)tags
                       alias:(NSString*)alias
    {
        DLog(@"极光别名注册的回调方法rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, tags , alias);
        if (iResCode == 0) {
            // 注册成功
        }
    }

    #pragma mark 解析极光推送的应用内消息
    - (void)networkDidReceiveMessage:(NSNotification *)notification {
        NSDictionary * userInfo = [notification userInfo];
        DLog(@"解析极光推送的应用内消息：%@",userInfo);
    }
     // 接收到远程通知之后
     - (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
 
     // Required,For systems with less than or equal to iOS6
     [JPUSHService handleRemoteNotification:userInfo];
     }
 
     - (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
 
     // IOS 7 Support Required
     [JPUSHService handleRemoteNotification:userInfo];
     completionHandler(UIBackgroundFetchResultNewData);
     }
     //获取 deviceToken 失败后 远程推送（极光推送）打开失败
     - (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
     //Optional
     DLog(@"获取 device token 失败 %@", error);
     }
 */

//#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_9_0
///** iOS9及以后 */
//- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options
//{
//    BOOL result = [[XHPayKit defaultManager] handleOpenURL:url];
//    if (!result) {//这里处理其他SDK(例如QQ登录,微博登录等)
//        //分享
//        if ([JSHAREService handleOpenUrl:url]) {
//            return YES;
//        }else if([WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]]){
//            return YES;
//            
//            //H5唤起跳到指定界面
//        }else if([[[NSString stringWithFormat:@"%@",url] substringToIndex:19] isEqualToString:@"zssupereducation://"]){
//            NSString *urlWeb = [[NSString stringWithFormat:@"%@",url] substringFromIndex:19];
//            DLog(@"----------urlWeb----------%@",urlWeb);
//            SUWebBaseViewController *vc = [[SUWebBaseViewController alloc] init];
//            vc.webUrl = [NSString stringWithFormat:@"https://%@",urlWeb];
//            [[self currentViewController].navigationController pushViewController:vc animated:YES];
//            return YES;
//        }
//    }
//    // 授权跳转支付宝钱包进行支付，处理支付结果
//    [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
//        NSLog(@"result = %@",resultDic);
//        // 解析 auth code
//        NSString *result = resultDic[@"result"];
//        NSString *authCode = nil;
//        if (result.length>0) {
//            NSArray *resultArr = [result componentsSeparatedByString:@"&"];
//            for (NSString *subResult in resultArr) {
//                if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
//                    authCode = [subResult substringFromIndex:10];
//                    break;
//                }
//            }
//        }
//        NSLog(@"授权结果 authCode = %@", authCode?:@"");
//    }];
//    return result;
//}
//#endif
///** iOS9以下 */
//- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
//{
//    
//    BOOL result = [[XHPayKit defaultManager] handleOpenURL:url];
//    if (!result) {//这里处理其他SDK(例如QQ登录,微博登录等)
//        //分享
//        if (![JSHAREService handleOpenUrl:url]) {
//            //登陆
//            return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
//            
//        }else{
//            return YES;
//        }
//    }
//    // 授权跳转支付宝钱包进行支付，处理支付结果
//    [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
//        NSLog(@"result = %@",resultDic);
//        // 解析 auth code
//        NSString *result = resultDic[@"result"];
//        NSString *authCode = nil;
//        if (result.length>0) {
//            NSArray *resultArr = [result componentsSeparatedByString:@"&"];
//            for (NSString *subResult in resultArr) {
//                if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
//                    authCode = [subResult substringFromIndex:10];
//                    break;
//                }
//            }
//        }
//        NSLog(@"授权结果 authCode = %@", authCode?:@"");
//    }];
//    return result;
//}




//禁止全屏
-(UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    if (self.allowRotation) {//如果设置了allowRotation属性，支持全屏
        return UIInterfaceOrientationMaskAll;
    }
    return UIInterfaceOrientationMaskPortrait;//默认全局不支持横屏
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
//    //重置个推角标
//    if (application.applicationIconBadgeNumber == 0) {  //badge number 不为0，说明程序有个推图标
//        //如果需要角标清空需要调用系统方法设置
//        [application setApplicationIconBadgeNumber:0];   //将图标清零。
//        [JPUSHService resetBadge];
//    }
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
