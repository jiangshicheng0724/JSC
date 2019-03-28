//
//  AppDelegate.h
//  JSCTool
//
//  Created by zuosen on 2019/3/28.
//  Copyright © 2019 jsc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

/***  是否允许横屏的标记 */
@property (nonatomic,assign)BOOL allowRotation;

@end

