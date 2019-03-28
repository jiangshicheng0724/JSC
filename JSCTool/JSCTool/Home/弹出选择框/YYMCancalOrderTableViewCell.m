//
//  YYMOrderListTableViewCell.m
//  YingYunStore
//
//  Created by zuosen on 2019/3/15.
//  Copyright © 2019 班文政. All rights reserved.
//

#import "YYMCancalOrderTableViewCell.h"

@interface YYMCancalOrderTableViewCell()
/**  icon */
@property (nonatomic, strong) UIImageView *imgView;
/**  标题 */
@property (nonatomic, strong) UILabel *titleLabel;
/**  详情 */
@property (nonatomic, strong) UILabel *secondTitleLabel;
/**  价格 */
@property (nonatomic, strong) UILabel *priceLabel;
/**  数量 */
@property (nonatomic, strong) UILabel *numLabel;
/**  状态 */
@property (nonatomic, strong) UILabel *stuatLabel;

@end
@implementation YYMCancalOrderTableViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.frame = frame;
        
    }
    return self;
}

-(void)setUpWithModel:(NSString *)cancalText :(NSString *)flag{
    
    if ([flag isEqualToString:@"0"]) {
        self.imgView.image = [UIImage imageNamed:@"qxdd_icon_yuan_mr"];
    }else{
        self.imgView.image = [UIImage imageNamed:@"qxdd_icon_yuan_xz"];
    }
    
    self.titleLabel.text = cancalText;
    
}


- (UIImageView *)imgView{
    if (!_imgView) {
        
        _imgView = [UIImageView imageViewWithSuperView:self];
        [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.centerY.mas_equalTo(self);
            make.size.mas_equalTo(CGSizeMake(21, 21));
        }];
    }
    return _imgView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        
        _titleLabel = [UILabel labelWithText:@"" font:WZFont(16) textColor:FirstColor backGroundColor:ClearColor superView:self];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.centerY.mas_equalTo(self);
        }];
    }
    
    return _titleLabel;
}

@end
