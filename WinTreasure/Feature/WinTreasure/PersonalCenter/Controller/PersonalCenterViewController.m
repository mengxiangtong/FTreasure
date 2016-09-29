//
//  PersonalCenterViewController.m
//  WinTreasure
//
//  Created by Apple on 16/6/14.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import "PersonalCenterViewController.h"
#import "DetailTreasureRecordController.h"
#import "TreasureDetailViewController.h"
#import "ShareDetailViewController.h"
#import "PersonalCenterMenuHeader.h"
#import "PersonalCenterHeader.h"
#import "PersonalTreasureCell.h"
#import "PersonalLuckyCellCell.h"
#import "TreasureRecordCell.h"
#import "ShareCell.h"

@interface PersonalCenterViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) BaseTableView *tableView;

@property (nonatomic, strong) PersonalCenterHeader *header;

@property (nonatomic, strong) PersonalCenterMenuHeader *menuHeader;

@property (nonatomic, strong) NSMutableArray *layouts;

@property (nonatomic, strong) NSMutableArray *datasource;

@end

@implementation PersonalCenterViewController


- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[BaseTableView alloc]initWithFrame:({
            CGRect rect = {0,0,kScreenWidth,kScreenHeight};
            rect;
        }) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorColor = UIColorHex(0xeeeeee);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableHeaderView = self.header;
        [_tableView setCustomSeparatorInset:UIEdgeInsetsZero];
    }
    return _tableView;
}

- (NSMutableArray *)datasource {
    if (!_datasource) {
        _datasource = [NSMutableArray array];
    }
    return _datasource;
}

- (NSMutableArray *)layouts {
    if (!_layouts) {
        _layouts = [NSMutableArray array];
    }
    return _layouts;
}

- (PersonalCenterHeader *)header {
    if (!_header) {
        PersonalCenterHeader *header = [[PersonalCenterHeader alloc]initWithFrame:({
            CGRect rect = {0,0,kScreenWidth,1};
            rect;
        })];
        _header = header;
    }
    return _header;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"TA的个人中心";
    _type = PersonalCenterRecordTreasureType;
    [self.view addSubview:self.tableView];
    [self getPersonalInfo];
    [self getTreasureRecordData];
}

- (void)getPersonalInfo {
    NSDictionary *info = @{@"nickname":@"斯嘉丽·约翰逊",@"imgUrl": @"https://tse4-mm.cn.bing.net/th?id=OIP.M9271c634f71d813901afbc9e69602dcfo2&pid=15.1",@"id":@"12345678"};
    _header.infoDic = info;
}

- (void)getLuckyRecordData {
    for (int i=0; i<5; i++) {
        LuckyRecordModel *model = [[LuckyRecordModel alloc]init];
        [self.datasource addObject:model];
    }
}

- (void)getTreasureRecordData {
    if (_type == PersonalCenterRecordTreasureType) {
        for (int i=0; i<5; i++) {
            TreasureRecordModel *model = [[TreasureRecordModel alloc]init];
            model.type = arc4random() % 3;
            TreasureRecordLayout *layout = [[TreasureRecordLayout alloc]initWithModel:model];
            [self.datasource addObject:layout];
        }
    }
}

- (void)getShareData {
    for (int i=0; i<5; i++) {
        ShareModel *model = [[ShareModel alloc]init];
        ShareLayout *layout = [[ShareLayout alloc]initWithModel:model];
        [self.datasource addObject:layout];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datasource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (_type) {
        case PersonalCenterRecordTreasureType: {
            TreasureRecordCell *cell = [TreasureRecordCell cellWithTableView:tableView];
            cell.indexPath = indexPath;
            TreasureRecordLayout *layout = _datasource[indexPath.row];
            [cell setLayout:layout];
            @weakify(self);
            cell.checkDetails = ^(NSIndexPath *indexpath){
                NSLog(@"indexpath %@",indexPath);
                @strongify(self);
                DetailTreasureRecordController *vc = [[DetailTreasureRecordController alloc]init];
                [self hideBottomBarPush:vc];
            };
            cell.purchaseBlock = ^(NSIndexPath *indexpath) {
                @strongify(self);
                TreasureDetailViewController *vc = [[TreasureDetailViewController alloc]init];
                [self hideBottomBarPush:vc];

            };
            
            return cell;
        }
            break;
        case PersonalCenterRecordLuckyType: {
            PersonalLuckyCellCell *cell = [PersonalLuckyCellCell cellWithTableView:tableView];
            LuckyRecordModel *model = _datasource[indexPath.row];
            cell.model = model;
            return cell;
        }
            break;
        case PersonalCenterRecordDreamType: {
            PersonalLuckyCellCell *cell = [PersonalLuckyCellCell cellWithTableView:tableView];
            return cell;
        }
            break;
        case PersonalCenterRecordShareType: {
            ShareCell *cell = [ShareCell cellWithTableView:tableView];
            [cell setLayout:_datasource[indexPath.row]];
            return cell;
        }
            break;
        default:
            break;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (!_menuHeader) {
        _menuHeader = [[PersonalCenterMenuHeader alloc]initWithFrame:({
            CGRect rect = {0,0,kScreenWidth,kTSMenuHeight};
            rect;
        })];
    }
   
    @weakify(self);
    [_menuHeader selectAMenu:^(id object) {
        @strongify(self);
        if (self.datasource.count>0) {
            [self.datasource removeAllObjects];
        }
        UIButton *sender = (UIButton *)object;
        switch (sender.tag) {
            case 1:
                self.type = PersonalCenterRecordTreasureType;
                self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
                [self getTreasureRecordData];
                break;
            case 2:
                self.type = PersonalCenterRecordLuckyType;
                self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
                [self getLuckyRecordData];
                break;
            case 3:
//                self.type = PersonalCenterRecordDreamType;
//                self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
//                break;
//            case 4:
                self.type = PersonalCenterRecordShareType;
                self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
                [self getShareData];
                break;
            default:
                break;
        }
        [self.tableView reloadData];
    }];
    return _menuHeader;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (_type) {
        case PersonalCenterRecordShareType: {
            ShareDetailViewController *vc = [[ShareDetailViewController alloc]init];
            [self hideBottomBarPush:vc];
        }
            break;
        default:
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return kTSMenuHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (_type) {
        case PersonalCenterRecordTreasureType: {
            TreasureRecordLayout *layout = _datasource[indexPath.row];
            return layout.height;
        }
            break;
        case PersonalCenterRecordLuckyType:case PersonalCenterRecordDreamType: {
            return 150;
        }
            break;
        case PersonalCenterRecordShareType: {
            ShareLayout *layout = _datasource[indexPath.row];
            return layout.height;
        }
            break;
        default:
            break;
    }
}

- (void)dealloc {
    NSLog(@"%s",__func__);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
