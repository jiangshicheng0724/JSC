//
//  AdViewController.m
//  JSCTool
//
//  Created by zuosen on 2019/3/28.
//  Copyright © 2019 jsc. All rights reserved.
//

#import "AdViewController.h"
#import "SDCycleScrollView.h"

@interface AdViewController ()<SDCycleScrollViewDelegate>
/**  轮播图 */
@property (nonatomic , strong) SDCycleScrollView  *cycleScrollView;

@property (nonatomic , strong) NSMutableArray  *muPic;

@end

@implementation AdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.muPic = [NSMutableArray array];
    
    NSArray *arr = @[@"https://chaoqi.oss-cn-hangzhou.aliyuncs.com/image/20190318/20f4f8f131152f95c867e5d084c19451.png",@"https://chaoqi.oss-cn-hangzhou.aliyuncs.com/image/20190318/20f4f8f131152f95c867e5d084c19451.png",@"https://chaoqi.oss-cn-hangzhou.aliyuncs.com/image/20190318/db8f47e751f86c15d1507c456c94fa92.png"];
    
    for (int i = 0; i < arr.count; i ++) {
        [self.muPic addObject:arr[i]];
    }
    
    self.cycleScrollView.imageURLStringsGroup = self.muPic;

}

- (SDCycleScrollView *)cycleScrollView{
    if (!_cycleScrollView) {
        
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:PLACEHOLDERGOODSIMAGE];
        _cycleScrollView.layer.masksToBounds = YES;
        _cycleScrollView.layer.cornerRadius = 30;
        _cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
        _cycleScrollView.showPageControl = YES;
        _cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
        _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        _cycleScrollView.backgroundColor = ClearColor;
//        _cycleScrollView.pageDotImage = [UIImage imageNamed:@"home_dot_yuan"];
//        _cycleScrollView.currentPageDotImage = [UIImage imageNamed:@"home_dot_chang"];
//        _cycleScrollView.pageControlDotSize = CGSizeMake(15, 6);
        [self.view addSubview:_cycleScrollView];
        [_cycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(50);
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            make.height.mas_equalTo(200);
        }];
        
    }return _cycleScrollView;
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
