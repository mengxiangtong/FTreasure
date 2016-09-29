//
//  ProductCategoryViewController.m
//  WinTreasure
//
//  Created by Apple on 16/6/3.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import "ProductCategoryViewController.h"
#import "CategoryDetailViewController.h"
#import "ProductCateCell.h"

@interface ProductCategoryViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet BaseTableView *pcTableView;

@property (nonatomic, strong) NSArray *titles;

@property (nonatomic, strong) NSArray *images;

@end

@implementation ProductCategoryViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"分类浏览";
}

#pragma mark - UITableViewDataSource, UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row==0) {
        ProductAllCateCell *cell = [ProductAllCateCell cellWithTableView:tableView];
        cell.imgView.image = IMAGE_NAMED(self.images[indexPath.row]);
        cell.allProductLabel.text = self.titles[indexPath.row];
        return cell;
    } else if (indexPath.row==1) {
        CategoryCell *cell = [CategoryCell cellWithTableView:tableView];
        cell.imgView.image = IMAGE_NAMED(self.images[indexPath.row]);
        cell.categoryLabel.text = self.titles[indexPath.row];
        return cell;
    } else {
        ProductCateCell *cell = [ProductCateCell cellWithTableView:tableView];
        cell.imgView.image = IMAGE_NAMED(self.images[indexPath.row]);
        cell.categoryLabel.text = self.titles[indexPath.row];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row==1) {
        return;
    }
    if (indexPath.row==0) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        CategoryDetailViewController *vc = [[CategoryDetailViewController alloc]init];
        vc.title = _titles[indexPath.row];
        [self hideBottomBarPush:vc];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row==0) {
        return [ProductAllCateCell height];
    } else if (indexPath.row==1) {
        return [CategoryCell height];
    }
    return [ProductCateCell height];
}

#pragma mark - lazy load
- (NSArray *)images {
    if (!_images) {
        _images = @[@"list_entry_kind_35x35_",@"left_nav_type8_20x20_",@"list_entry_10_35x35_",@"left_nav_type1_20x20_",@"left_nav_type2_20x20_",@"left_nav_type3_20x20_",@"left_nav_type4_20x20_",@"left_nav_type5_20x20_",@"left_nav_type6_20x20_",@"left_nav_type7_20x20_",@"wish_shipping_20x20_"];
    }
    return _images;
}

- (NSArray *)titles {
    if (!_titles) {
        _titles = @[@"全部商品",@"分类浏览",@"十元夺宝",@"手机平板",@"电脑办公",@"数码影音",@"女性时尚",@"美食天地",@"潮流新品",@"周边",@"其他产品"];
    }
    return _titles;
}

#pragma mark - dealloc
- (void)dealloc {
    NSLog(@"%s",__func__);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
