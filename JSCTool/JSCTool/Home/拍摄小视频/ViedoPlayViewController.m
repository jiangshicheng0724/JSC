//
//  ViedoPlayViewController.m
//  SuperEducation
//
//  Created by zuosen on 2018/12/20.
//  Copyright © 2018 zuosen. All rights reserved.
//

#import "ViedoPlayViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViedoPlayViewController ()
@property (strong, nonatomic)AVPlayer *myPlayer;//播放器
@property (strong, nonatomic)AVPlayerItem *item;//播放单元
@property (strong, nonatomic)AVPlayerLayer *playerLayer;//播放界面（layer）
@property (nonatomic, strong) UIImageView      *dismissController;

@end

@implementation ViedoPlayViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self playViedo];
    
    
    _dismissController = [UIImageView imageViewWithSuperView:self.view];
    [_dismissController mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake((30), (30)));
        make.right.mas_equalTo(-(10));
        make.top.mas_equalTo((30));
    }];
    
    
    @weakify(self);
    _dismissController.userInteractionEnabled = YES;
    _dismissController.image = [UIImage imageNamed:@"yx_content_icon_back"];
    [self.dismissController bk_whenTapped:^{
        @strongify(self);
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }];
    
 }

-(void)playViedo{
    NSURL * mediaURL;
    if (_viedoUrl == nil) {
        mediaURL = [NSURL fileURLWithPath:_viedoPtah];
    }else{
        mediaURL = [NSURL URLWithString:_viedoUrl];
    }
    self.item = [AVPlayerItem playerItemWithURL:mediaURL];
    self.myPlayer = [AVPlayer playerWithPlayerItem:self.item];
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.myPlayer];
    self.playerLayer.frame = CGRectMake(0, (0), kScreenWidth, kScreenHeight);
//    self.playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.view.layer addSublayer:self.playerLayer];
    [self.myPlayer play];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
