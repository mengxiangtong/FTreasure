//
//  ShareViewController.m
//  WinTreasure
//
//  Created by Apple on 16/6/8.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import "ShareViewController.h"
#import "ShareDetailViewController.h"
#import "PersonalCenterViewController.h"
#import "ShareCell.h"

@interface ShareViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet BaseTableView *shareTableView;

@property (nonatomic, strong) NSMutableArray *layouts;


@end

static NSString *ShareCellIdentifier = @"ShareCellIdentifier";

@implementation ShareViewController

- (NSMutableArray *)layouts {
    if (!_layouts) {
        _layouts = [NSMutableArray array];
    }
    return _layouts;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"晒单分享";
    @weakify(self);
    _shareTableView.mj_header =  [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
        @strongify(self);
        CGFloat delayTime = dispatch_time(DISPATCH_TIME_NOW, 2);
        dispatch_after(delayTime, dispatch_get_main_queue(), ^{
            [self getData];
            [self.shareTableView.mj_header endRefreshing];
        });
    }];
    [_shareTableView.mj_header beginRefreshing];
}

- (void)getData {
    for (int i=0; i<10; i++) {
        ShareModel *model = [[ShareModel alloc]init];
        ShareLayout *layout = [[ShareLayout alloc]initWithModel:model];
        [self.layouts addObject:layout];
    }
    [_shareTableView reloadData];
}

#pragma mark - UITableViewDataSource, UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _layouts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ShareCell *cell = [ShareCell cellWithTableView:tableView];
    cell.indexpath = indexPath;
    [cell setLayout:_layouts[indexPath.row]];
    @weakify(self);
    cell.clickHeadImage = ^(NSIndexPath *indexpath) {
        @strongify(self);
        PersonalCenterViewController *vc = [[PersonalCenterViewController alloc]init];
        [self hideBottomBarPush:vc];
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ShareLayout *layout = _layouts[indexPath.row];
    return layout.height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ShareDetailViewController *vc = [[ShareDetailViewController alloc]init];
    [self hideBottomBarPush:vc];
}

- (void)dealloc {
    NSLog(@"%s",__func__);
}

@end
