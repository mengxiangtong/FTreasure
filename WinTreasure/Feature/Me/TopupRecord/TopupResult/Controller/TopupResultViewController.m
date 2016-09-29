//
//  TopupResultViewController.m
//  WinTreasure
//
//  Created by Apple on 16/6/23.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import "TopupResultViewController.h"

@interface TopupResultViewController ()

@property (weak, nonatomic) IBOutlet UIButton *congratulateBtn;

@property (weak, nonatomic) IBOutlet UILabel *coinLabel;

@end

@implementation TopupResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setSubviews];
    self.navigationItem.hidesBackButton = YES;
    _coinLabel.text = [NSString stringWithFormat:@"获得 %@ 夺宝币",_coinAmount];

}

//- (void)viewDidAppear:(BOOL)animated {
//    [super viewDidAppear:animated];
//    // 禁用 iOS7 返回手势
//    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
//        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
//    }
//}
//
//- (void)viewWillDisappear:(BOOL)animated {
//    [super viewWillDisappear:animated];
//    // 开启
//    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
//        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
//    }
//}

- (void)setSubviews {
    _congratulateBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
}

- (IBAction)back {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"kTopupNotification" object:_coinAmount];;
    [self.navigationController popToRootViewControllerAnimated:YES];
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
