//
//  PhotoViewController.m
//  JSCTool
//
//  Created by zuosen on 2019/3/28.
//  Copyright © 2019 jsc. All rights reserved.
//

#import "PhotoViewController.h"
#import "ZSImagePickView.h"
#import <Photos/Photos.h>

@interface PhotoViewController (){
    NSString *_type;
    UIViewController *_parentViewController;
    NSArray<PHAsset *> *_selectedAssets;//图片
    
}
//图片
@property (nonatomic , strong) ZSImagePickView  *pictureView;

@end

@implementation PhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    @weakify(self);
    self.pictureView.imagePickViewBackBlock = ^(NSArray * _Nonnull selectedPhotos, NSArray * _Nonnull selectedAssets, CGFloat ImagePickViewMinHeight) {
        @strongify(self);
        self->_selectedAssets = selectedAssets;
        
        //        [self.pictureView mas_updateConstraints:^(MASConstraintMaker *make) {
        //            make.height.mas_equalTo(ImagePickViewMinHeight);
        //        }];
    };
    
}


- (ZSImagePickView *)pictureView{
    
    if (!_pictureView ) {
        _pictureView = [[ZSImagePickView alloc] initWithFrame:CGRectMake(0, 80, kScreenWidth, PCIPictureWidth + 200)];
        _pictureView.backgroundColor = WhiteColor;
        _pictureView.isTakePhoto = YES;
        _pictureView.columnNumber = 3;
        _pictureView.isPickingImage = YES;
        _pictureView.isPickingVideo = NO;
        _pictureView.isShowSelectedIndex = YES;
        _pictureView.isTakeVideo = NO;
        [self.view addSubview:_pictureView];
        //        [_pictureView mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.height.mas_equalTo(PCIPictureWidth + 30);
        //            make.left.right.mas_equalTo(0);
        //            make.top.mas_equalTo(130);
        //        }];
        
    }
    return _pictureView;
}
@end
