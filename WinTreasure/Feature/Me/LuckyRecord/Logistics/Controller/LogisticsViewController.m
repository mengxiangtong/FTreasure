//
//  LogisticsViewController.m
//  WinTreasure
//
//  Created by Apple on 16/6/28.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import "LogisticsViewController.h"
#import "LogisticsCell.h"
#import "LogisticsHeader.h"

@interface LogisticsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet BaseTableView *tableview;

@property (strong, nonatomic) NSMutableArray *datasource;

@property (strong, nonatomic) LogisticsHeader *header;

@end

@implementation LogisticsViewController

- (NSMutableArray *)datasource {
    if (!_datasource) {
        _datasource = [NSMutableArray array];
    }
    return _datasource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"查看物流";
    [self configsTable];
    [self getLogisticsStatus];
}

- (void)configsTable {
    _tableview.estimatedRowHeight = 60.0;
    _tableview.rowHeight = UITableViewAutomaticDimension;
    _header = [[LogisticsHeader alloc]initWithFrame:({
        CGRect rect = {0,0,kScreenWidth,84*2+16};
        rect;
    })];
    _tableview.tableHeaderView = _header;
}

- (void)getLogisticsStatus {
    for (int i=0; i<1; i++) {
        LogisticsModel *model = [[LogisticsModel alloc]init];
        [self.datasource addObject:model];
    }
    _header.model = self.datasource[0];
    [_tableview reloadData];
}

#pragma mark - UITableViewDataSource, UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datasource.count+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row==0) {
        LogisticsFollowCell *cell = [LogisticsFollowCell cellWithTableView:tableView];
        return cell;
    }
    LogisticsCell *cell = [LogisticsCell cellWithTableView:tableView];
    LogisticsModel *model = _datasource[indexPath.row-1];
    cell.model = model;
    return cell;
}

@end
