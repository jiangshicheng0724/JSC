//
//  WZToolHeader.h
//  Pods
//
//  Created by 班文政 on 2019/3/8.
//

#ifndef WZToolHeader_h
#define WZToolHeader_h

#import "WZNetworkHeader.h"
#import "LZActionSheet.h"
#import "UIButton+WZButton.h"
#import "UIImageView+WZImageView.h"
#import "NSString+WZString.h"
#import "NSObject+WZObject.h"
#import "UILabel+WZLabel.h"
#import "UIColor+WZColor.h"
#import "UIBarButtonItem+WZItem.h"
#import "UIImage+WZRender.h"
#import "UIView+WZFrame.h"
#import "UIView+WZAlert.h"
#import "UIView+WZView.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight  [UIScreen mainScreen].bounds.size.height

#define ClearColor                              [UIColor clearColor]
#define WhiteColor                              [UIColor whiteColor]

#define kISiPhone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define kScreenMaxLength (MAX(kScreenWidth, kScreenHeight))
#define kScreenMinLength (MIN(kScreenWidth, kScreenHeight))
#define kISiPhone5 (kISiPhone && kScreenMaxLength == 568.0)
#define kISiPhone6 (kISiPhone && kScreenMaxLength == 667.0)
#define kISiPhone6P (kISiPhone && kScreenMaxLength == 736.0)
#define kISiPhoneX (kISiPhone && kScreenMaxLength == 812.0)
#define kISiPhoneXr (kISiPhone && kScreenMaxLength == 896.0)
#define kISiPhoneXX (kISiPhone && kScreenMaxLength > 811.0)
#define IOS8 ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 8.0)


//6为标准适配的,如果需要其他标准可以修改
#define kScale_W(w) ((kScreenWidth)/375) * (w)
#define kScale_H(h) (kScreenHeight/667) * (h)


//状态栏高度
#define kStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
//状态栏高度
#define StatusBarHeight (kISiPhoneX?44:20)
//标签栏高度
#define kTabBarHeight (StatusBarHeight > 20 ? 83 : 49)
//导航栏高度
#define kNavBarHeight (StatusBarHeight + 44)
//安全区高度
#define kSafeAreaBottom (kISiPhoneX ? 34 : 0)


///当前日期字符串
#define DATE_STRING \
({NSDateFormatter *fmt = [[NSDateFormatter alloc] init];\
[fmt setDateFormat:@"YYYY-MM-dd hh:mm:ss"];\
[fmt stringFromDate:[NSDate date]];})

///------ <强烈推荐❤️>替换NSLog使用，debug模式下可以打印很多方法名、行信息(方便查找)，release下不会打印 ------
#ifdef DEBUG
//-- 区分设备和模拟器,
//解决Product -> Scheme -> Run -> Arguments -> OS_ACTIVITY_MODE为disable时，真机下 Xcode Debugger 不打印的bug ---
#if TARGET_OS_IPHONE
/*iPhone Device*/
#define DLog(format, ...) printf("%s:Dev: %s [Line %d]\n%s\n\n", [DATE_STRING UTF8String], __PRETTY_FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ##__VA_ARGS__] UTF8String])
#else
/*iPhone Simulator*/
#define DLog(format, ...) NSLog((@":Sim: %s [Line %d]\n%@\n\n"), __PRETTY_FUNCTION__, __LINE__, [NSString stringWithFormat:format, ##__VA_ARGS__])
#endif
#else
#define DLog(...)
#endif


///------ <强烈推荐❤️>优酷大神ibireme的 Weak-Strong Dance
///省掉多处编写__weak __typeof(self) weakSelf = self; __strong __typeof(weakSelf) strongSelf = weakSelf;代码的麻烦 ------
/**
 使用说明
 Synthsize a weak or strong reference.
 
 Example:
 @weakify(self)
 [self doSomething^{
 @strongify(self)
 if (!self) return;
 ...
 }];
 
 */
#ifndef weakify
#if DEBUG
#if __has_feature(objc_arc)
#define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif

#ifndef strongify
#if DEBUG
#if __has_feature(objc_arc)
#define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
#endif
#endif
#endif


#endif /* WZToolHeader_h */
