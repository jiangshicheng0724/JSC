//
//  SGRecordViewController.h
//  短视频录制
//
//  Created by lihaohao on 2017/5/19.
//  Copyright © 2017年 低调的魅力. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SGRecordViewController : UIViewController

@property (nonatomic , copy) void (^recordViewBackBlock)(NSString *videoPath,UIImage *image);

@end
