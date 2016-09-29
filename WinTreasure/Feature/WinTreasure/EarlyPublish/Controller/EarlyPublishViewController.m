//
//  EarlyPublishViewController.m
//  WinTreasure
//
//  Created by Apple on 16/6/14.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import "EarlyPublishViewController.h"
#import "PersonalCenterViewController.h"
#import "EarlyPubLishCell.h"

@interface EarlyPublishViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *datasource;

@end


@implementation EarlyPublishViewController

- (NSMutableArray *)datasource {
    if (!_datasource) {
        _datasource = [NSMutableArray array];
    }
    return _datasource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"往期揭晓";
    [self setTable];
}

- (void)setTable {
    _tableView.estimatedRowHeight = 180;
    _tableView.rowHeight = UITableViewAutomaticDimension;
    @weakify(self);
    _tableView.mj_header =  [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
        @strongify(self);
        CGFloat delayTime = dispatch_time(DISPATCH_TIME_NOW, 2);
        dispatch_after(delayTime, dispatch_get_main_queue(), ^{
            [self getData];
            [self.tableView.mj_header endRefreshing];
        });
    }];
    [_tableView.mj_header beginRefreshing];
}

- (void)getData {
    [self.datasource removeAllObjects];
    for (int i=0; i<8; i++) {
        EarlyPublishModel *model = [[EarlyPublishModel alloc]init];
        [self.datasource addObject:model];
    }
    [_tableView reloadData];
}

#pragma mark - UITableViewDataSource, UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datasource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EarlyPubLishCell *cell = [EarlyPubLishCell cellWithTableView:tableView];
    EarlyPublishModel *model = _datasource[indexPath.row];
    cell.model = model;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PersonalCenterViewController *vc = [[PersonalCenterViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    NSLog(@"%s",__func__);
}


@end
