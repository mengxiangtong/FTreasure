//
//  PasswordViewController.m
//  WinTreasure
//
//  Created by Apple on 16/6/24.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import "PasswordViewController.h"
#import "RegSuccessViewController.h"

@interface PasswordViewController ()

@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@end

@implementation PasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"快速注册";
}

- (IBAction)registerDone {
    if (![WTSystemInfo validatePassword:_passwordField.text]) {
        [SVProgressHUD showInfoWithStatus:@"密码格式不正确"];
        return;
    }
    RegSuccessViewController *vc = [[RegSuccessViewController alloc]init];
    vc.number = _number;
    [self hideBottomBarPush:vc];
}

- (IBAction)showPassword:(UIButton *)sender {
    sender.selected = !sender.selected;
    _passwordField.secureTextEntry = !sender.selected;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
