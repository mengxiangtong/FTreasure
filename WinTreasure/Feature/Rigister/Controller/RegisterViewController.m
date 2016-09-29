//
//  RegisterViewController.m
//  WinTreasure
//
//  Created by Apple on 16/6/24.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import "RegisterViewController.h"
#import "VerifyCodeViewController.h"
#import "ClauseViewController.h"


@interface RegisterViewController ()

/**手机号码
 */
@property (strong, nonatomic) UITextField *numberField;

@property (strong, nonatomic) UIView *contenView;

/**获取验证码按钮
 */
@property (strong, nonatomic) UIButton *verifyButton;

/**条款按钮
 */
@property (strong, nonatomic) UIButton *clauseButton;

@property (strong, nonatomic) YYLabel *clauseLabel;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"快速注册";
    [self commonInit];
    [self commonConfig];
}

- (void)commonInit {
    _contenView = [UIView new];
    [self.view addSubview:_contenView];
    @weakify(self);
    [_contenView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.view).with.offset(90);
        make.left.equalTo(self.view).with.offset(30);
        make.right.equalTo(self.view).with.offset(-30);
        make.height.mas_equalTo(@49);
    }];
    _contenView.layer.borderWidth = CGFloatFromPixel(1);
    _contenView.layer.borderColor = UIColorHex(0xeeeeee).CGColor;
    
    _numberField = [[UITextField alloc]init];
    [_contenView addSubview:_numberField];
    [_numberField mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.mas_equalTo(@8);
        make.left.mas_equalTo(self.contenView).with.offset(8);
        make.right.mas_equalTo(self.contenView).with.offset(-8);
        make.bottom.mas_equalTo(@(-8));
    }];
    _numberField.keyboardType = UIKeyboardTypePhonePad;
    _numberField.placeholder = @"请输入手机号码";

    _verifyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:_verifyButton];
    [_verifyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.contenView.mas_bottom).with.offset(21);
        make.left.equalTo(self.view).with.offset(30);
        make.right.equalTo(self.view).with.offset(-30);
        make.height.mas_equalTo(@44);
    }];
    _verifyButton.backgroundColor = UIColorHex(0x58A4EE);
    _verifyButton.titleLabel.font = SYSTEM_FONT(18);
    _verifyButton.layer.cornerRadius = 4.0;
    [_verifyButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_verifyButton addTarget:self action:@selector(getVerifyCode) forControlEvents:UIControlEventTouchUpInside];

    _clauseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _clauseButton.selected = YES;
    [self.view addSubview:_clauseButton];
    [_clauseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.mas_equalTo(self.verifyButton.mas_bottom).with.offset(17);
        make.left.mas_equalTo(@30);
        make.size.mas_equalTo(CGSizeMake(15, 15));
    }];
    [_clauseButton setImage:IMAGE_NAMED(@"未选中") forState:UIControlStateNormal];
    [_clauseButton setImage:IMAGE_NAMED(@"选中") forState:UIControlStateSelected];
    [_clauseButton addTarget:self action:@selector(agreeClause:) forControlEvents:UIControlEventTouchUpInside];

    _clauseLabel = [YYLabel new];
    [self.view addSubview:_clauseLabel];
    [_clauseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.centerY.equalTo(self.clauseButton);
        make.left.mas_equalTo(self.clauseButton.mas_right).with.offset(4);
        make.right.mas_equalTo(@(-30));
    }];
    NSString *clause = @"我同意“服务条款”和“用户隐私保护个人信息利用政策”";
    NSMutableAttributedString *attrClause = [[NSMutableAttributedString alloc]initWithString:clause];
    [attrClause setColor:UIColorHex(0x58A4EE) range:NSMakeRange(4, 4)];
    [attrClause setColor:UIColorHex(0x58A4EE) range:NSMakeRange(11, 14)];
    _clauseLabel.attributedText = attrClause;
    _clauseLabel.userInteractionEnabled = YES;

    _clauseLabel.textTapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
        @strongify(self);
        if ((range.location>3 && range.location<8) || (range.location>10 && range.location<23)) {
            ClauseViewController *vc = [[ClauseViewController alloc]init];
            [self hideBottomBarPush:vc];
        }
    };
}

- (void)commonConfig {
}

- (void)agreeClause:(UIButton *)sender {
    sender.selected = !sender.selected;
}

- (void)getVerifyCode {
    [_numberField resignFirstResponder];
    if (![WTSystemInfo validateMobile:_numberField.text]) {
        [SVProgressHUD showInfoWithStatus:@"请输入正确的手机号码"];
        return;
    }
    if (!_clauseButton.selected) {
        [SVProgressHUD showInfoWithStatus:@"请先阅读条款"];
        return;
    }
    [self setBackItem];
    VerifyCodeViewController *vc = [[VerifyCodeViewController alloc]init];
    vc.number = _numberField.text;
    [self hideBottomBarPush:vc];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//手机号码验证


@end
