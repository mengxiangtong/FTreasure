//
//  CategoryDetailViewController.m
//  WinTreasure
//
//  Created by Apple on 16/6/6.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import "CategoryDetailViewController.h"
#import "ShoppingListViewController.h"
#import "TreasureDetailViewController.h"
#import "CategoryDetailCell.h"
#import "CategoryDetailHeader.h"

@interface CategoryDetailViewController () <UITableViewDataSource, UITableViewDelegate, CategoryDetailCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *cdTableView;

@property (nonatomic, strong) NSMutableArray *datasource;

@end

@implementation CategoryDetailViewController

- (NSMutableArray *)datasource {
    if (!_datasource) {
        _datasource = [NSMutableArray array];
    }
    return _datasource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setRightImageNamed:@"detail_nav_car" action:@selector(shoppingList)];
    [self getDatasource];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setItemBadge:[AppDelegate getAppDelegate].value];
    if (!_isFromHome) {
        return;
    }
    self.navigationItem.title = @"十元专区";
    [self setDefaultNavigationBar];
    
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self hideItemBadge];
}

- (void)getDatasource {
    [SVProgressHUD show];
    for (int i=0; i<8; i++) {
        CategoryModel *model = [[CategoryModel alloc]init];
        [self.datasource addObject:model];
    }
    [_cdTableView reloadData];
    [SVProgressHUD dismiss];
}

#pragma mark - 去往购物车
- (void)shoppingList {
    ShoppingListViewController *vc = [[ShoppingListViewController alloc]init];
    vc.isPushed = YES;
    [self hideBottomBarPush:vc];
}

#pragma mark - UITableViewDataSource, UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datasource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CategoryDetailCell *cell = [CategoryDetailCell cellWithTableView:tableView];
    CategoryModel *model = _datasource[indexPath.row];
    cell.model = model;
    cell.delegate = self;
    cell.indexpath = indexPath;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    CategoryDetailHeader *header = [CategoryDetailHeader header];
    if (_isFromHome) {
        header.addListBtn.hidden = YES;
    }
    @weakify(self);
    header.addListBlock = ^{
        NSLog(@"全部加入清单");
        @strongify(self);
        [AppDelegate getAppDelegate].value += self.datasource.count;
        [self setItemBadge:[AppDelegate getAppDelegate].value];
        [self.datasource enumerateObjectsUsingBlock:^(id  _Nonnull obj,
                                                      NSUInteger idx,
                                                      BOOL * _Nonnull stop) {
            CategoryModel *model = (CategoryModel *)obj;
            model.isSelected = YES;
            [self.datasource replaceObjectAtIndex:idx withObject:obj];
        }];
    };
    return header;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    TreasureDetailViewController *vc = [[TreasureDetailViewController alloc]init];
    [self hideBottomBarPush:vc];
}

#pragma mark - CategoryDetailCellDelegate
- (void)clickAddListButtonAtCell:(CategoryDetailCell *)cell {
    CategoryModel *model = _datasource[cell.indexpath.row];
    if (!model.isSelected) {
        [AppDelegate getAppDelegate].value += 1;
    }
    model.isSelected = YES;
    [_datasource replaceObjectAtIndex:cell.indexpath.row withObject:model];
    [self setItemBadge:[AppDelegate getAppDelegate].value];
}

#pragma mark - dealloc
- (void)dealloc {
    NSLog(@"%s",__func__);
}

@end
