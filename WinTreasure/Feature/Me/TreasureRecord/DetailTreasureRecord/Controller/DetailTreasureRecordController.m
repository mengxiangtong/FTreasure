//
//  DetailTreasureRecordController.m
//  WinTreasure
//
//  Created by Apple on 16/6/15.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import "DetailTreasureRecordController.h"
#import "TreasureNumberViewController.h"
#import "DetailTreasureRecordCell.h"
#import "DetailTreasureRecordHeader.h"

@interface DetailTreasureRecordController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet BaseTableView *tableView;

@property (nonatomic, strong) NSMutableArray *datasource;

@end

@implementation DetailTreasureRecordController

- (NSMutableArray *)datasource {
    if (!_datasource) {
        _datasource = [NSMutableArray array];
    }
    return _datasource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"夺宝详情";
    [self setup];
    [self getRecordDetails];
}

- (void)setup {
    DetailTreasureRecordHeader *header = [[DetailTreasureRecordHeader alloc]initWithFrame:({
        CGRect rect = {0,0,kScreenWidth,HUGE};
        rect;
    })];
    [_tableView setTableHeaderView:header];
    [_tableView setCustomSeparatorInset:UIEdgeInsetsZero];
}

- (void)getRecordDetails {
    for (int i=0; i<20; i++) {
        DetailTreasureRecordModel *model = [[DetailTreasureRecordModel alloc]init];
        [self.datasource addObject:model];
    }
    [_tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datasource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailTreasureRecordCell *cell = [DetailTreasureRecordCell cellWithTableView:tableView];
    cell.indexPath = indexPath;
    cell.checkNumber = ^(NSIndexPath *indexpath){
        TreasureNumberViewController *vc = [[TreasureNumberViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    };
    DetailTreasureRecordModel *model = _datasource[indexPath.row];
    cell.model = model;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [ItemHeader loadFromXib];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [ItemHeader height];
}


@end
