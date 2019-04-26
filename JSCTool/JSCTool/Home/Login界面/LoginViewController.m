//
//  LoginViewController.m
//  JSCTool
//
//  Created by zuosen on 2019/4/26.
//  Copyright © 2019 jsc. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()<UITextFieldDelegate>{
    
    BOOL isCode;//是否是验证码登录
    NSString *verifyTicket;
}


/**  login */
@property (nonatomic , strong) UIImageView  *logoImgView;
/**  名字 */
@property (nonatomic , strong) UILabel  *titleLbl;
/**  登录选项 */
@property (nonatomic , strong) UIView  *loginChooiceBgView;
/**  验证码登录逻辑背景 */
@property (nonatomic , strong) UIView  *codeLoginBgView;
/**  密码登录逻辑背景 */
@property (nonatomic , strong) UIView  *pwdLoginBgView;

/**  手机号码输入框 */
@property (nonatomic , strong) UITextField  *phoneCodeTextF;
/**  手机号码输入框 */
@property (nonatomic , strong) UITextField  *phonePWDTextF;
/**  验证码输入框 */
@property (nonatomic , strong) UITextField  *codeTextF;
/**  密码输入框 */
@property (nonatomic , strong) UITextField  *passwordTextF;
/**  获取验证码 */
@property (nonatomic , strong) UIButton  *getCodeBtn;

/**  登录 */
@property (nonatomic , strong) UIButton  *loginBtn;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = WhiteColor;
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    //GCD延迟
    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

    //    });
    
    [self setup];
    
    //    self.phoneCodeTextF.text = @"13777370466";
    //    self.passwordTextF.text = @"123456";
    
}


//iOS TextField输入框点击键盘时随着键盘上移
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
//    CGRect frame = _loginBtn.frame;
//
//    int offSet = frame.origin.y + KLineY(70) - (kScreenHeight - 216.0) + KTabBarHeight; //iphone键盘高度为216.iped键盘高度为352
//
//    //    [UIView beginAnimations:@"ResizeForKeyboard"context:nil];
//
//    //将试图的Y坐标向上移动offset个单位,以使线面腾出开的地方用于软键盘的显示
//
//    if (offSet >0) {
//
//        self.view.frame =CGRectMake(0.0f, -offSet,kScreenWidth,kScreenHeight);
//
//        //        [UIView commitAnimations];
//
//    }
}

//输入框编辑完成以后，将视图恢复到原始状态
-(void)textFieldDidEndEditing:(UITextField *)textField
{
//    self.view.frame =CGRectMake(0,0, kScreenWidth,kScreenHeight);
    
}

- (void)setup{
    
    isCode = YES;
    verifyTicket = @"";
    //    self.phoneCodeTextF.text = self.phonePWDTextF.text = [PCISave account].telephone;
    
    self.logoImgView.image = [UIImage imageNamed:@"WechatIMG159"];
    self.titleLbl.text = @"login演示";
    [self addLoginChooiceSubviews];
    [self addCodeLoginSubViews];
    [self addPwdLoginSubviews];
    
    self.codeLoginBgView.hidden = NO;
    self.pwdLoginBgView.hidden = YES;
    
    @weakify(self);
    [self.loginBtn bk_whenTapped:^{
        @strongify(self);
        [self.view  endEditing:YES];
        [self loginClick];
    }];
    
    [self.getCodeBtn bk_whenTapped:^{
        @strongify(self);
        [self.view  endEditing:YES];
        [self sendCode];
    }];
}

//发送验证码
- (void)sendCode{
    
    DLog(@"发送验证码");
    
    self.getCodeBtn.userInteractionEnabled = NO;
    
    BOOL isPhoneInput = isCode ? self.phoneCodeTextF.text.length == 11 : self.phonePWDTextF.text.length == 11;
    if (!isPhoneInput) {
        
        [self.view showToastWithText:@"请输入正确的手机号码" afterDelay:0];
        self.getCodeBtn.userInteractionEnabled = YES;
        
        return;
    }
    

}

//登录
- (void)loginClick{
    DLog(@"登陆");
    
    BOOL isPhoneInput = isCode ? self.phoneCodeTextF.text.length == 11 : self.phonePWDTextF.text.length == 11;
    BOOL isCodeInput = self.codeTextF.text.length >= 6;
    BOOL isPWDInput = self.passwordTextF.text.length >=3;
    
    NSDictionary *parameters = @{};
    
    if (isCode) {
        if (!isPhoneInput) {
            
            [self.view showToastWithText:@"请输入正确的手机号码" afterDelay:0];
            return;
        }
        
        if (!isCodeInput) {
            
            [self.view showToastWithText:@"请输入验证码" afterDelay:0];
            return;
        }
        
        if ([RYToolClass isBlankString:verifyTicket]) {
            
            [self.view showToastWithText:@"请发送短信验证码" afterDelay:0];
            return;
        }
        

        
        parameters = @{
                       @"type"        : @"sms",
                       @"telephone"   : self.phoneCodeTextF.text,
                       @"sms_ticket"  : verifyTicket,
                       @"sms_code"    : self.codeTextF.text,
                       };
    }else{
        
        if (!isPhoneInput) {
            
            [self.view showToastWithText:@"请输入正确的手机号码" afterDelay:0];
            return;
        }

        if (!isPWDInput) {
            
            [self.view showToastWithText:@"请输入密码" afterDelay:0];
            return;
        }
        parameters = @{
                       @"type"        : @"account",
                       @"account"     : self.phonePWDTextF.text,
                       @"password"    : self.passwordTextF.text,
                       };
    }

}

- (void)addCodeLoginSubViews{
    
    UIImageView *phoneIconImgView = [UIImageView imageViewWithSuperView:self.codeLoginBgView];
    phoneIconImgView.image = [UIImage imageNamed:@"dl_content_icon_phone"];
    [phoneIconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo((30));
        make.top.mas_equalTo((30));
    }];
    
    UIView *line = [UIView wz_viewWithBackgroundColor:[RYToolClass getColorWithHexString:@"#DDDDDD"] superView:self.codeLoginBgView];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo((62));
        make.right.mas_equalTo((-30));
        make.top.mas_equalTo((58));
        make.height.mas_equalTo(1);
    }];
    
    _phoneCodeTextF = [[UITextField alloc] init];
    _phoneCodeTextF.font = [UIFont systemFontOfSize:16];
    _phoneCodeTextF.delegate = self;
    _phoneCodeTextF.placeholder = @"请输入手机号";
    [self.codeLoginBgView addSubview:_phoneCodeTextF];
    _phoneCodeTextF.textColor = SecondColor;
    _phoneCodeTextF.keyboardType = UIKeyboardTypePhonePad;
    [_phoneCodeTextF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(line.mas_left);
        make.right.mas_equalTo(line.mas_right);
        make.bottom.mas_equalTo(line.mas_top);
        make.height.mas_equalTo((34));
    }];
    
    UIImageView *passwordIconImgView = [UIImageView imageViewWithSuperView:self.codeLoginBgView];
    passwordIconImgView.image = [UIImage imageNamed:@"dl_content_icon_lock"];
    [passwordIconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo((30));
        make.top.mas_equalTo(phoneIconImgView.mas_bottom).mas_equalTo((50));
    }];
    
    UIView *line1 = [UIView wz_viewWithBackgroundColor:[RYToolClass getColorWithHexString:@"#DDDDDD"] superView:self.codeLoginBgView];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo((62));
        make.right.mas_equalTo((-30));
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
    _getCodeBtn = [UIButton buttonWithNormalTitle:@"获取验证码" selectTitle:@"获取验证码" normalImg:[UIImage new] selectImg:[UIImage new] normalTitleColor:YellowColor selectTitleColor:YellowColor font:[UIFont systemFontOfSize:16] backGroundColor:ClearColor superView:self.codeLoginBgView];
    [_getCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(line1.mas_right);
        make.bottom.mas_equalTo(line1.mas_bottom);
        make.size.mas_equalTo(CGSizeMake((90), (34)));
    }];
    _getCodeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    
    _codeTextF = [[UITextField alloc] init];
    _codeTextF.font = [UIFont systemFontOfSize:16];
    _codeTextF.delegate = self;
    _codeTextF.keyboardType = UIKeyboardTypePhonePad;
    _codeTextF.placeholder = @"请输入验证码";
    [self.codeLoginBgView addSubview:_codeTextF];
    _codeTextF.textColor = SecondColor;
    [_codeTextF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(line1.mas_left);
        make.right.mas_equalTo(self.getCodeBtn.mas_left).mas_equalTo((-10));
        make.bottom.mas_equalTo(line1.mas_top);
        make.height.mas_equalTo((34));
    }];
}

- (void)addPwdLoginSubviews{
    
    UIImageView *phoneIconImgView = [UIImageView imageViewWithSuperView:self.pwdLoginBgView];
    phoneIconImgView.image = [UIImage imageNamed:@"dl_content_icon_phone"];
    [phoneIconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo((30));
        make.top.mas_equalTo((30));
    }];
    
    UIView *line = [UIView wz_viewWithBackgroundColor:[RYToolClass getColorWithHexString:@"#DDDDDD"] superView:self.pwdLoginBgView];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo((62));
        make.right.mas_equalTo((-30));
        make.top.mas_equalTo((58));
        make.height.mas_equalTo(1);
    }];
    
    _phonePWDTextF = [[UITextField alloc] init];
    _phonePWDTextF.font = [UIFont systemFontOfSize:16];
    _phonePWDTextF.delegate = self;
    _phonePWDTextF.placeholder = @"请输入手机号";
    [self.pwdLoginBgView addSubview:_phonePWDTextF];
    _phonePWDTextF.textColor = SecondColor;
    _phonePWDTextF.keyboardType = UIKeyboardTypePhonePad;
    [_phonePWDTextF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(line.mas_left);
        make.right.mas_equalTo(line.mas_right);
        make.bottom.mas_equalTo(line.mas_top);
        make.height.mas_equalTo((34));
    }];
    
    UIImageView *passwordIconImgView = [UIImageView imageViewWithSuperView:self.pwdLoginBgView];
    passwordIconImgView.image = [UIImage imageNamed:@"dl_content_icon_lock"];
    [passwordIconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo((30));
        make.top.mas_equalTo(phoneIconImgView.mas_bottom).mas_equalTo((50));
    }];
    
    UIView *line1 = [UIView wz_viewWithBackgroundColor:[RYToolClass getColorWithHexString:@"#DDDDDD"] superView:self.pwdLoginBgView];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo((62));
        make.right.mas_equalTo((-30));
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
    
    _passwordTextF = [[UITextField alloc] init];
    _passwordTextF.font = [UIFont systemFontOfSize:16];
    _passwordTextF.delegate = self;
    _passwordTextF.placeholder = @"请输入密码";
    _passwordTextF.secureTextEntry = YES;
    [self.pwdLoginBgView addSubview:_passwordTextF];
    _passwordTextF.textColor = SecondColor;
    [_passwordTextF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(line1.mas_left);
        make.right.mas_equalTo(line1.mas_right);
        make.bottom.mas_equalTo(line1.mas_top);
        make.height.mas_equalTo((34));
    }];
}

- (void)addLoginChooiceSubviews{
    
    UIView *line = [UIView wz_viewWithBackgroundColor:[RYToolClass getColorWithHexString:@"#DDDDDD"] superView:self.loginChooiceBgView];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo((30));
        make.right.mas_equalTo((-30));
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
    UIView *line1 = [UIView wz_viewWithBackgroundColor:[RYToolClass getColorWithHexString:@"#DDDDDD"] superView:self.loginChooiceBgView];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(1, (16)));
        make.centerX.mas_equalTo(0);
    }];
    
    UIButton *codeLoginBtn = [UIButton buttonWithNormalTitle:@"手机快捷登录" selectTitle:@"手机快捷登录" normalImg:[UIImage new] selectImg:[UIImage new] normalTitleColor:ThirdColor selectTitleColor:YellowColor font:[UIFont systemFontOfSize:16] backGroundColor:ClearColor superView:self.loginChooiceBgView];
    [codeLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(line1.mas_left).mas_equalTo(0);
        make.left.mas_equalTo(line.mas_left);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(-2);
    }];
    
    UIButton *pwdLoginBtn = [UIButton buttonWithNormalTitle:@"账号密码登陆" selectTitle:@"账号密码登陆" normalImg:[UIImage new] selectImg:[UIImage new] normalTitleColor:ThirdColor selectTitleColor:YellowColor font:[UIFont systemFontOfSize:16] backGroundColor:ClearColor superView:self.loginChooiceBgView];
    [pwdLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(line1.mas_right).mas_equalTo(0);
        make.right.mas_equalTo(line.mas_right);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(-2);
    }];
    
    codeLoginBtn.selected = YES;
    //    codeLoginBtn.userInteractionEnabled = NO;
    pwdLoginBtn.userInteractionEnabled = YES;
    
    UIView *indicatorView = [UIView wz_viewWithBackgroundColor:YellowColor superView:self.loginChooiceBgView];
    [indicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake((50), (2)));
        make.bottom.mas_equalTo(0);
        make.centerX.mas_equalTo(0).multipliedBy(0.5);
    }];
    
    [codeLoginBtn bk_whenTapped:^{
        codeLoginBtn.selected = YES;
        pwdLoginBtn.selected = NO;
        //        codeLoginBtn.userInteractionEnabled = NO;
        pwdLoginBtn.userInteractionEnabled = YES;
        indicatorView.wz_centerX = codeLoginBtn.wz_centerX;
        self.codeLoginBgView.hidden = NO;
        self.pwdLoginBgView.hidden = YES;
        self->isCode = YES;
    }];
    [pwdLoginBtn bk_whenTapped:^{
        codeLoginBtn.selected = NO;
        pwdLoginBtn.selected = YES;
        codeLoginBtn.userInteractionEnabled = YES;
        //        pwdLoginBtn.userInteractionEnabled = NO;
        indicatorView.wz_centerX = pwdLoginBtn.wz_centerX;
        self.codeLoginBgView.hidden = YES;
        self.pwdLoginBgView.hidden = NO;
        self->isCode = NO;
    }];
}

- (UIImageView *)logoImgView{
    if (!_logoImgView) {
        
        _logoImgView = [UIImageView imageViewWithSuperView:self.view];
        _logoImgView.layer.masksToBounds = YES;
        _logoImgView.layer.cornerRadius = (43);
        [_logoImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.top.mas_equalTo((108));
            make.size.mas_equalTo(CGSizeMake((86), (86)));
        }];
    }
    return _logoImgView;
}

- (UILabel *)titleLbl{
    if (!_titleLbl) {
        
        _titleLbl = [UILabel labelWithText:@"" font:[UIFont systemFontOfSize:16] textColor:FirstColor backGroundColor:ClearColor superView:self.view];
        [_titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.top.mas_equalTo(self.logoImgView.mas_bottom).mas_equalTo((20));
        }];
    }
    return _titleLbl;
}

- (UIView *)loginChooiceBgView{
    if (!_loginChooiceBgView) {
        
        _loginChooiceBgView = [UIView wz_viewWithBackgroundColor:WhiteColor superView:self.view];
        [_loginChooiceBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(self.titleLbl.mas_bottom).mas_equalTo((50));
            make.height.mas_equalTo((46));
        }];
    }
    return _loginChooiceBgView;
}

- (UIView *)codeLoginBgView{
    
    if (!_codeLoginBgView) {
        
        _codeLoginBgView = [UIView wz_viewWithBackgroundColor:WhiteColor superView:self.view];
        [_codeLoginBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(self.loginChooiceBgView.mas_bottom);
            make.height.mas_equalTo((135));
        }];
    }
    return _codeLoginBgView;
}

- (UIView *)pwdLoginBgView{
    if (!_pwdLoginBgView) {
        
        _pwdLoginBgView = [UIView wz_viewWithBackgroundColor:WhiteColor superView:self.view];
        [_pwdLoginBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(self.loginChooiceBgView.mas_bottom);
            make.height.mas_equalTo((135));
        }];
    }
    return _pwdLoginBgView;
}

- (UIButton *)loginBtn{
    
    if (!_loginBtn) {
        
        _loginBtn = [UIButton buttonWithNormalTitle:@"登录" selectTitle:@"登录" normalImg:[UIImage new] selectImg:[UIImage new] normalTitleColor:WhiteColor selectTitleColor:WhiteColor font:[UIFont boldSystemFontOfSize:18] backGroundColor:YellowColor superView:self.view];
        _loginBtn.layer.masksToBounds = YES;
        _loginBtn.layer.cornerRadius = 5;
        [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo((15));
            make.right.mas_equalTo((-15));
            make.height.mas_equalTo((45));
            make.top.mas_equalTo(self.pwdLoginBgView.mas_bottom).mas_equalTo((45));
        }];
    }
    return _loginBtn;
}


// 开启倒计时效果
-(void)openCountdown{
    
    __block NSInteger time = 59; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    @weakify(self);
    
    dispatch_source_set_event_handler(_timer, ^{
        
        @strongify(self);
        if(time <= 0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮的样式
                self.getCodeBtn.userInteractionEnabled = YES;
                [self.getCodeBtn setTitle:@"重新发送" forState:UIControlStateNormal];
                [self.getCodeBtn setTitleColor:YellowColor forState:UIControlStateNormal];
            });
            
        }else{
            
            int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮显示读秒效果
                [self.getCodeBtn setTitle:[NSString stringWithFormat:@"重新发送(%.2d)", seconds] forState:UIControlStateNormal];
                [self.getCodeBtn setTitleColor:[RYToolClass getColorWithHexString:@"#999999"] forState:UIControlStateNormal];
                self.getCodeBtn.userInteractionEnabled = NO;
                
            });
            time--;
        }
    });
    dispatch_resume(_timer);
}


@end

