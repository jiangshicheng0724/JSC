//
//  MVVMTableViewCell.m
//  JSCTool
//
//  Created by zuosen on 2019/4/24.
//  Copyright © 2019 jsc. All rights reserved.
//

#import "MVVMTableViewCell.h"
#import "MVVMViewModel.h"

@interface MVVMTableViewCell ()

@property (nonatomic , strong) UILabel  *nameLbl;
@property (nonatomic , strong) UILabel  *textLbl;

@end

@implementation MVVMTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setUpWithViewModel:(MVVMViewModel *)model{
    self.nameLbl.text = model.name;
    self.textLbl.text = model.text;
}

- (UILabel *)nameLbl{
    if (!_nameLbl) {
        _nameLbl = [UILabel labelWithText:@"" font:[UIFont systemFontOfSize:16] textColor:ThirdColor backGroundColor:ClearColor superView:self];
        _nameLbl.numberOfLines = 0;
        [_nameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo((5));
            make.right.mas_equalTo(-(15));
            make.left.mas_equalTo((15));
        }];
    }
    return _nameLbl;
}

- (UILabel *)textLbl{
    if (!_textLbl) {
        _textLbl = [UILabel labelWithText:@"" font:[UIFont systemFontOfSize:16] textColor:ThirdColor backGroundColor:ClearColor superView:self];
        _textLbl.numberOfLines = 0;
        [_textLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.nameLbl.mas_bottom).mas_equalTo(5);
            make.right.mas_equalTo(-(15));
            make.left.mas_equalTo((15));
        }];
    }
    return _textLbl;
}



@end
