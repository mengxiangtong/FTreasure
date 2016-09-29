//
//  TreasureRecordViewController.m
//  WinTreasure
//
//  Created by Apple on 16/6/2.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import "TreasureRecordViewController.h"
#import "TreasureDetailViewController.h"
#import "DetailTreasureRecordController.h"
#import "TreasureRecordCell.h"
#import "RedBook.h"
#import "TSMenu.h"

@interface TreasureRecordViewController () <UITableViewDataSource, UITableViewDelegate>
{
    RedBook *redBookView;
}
@property (nonatomic ,strong) NSMutableArray *datasource;

@property (nonatomic ,strong) TSMenu *menu;

@property (weak, nonatomic) IBOutlet BaseTableView *tableView;

@end

@implementation TreasureRecordViewController

- (NSMutableArray *)datasource {
    if (!_datasource) {
        _datasource = [NSMutableArray array];
    }
    return _datasource;
}

- (TSMenu *)menu {
    if (!_menu) {
        _menu = [[TSMenu alloc]initWithDataArray:@[@"全部", @"进行中", @"已揭晓"]];
        _menu.origin = CGPointMake(0, kNavigationBarHeight);
        _menu.size = CGSizeMake(kScreenWidth, kTSMenuHeight);
        switch (_recordType) {
            case TreasureRecordTypePaticipated:
                _menu.selectIndex = 0;
                break;
            case TreasureRecordTypeInProceed:
                _menu.selectIndex = 1;
                break;
            case TreasureRecordTypePublished:
                _menu.selectIndex = 2;
                break;
            default:
                break;
        }
    }
    return _menu;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"夺宝记录";
    [self setMenu];
    [self setTableview];
}

- (void)setTableview {
    @weakify(self);
    _tableView.mj_header =  [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
        @strongify(self);
        CGFloat delayTime = dispatch_time(DISPATCH_TIME_NOW, 2);
        dispatch_after(delayTime, dispatch_get_main_queue(), ^{
            [self getdata];
            [self.tableView.mj_header endRefreshing];
        });
    }];
    [_tableView.mj_header beginRefreshing];
}

- (void)setMenu {
    [self.view addSubview:self.menu];
    [self chooseMenu];
}

#pragma mark - 筛选
- (void)chooseMenu {
    @weakify(self);
    _menu.menuBlock = ^(id object){
        @strongify(self);
        UIButton *sender = (UIButton *)object;
        [self.datasource enumerateObjectsUsingBlock:^(id  _Nonnull obj,
                                                      NSUInteger idx,
                                                      BOOL * _Nonnull stop) {
            TreasureRecordLayout *layout = (TreasureRecordLayout *)obj;
            switch (sender.tag) {
                case 1: {//全部
                    layout.model.type = arc4random() % 3;
                }
                    break;
                case 2: {//进行中
                    layout.model.type = TreasureRecordTypeInProceed;
                }
                    break;
                case 3: {//已揭晓
                    layout.model.type = TreasureRecordTypePublished;
                }
                    break;
                default:
                    break;
            }
            [self.datasource replaceObjectAtIndex:idx withObject:layout];
        }];
        [self.tableView reloadData];
    };
}

- (void)getdata {
    for (int i=0; i<8; i++) {
        TreasureRecordModel *model = [[TreasureRecordModel alloc]init];
        model.type = arc4random() % 3;
        TreasureRecordLayout *layout = [[TreasureRecordLayout alloc]initWithModel:model];
        [self.datasource addObject:layout];
    }
    [_tableView reloadData];
}

#pragma mark - Datasource Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datasource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TreasureRecordCell *cell = [TreasureRecordCell cellWithTableView:tableView];
    TreasureRecordLayout *layout = _datasource[indexPath.row];
    cell.indexPath = indexPath;
    [cell setLayout:layout];
    
    @weakify(self);
    cell.checkDetails = ^(NSIndexPath *indexpath){
        @strongify(self);
        NSLog(@"indexpath %@",indexPath);
        DetailTreasureRecordController *vc = [[DetailTreasureRecordController alloc]init];
        [self hideBottomBarPush:vc];
    };
    cell.purchaseBlock = ^(NSIndexPath *indexpath){
        @strongify(self);
        NSLog(@"indexpath %@",indexPath);
        TreasureDetailViewController *vc = [[TreasureDetailViewController alloc]init];
        [self hideBottomBarPush:vc];
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    TreasureRecordLayout *layout = _datasource[indexPath.row];
    return layout.height;
}

- (void)dealloc {
    NSLog(@"%s",__func__);
}



@end
