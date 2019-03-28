//
//  MusicViewController.m
//  JSCTool
//
//  Created by zuosen on 2019/3/28.
//  Copyright © 2019 jsc. All rights reserved.
//

#import "MusicViewController.h"

//图片预览框架
#import "ZWPhotoPreview.h"

@interface MusicViewController ()


@end

@implementation MusicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *mutArray = [NSMutableArray array];
    for (NSInteger i = 0; i < 5;  i++) {
        ZWPhotoPreviewDataModel *model1 = [[ZWPhotoPreviewDataModel alloc] init];
        model1.zw_photoURL = @"https://chaoqi.oss-cn-hangzhou.aliyuncs.com/image/20190318/20f4f8f131152f95c867e5d084c19451.png";
        model1.zw_photoTitle = @"春风十里不如你蠢";
        model1.zw_photoDesc = @"春风十里不如你蠢春风十里不如你蠢春风十里不如你蠢";
        [mutArray addObject:model1];
        
//        ZWPhotoPreviewDataModel *model3 = [[ZWPhotoPreviewDataModel alloc] init];
//        model3.zw_photoImage = [UIImage imageNamed:@""];
//        [mutArray addObject:model3];

        ZWPhotoPreviewDataModel *model2 = [[ZWPhotoPreviewDataModel alloc] init];
        model2.zw_photoURL = @"https://upload-images.jianshu.io/upload_images/3237547-a10a31a222c65251.gif";
        model2.zw_photoTitle = @"机会难得得不到你";
        model2.zw_photoDesc = @"机会难得得不到你机会难得得不到你\n机会难得得不到你机会难得得不到你";
        [mutArray addObject:model2];
    }
    ZWPhotoPreview *view = [ZWPhotoPreview zw_showPhotoPreview:mutArray];
    view.showIndex = 0;
    
    
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
