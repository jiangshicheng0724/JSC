//
//  LMNWebViewController.m
//  LMNote
//
//  Created by littleMeaning on 2018/7/12.
//  Copyright © 2018年 littleMeaning. All rights reserved.
//

#import "LMNWebViewController.h"
@import WebKit;

@interface LMNWebViewController ()<UIWebViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIWebView *webview;
/**  头像 */
@property (nonatomic , strong) UIImageView  *iconImgview;
/**  name */
@property (nonatomic , strong) UILabel  *nameLbl;
/**  时间 */
@property (nonatomic , strong) UILabel  *dateLbl;
/**  详情 */
@property (nonatomic , strong) UILabel  *orderNumberLbl;
@property (nonatomic , strong) UIView  *backView;
@property(nonatomic,strong) UITableView *tableView;

@end

@implementation LMNWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationItem.title = @"案例详情";
//    self.view.backgroundColor = [UIColor whiteColor];
//
//    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
//    [self.view addSubview:self.tableView];
//    self.tableView.dataSource = self;
//    self.tableView.delegate = self;
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
//    self.tableView.separatorColor = ClearColor;
//    [self.tableView  mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.mas_equalTo(0);
//    }];
//
//    [SVProgressHUD showWithStatus:@"加载中..."];
//    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
//
//
//    [self.iconImgview sd_setImageWithURL:[NSURL URLWithString:self.dicResult[@"avatar"]]];
//    self.nameLbl.text = self.dicResult[@"nickname"];
//    self.dateLbl.text = [self create_at];
//    self.orderNumberLbl.text = self.dicResult[@"title"];
//    self.orderNumberLbl.numberOfLines = 3;
//    //文字高度
//    CGFloat h_title = [NSString sizeWithText:self.dicResult[@"title"] font:kwFont(16) maxSize:CGSizeMake(kScreenWidth - KLineX(30), MAXFLOAT)].height ;
//    DLog(@"-----%f",h_title);
//
//    if (h_title > 70) {
//        h_title = 69;
//    }
//    self.backView.frame = CGRectMake(0, 0, kScreenWidth, 65 + h_title);
//    self.webview.frame = CGRectMake(0, 65 + h_title, kScreenWidth, kScreenHeight - 65 - h_title - 64);
//    self.tableView.tableHeaderView = self.backView;

}
-(void)viewDidAppear:(BOOL)animated{
}

-(NSString *)create_at{
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    // 设置日期格式(为了转换成功)
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    // NSString * -> NSDate *
    NSDate *date = [fmt dateFromString:self.dicResult[@"create_at"]];
    
    //    NSDate *date = [NSDate date];
    
    NSDateFormatter *fmt2 = [[NSDateFormatter alloc] init];
    fmt2.dateFormat = @"yyyy-MM-dd";
    
    NSString *string2 = [fmt2 stringFromDate:date];
    
    return string2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{

    return [UIView wz_viewWithBackgroundColor:ClearColor superView:nil];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    // 1.确定重用标示:
    static NSString *ID = @"YYSAskTableViewCell";
    // 2.从缓存池中取
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    // 3.如果空就手动创建
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;

}


- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
}



- (void)setDicResult:(NSDictionary *)dicResult
{
    _dicResult = [dicResult copy];
    [self.webview loadHTMLString:dicResult[@"content"] baseURL:nil];
}
//
//-(void)webViewDidFinishLoad:(UIWebView *)webView{
//    NSString *jsMeta = [NSString stringWithFormat:@"var meta = document.createElement('meta');meta.content='telephone=no';meta.name='format-detection';document.getElementsByTagName('head')[0].appendChild(meta);"];
//    [webView stringByEvaluatingJavaScriptFromString:jsMeta];
//    [SVProgressHUD dismiss];
//
//    CGSize fit = [webView sizeThatFits:CGSizeZero];
//    [self.tableView beginUpdates];
//    self.tableView.tableFooterView = webView;
//    self.tableView.tableFooterView.height = fit.height;
//    [self.tableView endUpdates];
//
//}


- (UIImageView *)iconImgview{
    
    if (!_iconImgview) {
        
        _iconImgview = [UIImageView imageViewWithSuperView:self.backView];
        [_iconImgview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake((30), (30)));
            make.left.mas_equalTo((15));
            make.top.mas_equalTo((10));
        }];
        
        _iconImgview.layer.cornerRadius = (30)/2;
        _iconImgview.layer.masksToBounds = YES;
        
    }
    return _iconImgview;
}
- (UILabel *)nameLbl
{
    if (!_nameLbl) {
        
        _nameLbl = [UILabel labelWithText:@"" font:WZFont(14) textColor:SecondColor backGroundColor:ClearColor superView:self.backView];
        [_nameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            //            make.left.mas_equalTo(self.headerImgview.mas_right).mas_equalTo((10));
            make.centerY.mas_equalTo(self.iconImgview);
            make.left.mas_equalTo((51));
        }];
    }
    return _nameLbl;
}
- (UILabel *)dateLbl{
    
    if (!_dateLbl) {
        
        _dateLbl = [UILabel labelWithText:@"" font:WZFont(12) textColor:ThirdColor backGroundColor:ClearColor superView:self.backView];
        [_dateLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.iconImgview);
            make.right.mas_equalTo(-15);
        }];
    }
    return _dateLbl;
}
- (UILabel *)orderNumberLbl{
    
    if (!_orderNumberLbl) {
        
        _orderNumberLbl = [UILabel labelWithText:@"" font:WZFont(16) textColor:FirstColor backGroundColor:ClearColor superView:self.backView];
        
        [_orderNumberLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.iconImgview.mas_bottom).mas_equalTo(12);;
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
        }];
    }
    return _orderNumberLbl;
}
//- (UIWebView *)webview{
//    
//    if (!_webview) {
//        
//        _webview = [[UIWebView alloc] init];
//        _webview.delegate = self;
//        _webview.scrollView.bounces = NO;
//        [self.view addSubview:_webview];
//    }
//    return _webview;
//}
//- (UIView *)backView{
//    
//    if (!_backView) {
//        
//        _backView = [[UIWebView alloc] init];
//        _backView.backgroundColor = WhiteColor;
//        [self.view addSubview:_backView];
//    }
//    return _backView;
//}

@end
