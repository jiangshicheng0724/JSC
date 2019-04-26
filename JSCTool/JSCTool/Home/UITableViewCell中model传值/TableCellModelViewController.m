//
//  YYMNewAddBillViewController.m
//  YingYunStore
//
//  Created by zuosen on 2019/4/4.
//  Copyright © 2019 班文政. All rights reserved.
//

#import "TableCellModelViewController.h"
#import "YYMAddNewBillView.h"
#import "YYMNewAddBillModel.h"

@interface TableCellModelViewController ()<UITableViewDelegate,UITableViewDataSource>
/**  tableView */
@property (nonatomic , strong) UITableView  *tableView;

/**  添加发票 */
@property (nonatomic , strong) UIButton  *finishBtn;

@property (nonatomic , strong) NSArray  *arrTextLeft;

@property (nonatomic , strong) NSArray  *arrTextRight;

@property (nonatomic , strong) UILabel *labelChooseBill;

@property(nonatomic , strong) NSMutableArray <YYMNewAddBillModel *>*arrModel;

@property (nonatomic , strong) NSMutableArray  *arrInvoiceType;
@property (nonatomic , strong) NSMutableArray  *arrInvoiceCate_id;
@property (nonatomic , assign) NSInteger  inxde;


@end

@implementation TableCellModelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.inxde = -11;
    
    self.arrInvoiceType = [NSMutableArray array];
    self.arrInvoiceCate_id = [NSMutableArray array];

    
    self.navigationItem.title = @"新增发票";
    self.arrModel = [NSMutableArray array];
    self.arrTextLeft = @[@"发票抬头",@"纳税人号",@"地     址",@"电     话",@"开户银行",@"银行账号"];
    self.arrTextRight = @[@"请填写公司全称/个人",@"请填写纳税人识别码",@"请填写地址",@"请填写电话",@"请填写开户银行",@"请填写银行账号"];
    for (int i = 0; i < 6; i++) {
        YYMNewAddBillModel *model = [[YYMNewAddBillModel alloc] init];
        model.textLeft = self.arrTextLeft[i];
        model.textRight = self.arrTextRight[i];
        [self.arrModel addObject:model];
    }
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorColor = TableColor;
    
    @weakify(self);
    [self.finishBtn bk_whenTapped:^{
        DLog(@"确定");
        @strongify(self);
        DLog(@"******%ld",(long)self.inxde);
        NSString *invoice_type = @"";
//        if (self.inxde != -11) {
//            invoice_type = self.arrInvoiceCate_id[self.inxde];
//        }else{
//            [self showToastWithText:@"请选择发票类型" afterDelay:0];
//            return ;
//        }
        NSString *invoice_title = @"";
        if (![RYToolClass isBlankString:self.arrModel[0].textRightFiled]) {
            invoice_title = self.arrModel[0].textRightFiled;
        }
        NSString *invoice_taxpayer_num = @"";
        if (![RYToolClass isBlankString:self.arrModel[1].textRightFiled]) {
            invoice_taxpayer_num = self.arrModel[1].textRightFiled;
        }
        NSString *invoice_taxpayer_tel = @"";
        if ([RYToolClass valiMobile:self.arrModel[3].textRightFiled]) {
            invoice_taxpayer_tel = self.arrModel[3].textRightFiled;
        }else{
            [self showToastWithText:@"请输入正确的电话号码" afterDelay:0];
            return;
        }
        NSString *invoice_taxpayer_address = @"";
        if (![RYToolClass isBlankString:self.arrModel[2].textRightFiled]) {
            invoice_taxpayer_address = self.arrModel[2].textRightFiled;
        }
        NSString *invoice_taxpayer_bankname = @"";
        if (![RYToolClass isBlankString:self.arrModel[4].textRightFiled]) {
            invoice_taxpayer_bankname = self.arrModel[4].textRightFiled;
        }
        NSString *invoice_taxpayer_bankno = @"";
        if ([RYToolClass isBankCard:self.arrModel[5].textRightFiled]) {
            invoice_taxpayer_bankno = self.arrModel[5].textRightFiled;
        }else{
            [self showToastWithText:@"请输入正确的银行卡号" afterDelay:0];
            return;
        }
        NSDictionary *parameters = @{
                                     @"invoice_type":invoice_type,
                                     @"invoice_title":invoice_title,
                                     @"invoice_taxpayer_num":invoice_taxpayer_num,
                                     @"invoice_taxpayer_tel":invoice_taxpayer_tel,
                                     @"invoice_taxpayer_address":invoice_taxpayer_address,
                                     @"invoice_taxpayer_bankname":invoice_taxpayer_bankname,
                                     @"invoice_taxpayer_bankno":invoice_taxpayer_bankno,
                                     };
//        [[[UIApplication sharedApplication] keyWindow] showHubMsg:@"正在加载..."];
        
        DLog(@"----------------parameters:%@",parameters);
        
    }];
    UIView *headView = [UIView wz_viewWithBackgroundColor:WhiteColor superView:[UIView new]];
    headView.frame = CGRectMake(0, 0, kScreenWidth, 90);
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0 , kScreenWidth, 10)];
    lineView.backgroundColor = TableColor;
    [headView addSubview:lineView];
    UILabel *labelBill = [UILabel labelWithText:@"  发票信息" font:WZFont(16) textColor:ThemeColor backGroundColor:ClearColor superView:headView];
    [labelBill mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(10);
        make.height.mas_equalTo(40);
    }];
    UILabel *labelSize = [UILabel labelWithText:@"  发票类型" font:WZFont(16) textColor:SecondColor backGroundColor:ClearColor superView:headView];
    [labelSize mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(50);
        make.height.mas_equalTo(40);
    }];
    
    self.labelChooseBill = [UILabel labelWithText:@"" font:WZFont(16) textColor:SecondColor backGroundColor:ClearColor superView:labelSize];
    [self.labelChooseBill mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(-30);
        make.height.mas_equalTo(40);
    }];
    
    UIImageView *imgMore = [UIImageView imageViewWithSuperView:labelSize];
    imgMore.image = [UIImage imageNamed:@"tk_icon_more"];
    [imgMore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(labelSize);
        make.right.mas_equalTo(-15);
    }];
    
    labelSize.userInteractionEnabled = YES;
    [labelSize bk_whenTapped:^{
     
    }];
    
    self.tableView.tableHeaderView = headView;
    self.tableView.tableHeaderView.wz_height = 90;
    
}

-(void)seleAddBill:(NSArray *)array{
    //    DLog(@"---%@--",array);
    
    for (int i = 0; i < array.count; i ++) {
        if (![array[i] isEqualToString:@"0"]) {
            self.labelChooseBill.text = self.arrInvoiceType[i];
            self.inxde = i ;
        }
    }
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
}

- (void)requestAddNewBillList{
    
//    [[[UIApplication sharedApplication] keyWindow] showHubMsg:@"正在加载..."];

}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 10;
//}
//- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
//    headerView.backgroundColor = TableColor;
//    return headerView;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.确定重用标示:
    static NSString *ID = @"UITableViewCell";
    // 2.从缓存池中取
    YYMAddNewBillView *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    // 3.如果空就手动创建
    if (!cell) {
        cell = [[YYMAddNewBillView alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [cell setUpWith:self.arrModel[indexPath.row]];
    
    return cell;
}


- (UITableView *)tableView{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] init];
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.mas_equalTo(0);
            make.bottom.mas_equalTo(-55);
        }];
    }return _tableView;
}

- (UIButton *)finishBtn{
    if (!_finishBtn) {
        
        _finishBtn = [UIButton buttonWithNormalTitle:@"确定" selectTitle:@"确定" normalImg:[UIImage new] selectImg:[UIImage new] normalTitleColor:WhiteColor selectTitleColor:WhiteColor font:[UIFont boldSystemFontOfSize:18] backGroundColor:ThemeColor superView:self.view];
        [_finishBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(-15);
            make.left.mas_equalTo(15);
            make.width.mas_equalTo(kScreenWidth - 30);
            make.height.mas_equalTo(40);
        }];
    }
    return _finishBtn;
}
@end

