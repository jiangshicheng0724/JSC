//
//  NSObject+RYTool.h
//  RefreshYouth
//
//  Created by 班文政 on 2018/10/31.
//  Copyright © 2018 班文政. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (RYTool)

//通过控制器的布局视图可以获取到控制器实例对象    modal的展现方式需要取到控制器的根视图
- (UIViewController *)currentViewController;

@end

NS_ASSUME_NONNULL_END
