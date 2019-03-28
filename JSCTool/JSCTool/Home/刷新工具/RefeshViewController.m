//
//  RefeshViewController.m
//  JSCTool
//
//  Created by zuosen on 2019/3/28.
//  Copyright © 2019 jsc. All rights reserved.
//

#import "RefeshViewController.h"
#import "HHRefreshHeader.h"
#import "HHRefreshFooter.h"

@interface RefeshViewController ()<UITableViewDelegate,UITableViewDataSource>
/**  tableView */
@property (nonatomic , strong) UITableView  *tableView;

@end

@implementation RefeshViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"刷新工具";
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorColor = TableColor;
    self.tableView.backgroundColor = TableColor;
    
    [self tableViewPullup];
}

#pragma mark -  上啦加载下啦刷新
- (void)tableViewPullup{
    
    self.tableView.mj_header = [HHRefreshHeader headerWithRefreshingBlock:^{
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
        });
        
    }];
    
    self.tableView.mj_footer = [HHRefreshFooter footerWithRefreshingBlock:^{

        
    }];
    self.tableView.mj_footer.hidden = YES;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    int value = arc4random() % 11;
    
    return value + 2;
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
    
    cell.textLabel.text = [NSString stringWithFormat:@"第几行%ld",(long)indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

@end
