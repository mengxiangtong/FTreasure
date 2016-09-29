//
//  SelectBonusViewController.m
//  WinTreasure
//
//  Created by Apple on 16/6/21.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import "SelectBonusViewController.h"
#import "SelectBonusCell.h"
#import "BonusModel.h"

@interface SelectBonusViewController () <UITableViewDataSource, UITableViewDelegate>


@property (nonatomic, assign) NSInteger bonusCount;

@property (weak, nonatomic) IBOutlet BaseTableView *tableView;

@end

@implementation SelectBonusViewController

- (NSMutableArray *)datasource {
    if (!_datasource) {
        _datasource = [NSMutableArray array];
    }
    return _datasource;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setConfigs];
//    [self getBonusData];
}

- (void)setConfigs {
    self.navigationItem.title = @"选择红包";
    [self setRightItemTitle:@"不使用红包" action:@selector(donotUseBonus)];
    [_tableView setCustomSeparatorInset:UIEdgeInsetsZero];
}

- (void)getBonusData {
    for (int i=0; i<1; i++) {
        SelectBonusModel *model = [[SelectBonusModel alloc]init];
        [self.datasource addObject:model];
    }
    [_tableView reloadData];
}

- (void)donotUseBonus {
    if (_chooseBonus) {
        _chooseBonus(0);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableViewDataSource 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datasource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SelectBonusCell *cell = [SelectBonusCell cellWithTableView:tableView];
    SelectBonusModel *model = _datasource[indexPath.row];
    cell.model = model;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SelectBonusCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectButton.selected = !cell.selectButton.selected;
    SelectBonusModel *model = _datasource[indexPath.row];
    model.isSelected = !model.isSelected;
    [_datasource replaceObjectAtIndex:indexPath.row withObject:model];
    if (_chooseBonus) {
        _chooseBonus([self getSelectedBonusCount]);
    }
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark -
- (NSInteger)getSelectedBonusCount {
    @weakify(self);
    __block NSInteger sum = 0;
    [_datasource enumerateObjectsUsingBlock:^(id  _Nonnull obj,
                                              NSUInteger idx,
                                              BOOL * _Nonnull stop) {
        @strongify(self);
        SelectBonusModel *model = (SelectBonusModel *)obj;
        if (model.isSelected) {
            sum += 1;
        }
        self.bonusCount = sum;
    }];
    return self.bonusCount;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
