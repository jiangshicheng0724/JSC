//
//  YYMAllProductView.m
//  YingYunStore
//
//  Created by zuosen on 2019/3/14.
//  Copyright  All rights reserved.
//

#import "YYMAddNewBillView.h"
#import "YYMNewAddBillModel.h"

@interface YYMAddNewBillView()

/**  标题 */
@property (nonatomic , strong) UILabel  *titleLabel;

@property (nonatomic , strong) UITextField  *textField;


@end

@implementation YYMAddNewBillView

- (instancetype)init
{
    self = [super init];
    if (self) {

    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        
    }
    return self;
}

-(void)setUpWith:(YYMNewAddBillModel *)model{
    // 发票抬头：杭州卓森科技有限公司
    
    self.titleLabel.text = model.textLeft;
    self.textField.placeholder = model.textRight;
    if([model.textLeft isEqualToString:@"电     话"] || [model.textLeft isEqualToString:@"银行账号"]){
        self.textField.keyboardType = UIKeyboardTypeNumberPad;
    }
    if([model.textLeft isEqualToString:@"纳税人号"]){
        self.textField.keyboardType = UIKeyboardTypeASCIICapable;
    }
    [self.textField setBk_didEndEditingBlock:^(UITextField *textF) {
        model.textRightFiled = textF.text;
    }];
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        
        _titleLabel = [UILabel labelWithText:@"" font:WZFont(14) textColor:SecondColor backGroundColor:ClearColor superView:self];
        _titleLabel.numberOfLines = 2;
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(12);
        }];
    }
    
    return _titleLabel;
}

- (UITextField *)textField
{
    if (!_textField) {
        
        _textField = [[UITextField alloc] init];
        _textField.font = WZFont(14);
        _textField.textColor = SecondColor;
        _textField.textAlignment = NSTextAlignmentRight;
        [self addSubview:_textField];
        [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.top.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(200, 40));
        }];
    }
    
    return _textField;
}

@end
