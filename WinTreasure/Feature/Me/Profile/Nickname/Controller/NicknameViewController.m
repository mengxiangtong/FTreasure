//
//  NicknameViewController.m
//  WinTreasure
//
//  Created by Apple on 16/6/22.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import "NicknameViewController.h"

@interface NicknameViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameField;

@end

@implementation NicknameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"修改昵称";
    self.view.backgroundColor = UIColorHex(0xe5e5e5);
    [self setRightItemTitle:@"确定" action:@selector(confirm)];
}

- (void)confirm {
    if (![WTSystemInfo validateNickname:_nameField.text]) {
        [SVProgressHUD showInfoWithStatus:@"请输入正确的昵称"];
        return;
    }
    if (_nicknameBlock) {
        _nicknameBlock(_nameField.text);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
