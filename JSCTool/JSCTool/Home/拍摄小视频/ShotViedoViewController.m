//
//  ShotViedoViewController.m
//  JSCTool
//
//  Created by zuosen on 2019/3/28.
//  Copyright © 2019 jsc. All rights reserved.
//

#import "ShotViedoViewController.h"
#import "SGRecordViewController.h"
#import "ViedoPlayViewController.h"

@interface ShotViedoViewController ()
//视频
@property (nonatomic , strong) NSString  *viedoStr;
@property (nonatomic , strong) UIImageView  *viedoViewAdd;

@property (nonatomic , strong) UIImageView  *viedoView;
@property (nonatomic , strong) UIImageView  *viedoPlayView;
@property (nonatomic , strong) UIImageView  *btnDeleteViedo;

@end

@implementation ShotViedoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    @weakify(self);
    self.viedoViewAdd.image = [UIImage imageNamed:@"fb_content_icon_more"];
    self.viedoViewAdd.userInteractionEnabled = YES;
    [self.viedoViewAdd bk_whenTapped:^{
        @strongify(self);
        //        长按10秒录制视频
        [self publishVideoDidSelectCamera];
    }];
    
    self.btnDeleteViedo.hidden = YES;
    self.btnDeleteViedo.userInteractionEnabled = YES;
    self.btnDeleteViedo.image = [UIImage imageNamed:@"fb_content_icon_quxiao"];
    [self.btnDeleteViedo bk_whenTapped:^{
        @strongify(self);
        DLog(@"删除视频");
        self->_viedoStr = @"";
        self.viedoView.hidden = YES;
        self.viedoViewAdd.hidden = NO;
    }];
    
}


//点击录制视频
- (void)publishVideoDidSelectCamera{
    
    //判断是否有视频有视频 播放视频
    //    if ([RYToolClass isBlankString:_videoModel.videoPath]) {
    
    @weakify(self);
    SGRecordViewController *vc = [[SGRecordViewController alloc]init];
    vc.recordViewBackBlock = ^(NSString *videoPath, UIImage *image) {
        @strongify(self);
        DLog(@"----%@",videoPath);
        self->_viedoStr = videoPath;
        self.viedoViewAdd.hidden = YES;
        self.btnDeleteViedo.hidden = NO;
        self.viedoView.hidden = NO;
        
        @weakify(self);
        self.viedoView.userInteractionEnabled = YES;
        [self.viedoView bk_whenTapped:^{
            
        }];
        //视频获取缩略图
        self.viedoView.image = image;
        self.viedoPlayView.userInteractionEnabled = YES;
        self.viedoPlayView.image = [UIImage imageNamed:@"hd_content_icon_play"];
        [self.viedoPlayView bk_whenTapped:^{
            @strongify(self);
            DLog(@"播放视频");
            ViedoPlayViewController *vc = [[ViedoPlayViewController alloc] init];
            vc.viedoPtah = self->_viedoStr;
            [self presentViewController:vc animated:YES completion:^{
                
            }];
        }];
    };
    [self presentViewController:vc animated:YES completion:nil];
    //    }else{
    //
    //        PCIVideoPlayViewController *vc = [[PCIVideoPlayViewController alloc] init];
    //        vc.videoUrl = _videoModel.videoPath;
    //        [self presentViewController:vc animated:YES completion:nil];
    //    }
}


- (UIImageView *)viedoViewAdd
{
    if (!_viedoViewAdd) {
        
        _viedoViewAdd = [UIImageView imageViewWithSuperView:self.view];
        
        [_viedoViewAdd mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake((94), (94)));
            make.left.mas_equalTo((30));
            make.top.mas_equalTo(150);
        }];
    }
    return _viedoViewAdd;
}

- (UIImageView *)viedoView
{
    if (!_viedoView ) {
        
        _viedoView = [UIImageView imageViewWithSuperView:self.view];
        
        [_viedoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake((94), (94)));
            make.left.mas_equalTo((30));
            make.top.mas_equalTo(150);
        }];
    }
    return _viedoView;
}
- (UIImageView *)viedoPlayView
{
    if (!_viedoPlayView ) {
        
        _viedoPlayView = [UIImageView imageViewWithSuperView:self.viedoView];
        
        [_viedoPlayView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake((35), (35)));
            make.centerX.centerY.mas_equalTo(0);
        }];
    }
    return _viedoPlayView;
}
- (UIImageView *)btnDeleteViedo
{
    if (!_btnDeleteViedo ) {
        
        _btnDeleteViedo = [UIImageView imageViewWithSuperView:self.viedoView];
        
        [_btnDeleteViedo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake((18), (18)));
            make.right.mas_equalTo(-1);
            make.top.mas_equalTo(1);
        }];
    }
    return _btnDeleteViedo;
}
@end
