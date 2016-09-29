//
//  TopupViewController.m
//  WinTreasure
//
//  Created by Apple on 16/6/15.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import "TopupViewRecordController.h"
#import "TopupViewController.h"
#import "TopupRecordCell.h"

@interface TopupViewRecordController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) BaseTableView *topupTableView;

@property (nonatomic, strong) NSMutableArray *datasource;

@end


@implementation TopupViewRecordController

- (NSMutableArray *)datasource {
    if (!_datasource) {
        _datasource = [NSMutableArray array];
    }
    return _datasource;
}

- (UITableView *)topupTableView {
    if (!_topupTableView) {
        _topupTableView = [[BaseTableView alloc]initWithFrame:({
            CGRect rect = {0,0,kScreenWidth,kScreenHeight};
            rect;
        }) style:UITableViewStylePlain];
        _topupTableView.dataSource = self;
        _topupTableView.delegate = self;
        _topupTableView.estimatedRowHeight = 60;
        _topupTableView.rowHeight = UITableViewAutomaticDimension;
        [_topupTableView setSeparatorInset:UIEdgeInsetsMake(0, 10, 0, 0)];
    }
    return _topupTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"充值记录";
    [self setRightItemTitle:@"充值" action:@selector(topup)];
    [self.view addSubview:self.topupTableView];
    [self getTopupData];
}

- (void)getTopupData {
    for (int i=0; i<10; i++) {
        TopupRecordModel *model = [[TopupRecordModel alloc]init];
        [self.datasource addObject:model];
    }
}

- (void)topup {
    TopupViewController *vc = [[TopupViewController alloc]init];
    [self hideBottomBarPush:vc];
}

#pragma mark - UITableViewDataSource, UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datasource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TopupRecordCell *cell = [TopupRecordCell cellWithTableView:tableView];
    cell.model = _datasource[indexPath.row];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
