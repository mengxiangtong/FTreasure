//
//  DreamListViewController.m
//  WinTreasure
//
//  Created by Apple on 16/6/15.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import "DreamListViewController.h"
#import "DreamGiftViewController.h"
#import "DreamListView.h"

@interface DreamListViewController ()

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) DreamListView *dreamListView;

@end

@implementation DreamListViewController

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:({
            CGRect rect = {0,kNavigationBarHeight,kScreenWidth,kScreenHeight-kNavigationBarHeight};
            rect;
        })];
        _scrollView.backgroundColor = UIColorHex(0xECEBE8);
    }
    return _scrollView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的心愿单";
    [self.view addSubview:self.scrollView];
    [_scrollView addSubview:self.dreamListView];
    
    @weakify(self);
    _dreamListView.chooseDreamGift = ^{
        @strongify(self);
        DreamGiftViewController *vc = [[DreamGiftViewController alloc]init];
        [self hideBottomBarPush:vc];
    };
}

- (DreamListView *)dreamListView {
    if (!_dreamListView) {
        _dreamListView = [[DreamListView alloc]initWithFrame:({
            CGRect rect = {0,0,kScreenWidth,kScreenHeight};
            rect;
        })];
    }
    return _dreamListView;
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
