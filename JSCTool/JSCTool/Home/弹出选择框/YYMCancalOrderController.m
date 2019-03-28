//
//  YYMOrderDetailServiceController.m
//  YingYunStore
//
//  Created by 班文政 on 2019/3/16.
//  Copyright © 2019 班文政. All rights reserved.
//

#import "YYMCancalOrderController.h"

#import "YYMCancalOrderTableViewCell.h"

@interface YYMCancalOrderController ()<UITableViewDelegate,UITableViewDataSource>

/**  遮罩 */
@property (nonatomic , strong) UIView  *maskView;
/**  内容 */
@property (nonatomic , strong) UIView  *contentView;
/**  tableView */
@property (nonatomic , strong) UITableView  *tableView;
/**  完成 */
@property (nonatomic , strong) UIButton  *finishBtn;

//@property (nonatomic , strong) NSArray  *cancalText;
/**  */
@property (nonatomic , strong) NSMutableArray  *cancalFlag;
@end

@implementation YYMCancalOrderController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.cancalFlag = [NSMutableArray array];
    
    for (int i = 0; i < self.cancalText.count; i ++) {
        [self.cancalFlag addObject:@"0"];
    }
    [self loadUI];

}

- (void)loadUI{
    
    self.view.backgroundColor = ClearColor;
    
    [self.maskView bk_whenTapped:^{
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [self.finishBtn bk_whenTapped:^{
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    UILabel *titleLbl = [UILabel labelWithText:@"取消订单原因" font:WZFont(16) textColor:SecondColor backGroundColor:ClearColor superView:self.contentView];
    [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.centerX.mas_equalTo(0);
    }];
    
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.cancalText.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.确定重用标示:
    static NSString *ID = @"YYMOrderDetailServiceCell";
    // 2.从缓存池中取
    YYMCancalOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    // 3.如果空就手动创建
    if (!cell) {
        cell = [[YYMCancalOrderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [cell setUpWithModel:self.cancalText[indexPath.row] :self.cancalFlag[indexPath.row]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 50;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    for (int i = 0; i < self.cancalText.count; i ++) {
        [self.cancalFlag replaceObjectAtIndex:i withObject:@"0"];
    }
    [self.cancalFlag replaceObjectAtIndex:indexPath.row withObject:@"1"];
    [self.tableView reloadData];
}

- (UIView *)maskView{
    if (!_maskView) {
        
        _maskView = [UIView wz_viewWithBackgroundColor:[UIColor getColorWithHexString:@"#000000" alpha:0.4] superView:self.view];
        [_maskView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
    }return _maskView;
}

- (UIView *)contentView{
    if (!_contentView) {
        
        _contentView = [UIView wz_viewWithBackgroundColor:WhiteColor superView:self.view];
        _contentView.frame = CGRectMake(0, kScreenHeight - (56*self.cancalText.count + 33 + 88) , kScreenWidth, 56*self.cancalText.count + 33 + 88);
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_contentView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(15,15)];
        //创建 layer
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = _contentView.bounds;
        //赋值
        maskLayer.path = maskPath.CGPath;
        _contentView.layer.mask = maskLayer;
    }
    return _contentView;
}

- (UITableView *)tableView{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 48, kScreenWidth, self.contentView.frame.size.height - 37 - 88)];
        [self.contentView addSubview:_tableView];
        _tableView.separatorColor = TableColor;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.scrollEnabled = YES;
//        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//            
//            make.left.right.mas_equalTo(0);
//            make.top.mas_equalTo(37);
//            make.bottom.mas_equalTo(-88);
//        }];
    }
    return _tableView;
}

- (UIButton *)finishBtn{
    if (!_finishBtn) {
        
        _finishBtn = [UIButton buttonWithNormalTitle:@"确定" selectTitle:@"确定" normalImg:[UIImage new] selectImg:[UIImage new] normalTitleColor:WhiteColor selectTitleColor:WhiteColor font:[UIFont boldSystemFontOfSize:18] backGroundColor:ThemeColor superView:self.contentView];
        [_finishBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(-24);
            make.left.mas_equalTo(15);
            make.width.mas_equalTo(kScreenWidth - 30);
            make.height.mas_equalTo(40);
        }];
    }
    return _finishBtn;
}
@end
