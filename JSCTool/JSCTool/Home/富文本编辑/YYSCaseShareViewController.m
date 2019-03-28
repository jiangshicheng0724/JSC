//
//  YYSCaseShareViewController.m
//  ZSPeopleConnectedInternet
//
//  Created by zuosen on 2018/12/7.
//  Copyright © 2018 班文政. All rights reserved.
//

#import "YYSCaseShareViewController.h"
#import "LMNTextView.h"
#import "LMNToolBar.h"
#import "UIFont+LMNote.h"
#import "LMNStore.h"
#import "LMNDraft.h"
#import "LMNImageView.h"
#import "LMNImageInputViewController.h"
#import "LMNWebViewController.h"
#import <UITextView+Placeholder.h>
#import <IQKeyboardManager.h>
//#import "YYSCircleRequest.h"

@interface YYSCaseShareViewController ()<UITextViewDelegate, LMNToolBarDelegate, LMNImageInputViewControllerDelegate>

@property (nonatomic, strong) LMNTextView *textView;
@property (nonatomic, strong) LMNToolBar *toolBar;
@property (nonatomic, strong) UIButton *editButton;

@property (nonatomic, strong) LMNImageInputViewController *imageInputViewController;
@property (nonatomic, weak) UIViewController *currentInputController;
@property (nonatomic, assign) NSInteger cursorIndex;

@property (nonatomic, assign) CGFloat keyboardHeight;

/**  标题 */
@property (nonatomic , strong) UIView  *titleBgView;
/**  标题输入框 */
@property (nonatomic , strong) UITextField  *titleTextF;
/**  设置赏金背景 */
@property (nonatomic , strong) UIView  *bountyBgView;
/**  赏金 */
@property (nonatomic , strong) UITextField  *bountyTextF;
/**  案例html */
@property (nonatomic , strong) NSString  *caseHtml;
@end

@implementation YYSCaseShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"案例分享";
    self.view.backgroundColor  = WhiteColor;
    
    [self setNav];
    [self setup];
    
    [self loadSubviews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //TODO: 页面appear 禁用
    [[IQKeyboardManager sharedManager] setEnable:NO];
    [self addObservers];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    //TODO: 页面Disappear 启用
    [[IQKeyboardManager sharedManager] setEnable:YES];
    [self removeObservers];
    [self saveDraft];
}

- (void)setNav{
    
    UILabel *rightItem = [UILabel labelWithText:@"提交" font:WZFont(16) textColor:SecondColor backGroundColor:ClearColor superView:nil];
    rightItem.userInteractionEnabled = YES;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightItem];
    @weakify(self);
    [rightItem bk_whenTapped:^{
        DLog(@"提交");
        @strongify(self);[self.textView exportHTML:^(BOOL succeed, NSString *html) {
            DLog(@"html:\n%@", html);
//            self->_caseHtml = html;

        }];
    }];
}




- (void)setup{
    
    UIView *line = [UIView wz_viewWithBackgroundColor:TableColor superView:self.view];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo((0));
        make.height.mas_equalTo((10));
    }];
    _titleBgView = [UIView wz_viewWithBackgroundColor:[UIColor getColorWithHexString:@"#F3F3F3"] superView:self.view];
    [_titleBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo((15));
        make.right.mas_equalTo((-15));
        make.height.mas_equalTo((35));
        make.top.mas_equalTo(line.mas_bottom).mas_equalTo((15));
    }];
    
    _titleTextF = [[UITextField alloc] init];
    _titleTextF.placeholder = @"标题";
    [_titleBgView addSubview:_titleTextF];
    _titleTextF.font = WZFont(16);
    _titleTextF.textColor = SecondColor;
    [_titleTextF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo((15));
        make.right.mas_equalTo((-15));
        make.top.bottom.mas_equalTo(0);
    }];
    
    
    _bountyBgView = [UIView wz_viewWithBackgroundColor:WhiteColor superView:self.view];
    [_bountyBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo((270 + 120));;
        make.height.mas_equalTo((100));
    }];
    UILabel *titleLbl = [UILabel labelWithText:@"设置赏金" font:WZFont(16) textColor:FirstColor backGroundColor:ClearColor superView:_bountyBgView];
    [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo((15));
        make.top.mas_equalTo(0);
    }];
    
    UIView *bountyBg = [UIView wz_viewWithBackgroundColor:[UIColor getColorWithHexString:@"#EEEEEE"] superView:self.bountyBgView];
    [bountyBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake((310), (35)));
        make.left.mas_equalTo((15));
        make.top.mas_equalTo(37);
    }];
    UILabel *bountyLbl = [UILabel labelWithText:@"元" font:WZFont(16) textColor:ThirdColor backGroundColor:ClearColor superView:self.bountyBgView];
    [bountyLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(bountyBg.mas_right).mas_equalTo((11));
        make.centerY.mas_equalTo(bountyBg);
    }];
    
    _bountyTextF = [[UITextField alloc] init];
//    _bountyTextF.placeholder = @"100";
    _bountyTextF.text = @"0";
    _bountyTextF.keyboardType = UIKeyboardTypeNumberPad;
    [bountyBg addSubview:_bountyTextF];
    _bountyTextF.font = WZFont(16);
    _bountyTextF.textColor = FirstColor;
    [_bountyTextF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo((5));
        make.right.mas_equalTo(bountyLbl.mas_left).mas_equalTo((-5));
        make.top.bottom.mas_equalTo(0);
    }];
    
    @weakify(self);
    [_bountyTextF bk_whenTapped:^{
        DLog(@"");
        @strongify(self);
        [[IQKeyboardManager sharedManager] setEnable:YES];
        [self.bountyTextF becomeFirstResponder];
    }];
    
    [_bountyTextF setBk_didEndEditingBlock:^(UITextField *textF) {
        
        @strongify(self);
        [self.bountyTextF canResignFirstResponder];
        [[IQKeyboardManager sharedManager] setEnable:NO];
    }];
}

//- (UIView *)bountyBgView{
//    if (!_bountyBgView) {
//
//    }
//    return _bountyBgView;
//}

- (instancetype)initWithDraft:(LMNDraft *)draft
{
    self = [super init];
    if (self) {
        _draft = draft;
    }
    return self;
}

- (void)loadSubviews
{
    self.textView = ({
        LMNTextView *textView = [[LMNTextView alloc] initWithTextStorage:self.draft.textStorage];
        textView.backgroundColor = [UIColor getColorWithHexString:@"#F3F3F3"];
        textView.spellCheckingType = UITextSpellCheckingTypeNo;
        textView.delegate = self;
        textView;
    });
    [self.view addSubview:self.textView];
    
    self.editButton = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"lmn_btn_edit"] forState:UIControlStateNormal];
        button.backgroundColor = [UIColor colorWithWhite:.5f alpha:.75f];
        button.clipsToBounds = YES;
        [button addTarget:self action:@selector(showToolBar:) forControlEvents:UIControlEventTouchUpInside];
        button;
    });
//    [self.view addSubview:self.editButton];
    
    self.toolBar = ({
        LMNToolBar *toolBar = [LMNToolBar toolBar];
        toolBar.delegate = self;
        toolBar.hidden = YES;
        toolBar;
    });
    [self.view addSubview:self.toolBar];
}
//
//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor whiteColor];
//
//    [self loadSubviews];
//
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"HTML" style:UIBarButtonItemStylePlain target:self action:@selector(export)];
//}

- (void)layoutTextView
{
    CGFloat toolbarHeight = 44.f;
//    self.textView.frame = self.view.bounds;
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo((15));
        make.right.mas_equalTo((-15));
        make.height.mas_equalTo((180+120));
        make.top.mas_equalTo(self.titleTextF.mas_bottom).mas_equalTo((10));
    }];
    
    self.textView.placeholder = @"填写回答内容";
    self.toolBar.frame = ({
        CGRect rect = self.view.bounds;
        rect.size.height = toolbarHeight;
        rect.origin.y = CGRectGetHeight(self.view.bounds) - CGRectGetHeight(rect) - self.keyboardHeight;
        rect;
    });
    UIEdgeInsets insets = self.textView.contentInset;
//    insets.bottom = self.keyboardHeight + 10.f;
//    if (self.toolBar.hidden == NO) {
//        insets.bottom += toolbarHeight;
//    }
    self.textView.contentInset = insets;

}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self layoutTextView];
    
    self.editButton.frame = ({
        CGRect rect = CGRectZero;
        rect.size = CGSizeMake(50.f, 50.f);
        rect.origin.x = CGRectGetWidth(self.view.bounds) - 50.f - 20.f;
        rect.origin.y = CGRectGetHeight(self.view.bounds) - 150.f - 20.f - self.keyboardHeight;
        rect;
    });
    self.editButton.layer.cornerRadius = 25.f;
    
    self.toolBar.frame = ({
        CGRect rect = self.view.bounds;
        rect.origin.y = CGRectGetHeight(rect) - 44.f - self.keyboardHeight;
        rect.size.height = 44.f;
        rect;
    });
}



- (void)addObservers
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)removeObservers
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)saveDraft
{
    __block NSString *firstLine = nil;
    NSCharacterSet *characterSet = [NSCharacterSet whitespaceCharacterSet];
    [self.textView.text enumerateLinesUsingBlock:^(NSString * _Nonnull line, BOOL * _Nonnull stop) {
        line = [line stringByTrimmingCharactersInSet:characterSet];
        if (line.length > 0) {
            firstLine = line;
            *stop = YES;
        }
    }];
    if (firstLine.length > 0) {
        self.draft.name = firstLine;
        self.draft.textStorage = (LMNTextStorage *)self.textView.textStorage;
        [self.draft save];
    }
    else {
        [self.draft delete];
    }
}

- (void)export
{
    [self.textView exportHTML:^(BOOL succeed, NSString *html) {
        NSLog(@"html:\n%@", html);
//        LMNWebViewController *vc = [[LMNWebViewController alloc] init];
//        vc.html = html;
//        [self.navigationController pushViewController:vc animated:YES];
    }];
}

#pragma mark - input

- (LMNImageInputViewController *)imageInputViewController
{
    if (!_imageInputViewController) {
        _imageInputViewController = [[LMNImageInputViewController alloc] init];
        _imageInputViewController.delegate = self;
    }
    return _imageInputViewController;
}

- (void)changeTextInputForTag:(LMNToolBarItemTag)tag
{
    UIViewController *inputViewController = nil;
    switch (tag) {
        case LMNToolBarItemTagImage:
            inputViewController = self.imageInputViewController;
            self.cursorIndex = NSMaxRange(self.textView.selectedRange);
            break;
        default:
            break;
    }
    if (inputViewController && self.currentInputController != inputViewController) {
        CGRect rect = self.view.bounds;
        rect.size.height = 260.f;
        rect.origin.y = CGRectGetHeight(self.view.bounds) - CGRectGetHeight(rect);
        inputViewController.view.frame = rect;
    }
    self.currentInputController = inputViewController;
    
    [self.textView resignFirstResponder];
}

#pragma mark - private

- (void)showToolBar:(UIButton *)button
{
    self.editButton.hidden = YES;
    self.toolBar.hidden = NO;
    [self.textView becomeFirstResponder];
}

- (void)reloadToolBar
{
    NSMutableDictionary *attributes = [self.textView.typingAttributes mutableCopy];
    LMNLineMode mode = [self.textView lineModeForRange:self.textView.selectedRange];
    NSString *selectedStr = [self.textView.text substringWithRange:self.textView.selectedRange];
    BOOL isMultiLine = [selectedStr containsString:@"\n"];
    [self.toolBar reloadDataWithTypingAttributes:attributes mode:mode isMultiLine:isMultiLine];
}

- (void)showInputView
{
    CGRect rect = self.currentInputController.view.frame;
    [self.view addSubview:self.currentInputController.view];
    self.currentInputController.view.frame = CGRectOffset(rect, 0, CGRectGetHeight(rect));
    [UIView animateWithDuration:0.3 animations:^{
        self.currentInputController.view.frame = rect;
    }];
}

- (void)hideInputView
{
    if (self.currentInputController) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect rect = self.currentInputController.view.frame;
            self.currentInputController.view.frame = CGRectOffset(rect, 0, CGRectGetHeight(rect));
        } completion:^(BOOL finished) {
            [self.currentInputController.view removeFromSuperview];
            self.currentInputController = nil;
        }];
    }
    [self.view setNeedsLayout];
}

#pragma mark - Keyboard

- (void)keyboardWillShow:(NSNotification *)notification
{
    NSDictionary *info = [notification userInfo];
    CGSize keyboardSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    if (self.keyboardHeight == keyboardSize.height) {
        return;
    }
    self.keyboardHeight = keyboardSize.height;
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        [self layoutTextView];
    } completion:nil];
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    if (self.keyboardHeight == 0) {
        return;
    }
    self.keyboardHeight = 0;
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        [self layoutTextView];
    } completion:nil];
}

#pragma mark - <UITextViewDelegate>

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    self.editButton.hidden = YES;
    self.toolBar.hidden = NO;
    [self hideInputView];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    self.toolBar.hidden = YES;
    if (self.currentInputController) {
        [self showInputView];
    }
    else {
        self.editButton.hidden = NO;
    }
    [self.view setNeedsLayout];
}

- (void)textViewDidChangeSelection:(UITextView *)textView
{
    [self reloadToolBar];
}

#pragma mark - <LMNToolBarDelegate>

- (void)lmn_toolBar:(LMNToolBar *)toolBar didChangedMode:(LMNLineMode)mode
{
    [self.textView setLineMode:mode forRange:self.textView.selectedRange];
    [self reloadToolBar];
}

- (void)lmn_toolBar:(LMNToolBar *)toolBar didChangedAttributes:(NSDictionary *)attributes
{
    BOOL bold = [attributes[LMFontBoldAttributeName] boolValue];
    BOOL italic = [attributes[LMFontItalicAttributeName] boolValue];
    BOOL underline = [attributes[LMFontUnderlineAttributeName] boolValue];
    BOOL strikethrough = [attributes[LMFontStrikethroughAttributeName] boolValue];
    
    NSMutableDictionary *typingAttributes = [self.textView.typingAttributes mutableCopy];
    UIFont *font = typingAttributes[NSFontAttributeName];
    typingAttributes[NSFontAttributeName] = [UIFont fontWithFontSize:font.fontSize bold:bold italic:italic];
    if (underline) {
        typingAttributes[NSUnderlineStyleAttributeName] = @(NSUnderlineStyleSingle);
    }
    else {
        [typingAttributes removeObjectForKey:NSUnderlineStyleAttributeName];
    }
    if (strikethrough) {
        typingAttributes[NSStrikethroughStyleAttributeName] = @(1);
    }
    else {
        [typingAttributes removeObjectForKey:NSStrikethroughStyleAttributeName];
    }
    self.textView.typingAttributes = typingAttributes;
    [self.textView setAttributesForSelection:typingAttributes];
}

- (void)lmn_toolBar:(LMNToolBar *)toolBar didChangedTextAlignment:(NSTextAlignment)alignment
{
    [self.textView setTextAlignmentForSelection:alignment];
}

- (void)lmn_toolBar:(LMNToolBar *)toolBar didSelectedItemWithTag:(LMNToolBarItemTag)tag
{
    [self changeTextInputForTag:tag];
}

- (void)lmn_toolBarClose:(LMNToolBar *)toolBar
{
    self.editButton.hidden = NO;
    self.toolBar.hidden = YES;
    [self.textView resignFirstResponder];
}

#pragma mark - <LMNImageInputViewControllerDelegate>

- (void)lmn_imageInput:(LMNImageInputViewController *)viewController didSelectPHAsset:(PHAsset *)asset
{
    [self hideInputView];
    self.editButton.hidden = NO;
    
    CGFloat imageWidth = CGRectGetWidth([UIScreen mainScreen].bounds) - 40.f;
    CGSize targetSize = CGSizeMake(imageWidth, imageWidth);
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.networkAccessAllowed = YES;
    __block LMNImageView *imageView = nil;
    [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:targetSize contentMode:PHImageContentModeAspectFill options:options resultHandler:^(UIImage *result, NSDictionary *info) {
        
        if (!imageView) {
            imageView = [self.textView insertImage:result atIndex:self.cursorIndex];
        }
        else {
            imageView.image = result;
        }
    }];
}

- (void)lmn_imageInputClose:(LMNImageInputViewController *)viewController
{
    [self hideInputView];
    self.editButton.hidden = NO;
}

@end
