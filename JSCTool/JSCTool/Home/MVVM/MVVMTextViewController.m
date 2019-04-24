//
//  MVVMTextViewController.m
//  JSCTool
//
//  Created by zuosen on 2019/4/24.
//  Copyright © 2019 jsc. All rights reserved.
//

#import "MVVMTextViewController.h"
#import "MVVMTableViewCell.h"
#import "MVVMModel.h"
#import "MVVMViewModel.h"

@interface MVVMTextViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) UITableView  *tableView;

@property (nonatomic , strong) NSMutableArray<MVVMViewModel *>  *muViewModel;

@end

@implementation MVVMTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"MVVM";
    
    self.tableView.backgroundColor = WhiteColor;
    
    self.muViewModel = [NSMutableArray array];
    
    NSArray *name_arr = @[@"浙江省杭州市滨江区江南大道1080号",@"浙江省杭州市滨江区江南大道1080号浙江省杭州市滨江区江南大道1080号",@"浙江省杭州市滨江区江南大道1080号",@"浙江省杭州市滨江区江南大道1080号浙江省杭州市滨江区江南大道1080号浙江省杭州市滨江区江南大道1080号浙江省杭州市滨江区江南大道1080号浙江省杭州市滨江区江南大道1080号浙江省杭州市滨江区江南大道1080号",@"浙江省杭州市滨江区江南大道1080号",@"浙江省杭州市滨江区江南大道1080号浙江省杭州市滨江区江南大道1080号",@"浙江省杭州市滨江区江南大道1080号",@"浙江省杭州市滨江区江南大道1080号浙江省杭州市滨江区江南大道1080号浙江省杭州市滨江区江南大道1080号浙江省杭州市滨江区江南大道1080号浙江省杭州市滨江区江南大道1080号浙江省杭州市滨江区江南大道1080号",@"浙江省杭州市滨江区江南大道1080号",@"浙江省杭州市滨江区江南大道1080号浙江省杭州市滨江区江南大道1080号",@"浙江省杭州市滨江区江南大道1080号",@"浙江省杭州市滨江区江南大道1080号浙江省杭州市滨江区江南大道1080号浙江省杭州市滨江区江南大道1080号浙江省杭州市滨江区江南大道1080号浙江省杭州市滨江区江南大道1080号浙江省杭州市滨江区江南大道1080号"];
    
    NSArray *text_arr = @[@"浙江省杭州市滨江区莱蒙水榭春天3幢浙江省杭州市滨江区莱蒙水榭春天3幢浙江省杭州市滨江区莱蒙水榭春天3幢浙江省杭州市滨江区莱蒙水榭春天3幢",@"浙江省杭州市滨江区莱蒙水榭春天3幢浙江省杭州市滨江区莱蒙水榭春天3幢浙江省杭州市滨江区莱蒙水榭春天3幢",@"浙江省杭州市滨江区莱蒙水榭春天3幢",@"浙江省杭州市滨江区莱蒙水榭春天3幢浙江省杭州市滨江区莱蒙水榭春天3幢浙江省杭州市滨江区莱蒙水榭春天3幢浙江省杭州市滨江区莱蒙水榭春天3幢",@"浙江省杭州市滨江区莱蒙水榭春天3幢浙江省杭州市滨江区莱蒙水榭春天3幢浙江省杭州市滨江区莱蒙水榭春天3幢",@"浙江省杭州市滨江区莱蒙水榭春天3幢",@"浙江省杭州市滨江区莱蒙水榭春天3幢浙江省杭州市滨江区莱蒙水榭春天3幢浙江省杭州市滨江区莱蒙水榭春天3幢浙江省杭州市滨江区莱蒙水榭春天3幢",@"浙江省杭州市滨江区莱蒙水榭春天3幢浙江省杭州市滨江区莱蒙水榭春天3幢浙江省杭州市滨江区莱蒙水榭春天3幢",@"浙江省杭州市滨江区莱蒙水榭春天3幢",@"浙江省杭州市滨江区莱蒙水榭春天3幢浙江省杭州市滨江区莱蒙水榭春天3幢浙江省杭州市滨江区莱蒙水榭春天3幢浙江省杭州市滨江区莱蒙水榭春天3幢",@"浙江省杭州市滨江区莱蒙水榭春天3幢浙江省杭州市滨江区莱蒙水榭春天3幢浙江省杭州市滨江区莱蒙水榭春天3幢",@"浙江省杭州市滨江区莱蒙水榭春天3幢"];
    
    for (int i = 0; i < 10; i ++) {
        MVVMModel *model = [[MVVMModel alloc] init];
        model.name = name_arr[i];
        model.text = text_arr[i];
        
        MVVMViewModel *viewModel = [[MVVMViewModel alloc] initWithModel:model];
        [self.muViewModel addObject:viewModel];
    }
    
    [self.tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.muViewModel[indexPath.row].heigh_name + self.muViewModel[indexPath.row].heigh_text + 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.muViewModel.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    // 1.确定重用标示:
    static NSString *ID = @"YYSOrderListTableViewCell";
    // 2.从缓存池中取
    MVVMTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    // 3.如果空就手动创建
    if (!cell) {
        cell = [[MVVMTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.backgroundColor = WhiteColor;
    
    [cell setUpWithViewModel:self.muViewModel[indexPath.row]];
    
    cell.textLabel.textColor = RedColor;
    
    return cell;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
    }
    return _tableView;
}

@end
