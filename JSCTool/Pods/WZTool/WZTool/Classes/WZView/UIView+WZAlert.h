//
//  UIView+WZAlert.h
//  Pods-WZTool_Tests
//
//  Created by 班文政 on 2019/3/12.
//

#import <UIKit/UIKit.h>

@protocol Alert <NSObject>

@optional

- (void)showHUD;
- (void)showHUDWithText:(NSString *)text;
- (void)hideHUD;

- (void)showToastWithText:(NSString *)toastString;
- (void)showToastWithText:(NSString *)toastString positon:(id)positon;
- (void)showToastWithText:(NSString *)toastString afterDelay:(NSTimeInterval)timeInterval;

- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message confirmHandler:(void(^)(UIAlertAction *confirmAction))handler;
- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message confirmTitle:(NSString *)confirmTitle confirmHandler:(void(^)(UIAlertAction *confirmAction))handler;
- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message cancelAction:(UIAlertAction *)cancelAction confirmAction:(UIAlertAction *)confirmAction;

- (void)showHubMsg:(NSString *)msg;
- (void)hideHub;

@end

@interface UIView (WZAlert)

@end
@interface UIViewController (Alert)<Alert>
@end

@interface NSObject (Alert)<Alert>
@end
