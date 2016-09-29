//
//  SearchViewController.m
//  WinTreasure
//
//  Created by Apple on 16/6/21.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import "SearchViewController.h"
#import "CategoryDetailViewController.h"
#import "SearchHeader.h"
#import "SearchCell.h"
#import "SearchView.h"

@interface SearchViewController () <UITableViewDataSource, UITableViewDelegate, SearchViewDelegate>

@property (nonatomic, strong) BaseTableView *tableView;

@property (nonatomic, strong) SearchView *searchView;

@property (nonatomic, strong) NSMutableArray *datasouce;

@end

@implementation SearchViewController


- (NSMutableArray *)datasouce {
    if (!_datasouce) {
        _datasouce = [NSMutableArray array];
    }
    return _datasouce;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[BaseTableView alloc]initWithFrame:({
            CGRect rect = {0,0,kScreenWidth,kScreenHeight};
            rect;
        }) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorColor = UIColorHex(0xe5e5e5);
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setHidesBackButton:YES];
    [self.view addSubview:self.tableView];
    [self getSearchData];
    [self setupSearchView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_searchView beginSearch];
}

- (void)setupSearchView {
    _searchView = [[SearchView alloc]initWithFrame:({
        CGRect rect = {0,0,kScreenWidth,30};
        rect;
    })];
    _searchView.delegate = self;
    @weakify(self);
    _searchView.cancelBlock = ^{
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    };
    self.navigationItem.titleView = _searchView;
}

- (void)getSearchData {
    for (int i=0; i<0; i++) {
        SearchModel *model = [[SearchModel alloc]init];
        [self.datasouce addObject:model];
    }
    [_tableView reloadData];
}

#pragma mark - UITableViewDataSource, UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datasouce.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row==0) {
        @weakify(self);
        SearchCell *cell = [SearchCell cellWithTableView:tableView];
        cell.clearBlock = ^ {
            @strongify(self);
            [self.datasouce removeAllObjects];
            [self.tableView reloadData];
        };
        return cell;
    }
    SearchResultCell *cell = [SearchResultCell cellWithTableView:tableView];
    cell.model = _datasouce[indexPath.row - 1];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [SearchHeader height];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    SearchHeader *header = [[SearchHeader alloc]initWithData:nil];
    @weakify(self);
    header.clickHotProduct = ^(UIButton *sender ){
        @strongify(self);
        NSLog(@"%@",[sender titleForState:UIControlStateNormal]);
        SearchModel *model = [[SearchModel alloc]init];
        model.productName = [sender titleForState:UIControlStateNormal];
        [self.datasouce addObject:model];
        [self.tableView reloadData];
        [self getResultVC];
    };
    return header;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row==0) {
        return;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self getResultVC];
}

- (void)getResultVC {
    [_searchView.searchBar resignFirstResponder];
    [self setBackItem];
    CategoryDetailViewController *vc = [[CategoryDetailViewController alloc]init];
    [self hideBottomBarPush:vc];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - SearchViewDelegate
- (void)searchViewSearchButtonClicked:(SearchView *)searchView {
    SearchModel *model = [[SearchModel alloc]init];
    model.productName = searchView.text;
    [self.datasouce addObject:model];
    [self.tableView reloadData];
    [self getResultVC];
}


- (void)dealloc {
    NSLog(@"%s",__func__);
}

@end
