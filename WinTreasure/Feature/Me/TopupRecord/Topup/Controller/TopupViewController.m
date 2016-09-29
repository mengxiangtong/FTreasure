//
//  TopupViewController.m
//  WinTreasure
//
//  Created by Apple on 16/6/17.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import "TopupViewController.h"
#import "TopupResultViewController.h"
#import "TopUpCell.h"
#import "TopupHeader.h"

@interface TopupViewController () <UITableViewDataSource, UITableViewDelegate>
{
    NSIndexPath *_selectedIndexPath;
}
@property (strong, nonatomic) NSMutableArray *datasoure;

@property (strong, nonatomic) TopupHeader *header;

@property (weak, nonatomic) IBOutlet BaseTableView *tableView;

@end

@implementation TopupViewController


- (NSMutableArray *)datasoure {
    if (!_datasoure) {
        NSArray *array = @[@"微信支付",@"招行"];
        _datasoure = [NSMutableArray arrayWithArray:array];
    }
    return _datasoure;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"充值";
    [self setupHeader];
    [self setupFooter];
}

- (void)setupHeader {
    _header = [[TopupHeader alloc]initWithFrame:({
        CGRect rect = {0,0,kScreenWidth,1};
        rect;
    })];
    self.tableView.tableHeaderView = _header;
}

- (void)setupFooter {
    UIView *contentView = [[UIView alloc]initWithFrame:({
        CGRect rect = {0,0,kScreenWidth,65};
        rect;
    })];
    
    UIButton *payButton = [UIButton buttonWithType:UIButtonTypeCustom];
    payButton.frame = ({
        CGRect rect = {10,10,kScreenWidth-10*2,contentView.height-15*2};
        rect;
    });
    payButton.backgroundColor = kDefaultColor;
    payButton.titleLabel.font = SYSTEM_FONT(15);
    payButton.layer.cornerRadius = 3.0;
    [payButton setTitle:@"确认充值" forState:UIControlStateNormal];
    [payButton addTarget:self action:@selector(confirmTopup) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:payButton];
    _tableView.tableFooterView = contentView;
}

- (void)confirmTopup {
    if (!_header.coinAmount) {
        [SVProgressHUD showInfoWithStatus:@"请选择充值金额"];
        return;
    }
    if (!_selectedIndexPath) {
        [SVProgressHUD showInfoWithStatus:@"请选择付款方式"];
        return;
    }
    TopupResultViewController *vc = [[TopupResultViewController alloc]init];
    NSLog(@"%@ coin",_header.coinAmount);
    vc.coinAmount = _header.coinAmount;
    [self hideBottomBarPush:vc];
}

#pragma mark - UITableViewDataSource, UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datasoure.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TopUpCell *cell = [TopUpCell cellWithTableView:tableView];
    cell.imgView.image = IMAGE_NAMED(_datasoure[indexPath.row]);
    cell.payWayLabel.text = _datasoure[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.view endEditing:YES];
    TopUpCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (_selectedIndexPath) {
        TopUpCell *selectedCell = [tableView cellForRowAtIndexPath:_selectedIndexPath];
        selectedCell.selecedButton.hidden = YES;
    }
    _selectedIndexPath = indexPath;
    cell.selecedButton.hidden = NO;
}



@end
