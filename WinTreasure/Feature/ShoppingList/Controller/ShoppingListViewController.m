//
//  ShoppingListViewController.m
//  WinTreasure
//
//  Created by Apple on 16/5/31.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import "ShoppingListViewController.h"
#import "ListConfirmViewController.h"
#import "ShoppingListCell.h"
#import "BillView.h"
#import "ShopListCell.h"

@interface ShoppingListViewController () <UITableViewDataSource, UITableViewDelegate,DZNEmptyDataSetSource, DZNEmptyDataSetDelegate, ShoppingListCellDelegate>

@property (nonatomic, copy) NSNumber *moneySum;

@property (strong, nonatomic) BaseTableView *slTableView;

@property (strong, nonatomic) BillView *billView;

@property (strong, nonatomic) NSMutableArray *datasource;

@property (strong, nonatomic) NSMutableArray *deleteArray;

@property (assign, nonatomic) BOOL isAllSelected;

@end

@implementation ShoppingListViewController

- (NSMutableArray *)deleteArray {
    if (!_deleteArray) {
        _deleteArray = [NSMutableArray array];
    }
    return _deleteArray;
}

- (NSMutableArray *)datasource {
    if (!_datasource) {
        _datasource = [NSMutableArray array];
    }
    return _datasource;
}

- (UITableView *)slTableView {
    if (!_slTableView) {
        _slTableView = [[BaseTableView alloc]initWithFrame:({
            CGRect rect = {0,0,kScreenWidth,_isPushed?kScreenHeight-[BillView getHeight]:kScreenHeight-[BillView getHeight]-kTabBarHeight};
            rect;
        }) style:UITableViewStylePlain];
        _slTableView.dataSource = self;
        _slTableView.delegate = self;
        _slTableView.emptyDataSetDelegate = self;
        _slTableView.emptyDataSetSource = self;
        _slTableView.backgroundColor = UIColorHex(0xeeeeee);
        _slTableView.separatorColor = UIColorHex(0xeeeeee);
        _slTableView.allowsMultipleSelection = YES;
        _slTableView.allowsSelectionDuringEditing = YES;
        [_slTableView setCustomSeparatorInset:UIEdgeInsetsZero];
        _slTableView.editing = NO;
    }
    return _slTableView;
}

- (BillView *)billView {
    if (!_billView) {
        _billView = [[BillView alloc]initWithFrame:({
            CGRect rect = {0,_isPushed ? kScreenHeight-[BillView getHeight] : kScreenHeight-[BillView getHeight]-kTabBarHeight, kScreenWidth, [BillView getHeight]};
            rect;
        })];
    }
    return _billView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _moneySum = @([AppDelegate getAppDelegate].value);
    self.navigationItem.title = @"清单";
    [self.view addSubview:self.slTableView];
    
//    static void(^block)(NSInteger);
//    block = ^(NSInteger i){
//        if (i>0) {
//            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                NSLog(@"hello %@",@(i));
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    block(i-1);
//                });
//            });
//        }
//    };
//    block(3);
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getDatasource];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    _slTableView.editing = NO;
    [_billView setNormalStyle];
}

- (void)getDatasource {
    [self.datasource removeAllObjects];
    for (int i=0; i<[AppDelegate getAppDelegate].value; i++) {
        ShoppingListModel *model = [[ShoppingListModel alloc]init];
        ShoppingListLayout *layout = [[ShoppingListLayout alloc]initWithModel:model];
        [self.datasource addObject:layout];
    }
    [_slTableView reloadData];
    [self getMoneySum];
    [self setupBillview];
}

- (void)setupBillview {
    if (self.datasource.count<=0) {
        _slTableView.frame = CGRectMake(0,0,kScreenWidth,_isPushed?kScreenHeight:kScreenHeight-kTabBarHeight);
        return;
    }
    [self setRightItemTitle:@"编辑" action:@selector(editList)];
    [self.view addSubview:self.billView];
    [_billView setMoneySum:_moneySum];
    [self excuteBuyEvent];
    [self excuteDeleteEvent];
    [self excuteSelectEvent];
}

- (void)excuteBuyEvent {
    @weakify(self);
    _billView.buyBlock = ^{
        @strongify(self);
        ListConfirmViewController *vc = [[ListConfirmViewController alloc]init];
        vc.productDic = @{@"moneySum":(self.moneySum),@"goodsSum":@([AppDelegate getAppDelegate].value)};
        vc.datasource = self.datasource;
        [self pushController:vc];
    };
}

- (void)excuteDeleteEvent {
    @weakify(self);
    _billView.deleteBlock = ^{
        @strongify(self);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"确定要删除么？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert showAlertViewWithCompleteBlock:^(NSInteger buttonIndex) {
            if (buttonIndex==1) {
                if (!self.slTableView.editing) {
                    return;
                }
                [self.deleteArray removeAllObjects];
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSMutableArray *indexPaths = [NSMutableArray array];
                    [self.datasource enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        ShoppingListLayout *layout = (ShoppingListLayout *)obj;
                        if (layout.model.isChecked) {
                            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:idx inSection:0];
                            NSLog(@"index Path %@",indexPath);
                            [indexPaths addObject:indexPath];
                            [self.deleteArray addObject:layout];
                        }
                    }];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //删除
                        NSInteger dataCount = self.datasource.count;
                        [AppDelegate getAppDelegate].value = dataCount - self.deleteArray.count;
                        [self setBadgeValue:[AppDelegate getAppDelegate].value atIndex:3];
                        [self.datasource removeObjectsInArray:self.deleteArray];
                        [self getMoneySum];
                        [self.billView setMoneySum:self.moneySum];
                        [self editList];
                        if (self.deleteArray.count == dataCount) {
                            self.rightBtn.hidden = YES;
                            self.slTableView.frame = CGRectMake(0,0,kScreenWidth,self.isPushed?kScreenHeight:kScreenHeight-kTabBarHeight);
                            [self.billView removeFromSuperview];
                        }
                    });
                });
            }
        }];
    };
}

- (void)excuteSelectEvent {
    @weakify(self);
    _billView.selectBlock = ^(UIButton *sender) {
        @strongify(self);
        if (!self.billView.isSelect) {
            [self.billView setAttributeTitle:[NSString stringWithFormat:@"全选\n已选中0件商品"]forState:UIControlStateNormal];
            [self selectAllProducts:NO];
            self.isAllSelected = NO;
            [self.slTableView reloadData];
            return;
        }
        self.isAllSelected = YES;
        [self.billView setAttributeTitle:[NSString stringWithFormat:@"取消全选\n已选中%@件商品",@(self.datasource.count)] forState:UIControlStateSelected];
        [self selectAllProducts:YES];
    };
}

- (void)selectAllProducts:(BOOL)isChecked {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [_datasource enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            ShoppingListLayout *layout = (ShoppingListLayout *)obj;
            layout.model.isChecked = isChecked;
            [_datasource replaceObjectAtIndex:idx withObject:layout];
        }];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!isChecked) {
                return;
            }
            [_slTableView reloadData];
        });
    });
}

#pragma mark - 编辑消息
- (void)editList {
    NSString *string = [self.rightBtn titleForState:UIControlStateNormal];
    if ([string isEqualToString:@"编辑"]) {
        [_billView setDeleteStyle];
        [self setRightItemTitle:@"取消" action:@selector(editList)];
    } else if ([string isEqualToString:@"取消"]) {
        [_billView setNormalStyle];
        [self selectAllProducts:NO];
        [self setRightItemTitle:@"编辑" action:@selector(editList)];
    }
    [_slTableView setEditing:!_slTableView.editing animated:YES];
    [_slTableView performSelector:@selector(reloadData) withObject:nil afterDelay:0.3];
}

#pragma mark - UITableViewDataSource, UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datasource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ShoppingListLayout *layout = _datasource[indexPath.row];
    ShoppingListCell *cell = [ShoppingListCell cellWithTableView:tableView];
    cell.layout = layout;
    cell.delegate = self;
    cell.indexPath = indexPath;
    [cell setChecked:layout.model.isChecked];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ShoppingListLayout *layout = _datasource[indexPath.row];
    return layout.height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!tableView.editing) {
        return;
    }
    EditingCell *cell = [_slTableView cellForRowAtIndexPath:indexPath];
    ShoppingListLayout *layout = _datasource[indexPath.row];
    layout.model.isChecked = !layout.model.isChecked;
    [cell setChecked:layout.model.isChecked];
    int i = 0;
    for (ShoppingListLayout *layout in _datasource) {
        if (layout.model.isChecked==YES) {
            i++;
        }
    }
    NSString *title = i>=_datasource.count?[NSString stringWithFormat:@"取消全选\n已选中%@件商品",@(_datasource.count)]:[NSString stringWithFormat:@"全选\n已选中%@件商品",@(i)];
    if (i >= _datasource.count) {
        [_billView setSelected:YES];
        [_billView setAttributeTitle:title forState:UIControlStateSelected];
    } else {
        [_billView setSelected:NO];
        [_billView setAttributeTitle:title forState:UIControlStateNormal];
    }

}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleNone;
}

#pragma mark - ShoppingListCellDelegate
- (void)listCount:(NSNumber *)listCount atIndexPath:(NSIndexPath *)indexPath {
    ShoppingListLayout *layout = _datasource[indexPath.row];
    layout.model.selectCount = listCount;
    [_datasource replaceObjectAtIndex:indexPath.row withObject:layout];
    [self getMoneySum];
    [_billView setMoneySum:self.moneySum];
}

#pragma mark - DZNEmptyDataSetSource, DZNEmptyDataSetDelegate
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@"empty_placeholder"];
}

#pragma mark - 
- (void)getMoneySum {
    @weakify(self);
    __block NSInteger sum = 0;
    [_datasource enumerateObjectsUsingBlock:^(id  _Nonnull obj,
                                              NSUInteger idx,
                                              BOOL * _Nonnull stop) {
        @strongify(self);
        ShoppingListLayout *oneLayout = (ShoppingListLayout *)obj;
        sum += (oneLayout.model.unitCost.integerValue * oneLayout.model.selectCount.integerValue);
        self.moneySum = @(sum);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    NSLog(@"%s",__func__);
}


@end
