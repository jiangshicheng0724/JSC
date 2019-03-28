//
//  YYMHomeViewController.m
//  YingYunStore
//
//  Created by 班文政 on 2019/3/2.
//  Copyright © 2019 班文政. All rights reserved.
//

#import "YYMHomeViewController.h"
#import "AdViewController.h"
#import "PhotoViewController.h"
#import "SUViedoViewController.h"
#import "ShotViedoViewController.h"
#import "MusicViewController.h"
#import "YYMCancalOrderController.h"

@interface YYMHomeViewController ()<UITableViewDelegate,UITableViewDataSource>
/**  tableView */
@property (nonatomic , strong) UITableView  *tableView;

@property (nonatomic , strong) NSArray  *arrTitle;

@end

@implementation YYMHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"首页";
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -22, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorColor = TableColor;
    self.tableView.backgroundColor = TableColor;
    
    self.arrTitle = @[@"广告轮播图",@"照片选择器",@"视频播放",@"拍摄小视频",@"语言录制",@"弹出选择框"];
    
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //隐藏导航栏
    [[self navigationController] setNavigationBarHidden:YES animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //隐藏导航栏
    [[self navigationController] setNavigationBarHidden:NO animated:NO];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrTitle.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.确定重用标示:
    static NSString *ID = @"YYSOrderListTableViewCell";
    // 2.从缓存池中取
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    // 3.如果空就手动创建
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.backgroundColor = WhiteColor;
    
    cell.textLabel.text = self.arrTitle[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        AdViewController *vc = [[AdViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if(indexPath.row == 1){
        PhotoViewController *vc = [[PhotoViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if(indexPath.row == 2){
        SUViedoViewController *vc = [[SUViedoViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if(indexPath.row == 3){
        ShotViedoViewController *vc = [[ShotViedoViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 4){
        MusicViewController *vc = [[MusicViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 5){
        YYMCancalOrderController *vc = [[YYMCancalOrderController alloc] init];
        vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
        vc.cancalText = @[@"不喜欢/不想要",@"商品买错（颜色、尺寸等选错）",@"未按约定时间发货",@"缺货",@"地址写错",@"其他原因"];
        [self presentViewController:vc animated:YES completion:nil];
    }
}


@end
