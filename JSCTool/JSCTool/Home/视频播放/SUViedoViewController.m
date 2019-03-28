//
//  ViewController.m
//  ZQVideoPlayer
//
//  Created by wang on 2018/4/13.
//  Copyright © 2018年 wang. All rights reserved.
//

#import "SUViedoViewController.h"
#import"UIImage+GIF.h"

#import "ZQPlayerMaskView.h"
//#import <ZQPlayerLandSpaceViewController.h>
#import "AppDelegate.h"


@interface SUViedoViewController ()<ZQPlayerDelegate>

/** 视频播放器*/
@property (nonatomic, strong) ZQPlayerMaskView *playerMaskView;


/** 音频播放器 */
//@property (nonatomic, strong) ZQPlayer *audioPlayer;

@end

@implementation SUViedoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.playerMaskView = [[ZQPlayerMaskView alloc] init];
    self.playerMaskView.delegate = self;
    
    self.playerMaskView.isWiFi = YES; // 是否允许自动加载，
    self.playerMaskView.userInteractionEnabled = YES;
    self.playerMaskView.contentMode = UIViewContentModeScaleAspectFill;
    self.playerMaskView.titleLab.text = @"";
    
    [self.view addSubview:self.playerMaskView];
    
    self.playerMaskView.backgroundImage.backgroundColor= [UIColor clearColor];
    
    //    _playerMaskView.backgroundImage.image= [UIImage sd_animatedGIFWithData:[self gifData]];
    
    // 网络视频
    //    NSString *videoUrl = @"http://www.ytmp3.cn/down/55906.mp3";
    
    NSString *videoUrl = @"https://chaoqi.oss-cn-hangzhou.aliyuncs.com/video/20190110/44851543d31e6fa0f6f86d7a59fb0093.mp4";
    
    // 本地视频
    // NSString *videoUrl = [[NSBundle mainBundle] pathForResource:@"video" ofType:@"mp4"];
    
    //设置历史记录时间
//        [_playerMaskView startWithTime:0];
    [self.playerMaskView playWithVideoUrl:videoUrl];
    
    [self.playerMaskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(70);
        make.height.mas_equalTo((420));
    }];
    
    
}

#pragma mark - 播放KVO监测
- (void)ZQPlayerCurrentTime:(ZQPlayer *)player currentTime:(CGFloat)time{
    NSLog(@"当前时间：%ld秒",(long)time);

}




#pragma mark -  设置gif图片
-(NSData *)gifData{
    NSString *filePath = [[NSBundle bundleWithPath:[[NSBundle mainBundle] bundlePath]]pathForResource:@"music" ofType:@"gif"];
    NSData *imageData = [NSData dataWithContentsOfFile:filePath];
    return  imageData;
}


#pragma mark - 屏幕旋转

//1.决定当前界面是否开启自动转屏，如果返回NO，后面两个方法也不会被调用，只是会支持默认的方向
- (BOOL)shouldAutorotate {
    return NO;
}

//2.返回支持的旋转方向
//iPad设备上，默认返回值UIInterfaceOrientationMaskAllButUpSideDwon
//iPad设备上，默认返回值是UIInterfaceOrientationMaskAll
- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskAll;
}

//3.返回进入界面默认显示方向
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}
// 全屏需要重写方法
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator  {
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    if (orientation == UIDeviceOrientationPortrait || orientation
        == UIDeviceOrientationPortraitUpsideDown) {

        // 隐藏导航栏
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        [_playerMaskView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(70);
            make.height.mas_equalTo((420));
        }];
    }else {
        
        // 显示导航栏
        [self.navigationController setNavigationBarHidden:YES animated:YES];

        [_playerMaskView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
//        [_viewB bringSubviewToFront:_playerMaskView];

    }
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
}

-(void)viewDidDisappear:(BOOL)animated{
    [self.playerMaskView.player pause];

}

#pragma mark - 上传播放时长
-(void)viewWillDisappear:(BOOL)animated{
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.allowRotation = NO;
}


#pragma mark -  是否允许旋转
-(void)viewWillAppear:(BOOL)animated{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.allowRotation = YES;
}

@end
