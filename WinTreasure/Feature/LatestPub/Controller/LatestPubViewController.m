//
//  LatestPubViewController.m
//  WinTreasure
//
//  Created by Apple on 16/5/31.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import "LatestPubViewController.h"
#import "TreasureDetailViewController.h"
#import "PublishedCell.h"
#import "LatestPublishCell.h"

@interface LatestPubViewController () <UICollectionViewDelegateFlowLayout, UICollectionViewDelegate,UICollectionViewDataSource,LatestPublishCellDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *datasource;

@property (nonatomic, strong) NSTimer *timer;

@end

static NSString *PublishedCellIdentifier = @"PublishedCellIdentifier";
static NSString *LatestPublishedCellIdentifier = @"LatestPublishedCellIdentifier";

@implementation LatestPubViewController

- (NSMutableArray *)datasource {
    if (!_datasource) {
        _datasource = [NSMutableArray array];
    }
    return _datasource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"最新揭晓";
    [self configCollectionview];
    @weakify(self);
    _collectionView.mj_header =  [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
        @strongify(self);
        CGFloat delayTime = dispatch_time(DISPATCH_TIME_NOW, 2);
        dispatch_after(delayTime, dispatch_get_main_queue(), ^{
            [self getLatestPubData];
            [self.collectionView.mj_header endRefreshing];
        });
    }];
    [_collectionView.mj_header beginRefreshing];
}

- (void)configCollectionview {
    _type = TreasureDetailTypeToBePublished;
    [_collectionView registerNib:NIB_NAMED(@"PublishedCell") forCellWithReuseIdentifier:PublishedCellIdentifier];
    [_collectionView registerNib:NIB_NAMED(@"LatestPublishCell") forCellWithReuseIdentifier:LatestPublishedCellIdentifier];
}

- (void)getLatestPubData {
    for (int i=0; i<10; i++) {
        LatestPublishModel *model = [[LatestPublishModel alloc]init];
        [model start];
        [self.datasource addObject:model];
    }
    [_collectionView reloadData];
}

#pragma mark -  UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.datasource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LatestPublishModel *model = _datasource[indexPath.row];
    if (_type==TreasureDetailTypeToBePublished) {
        LatestPublishCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:LatestPublishedCellIdentifier forIndexPath:indexPath];
        cell.delegate = self;
        [cell loadData:model indexPath:indexPath];
        return cell;
    }
    PublishedCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:PublishedCellIdentifier forIndexPath:indexPath];
    cell.model = model;
    return cell;

}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    if (_type==TreasureDetailTypeToBePublished) {
        LatestPublishCell *tmpCell = (LatestPublishCell *)cell;
        tmpCell.isDisplayed = YES;
        [tmpCell loadData:_datasource[indexPath.row] indexPath:indexPath];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    if (_type==TreasureDetailTypeToBePublished) {
        LatestPublishCell *tmpCell = (LatestPublishCell *)cell;
        tmpCell.isDisplayed = NO;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (_type==TreasureDetailTypeToBePublished) {
        return [LatestPublishCell itemSize];
    }
    return [PublishedCell getItemSize];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    TreasureDetailViewController *vc = [[TreasureDetailViewController alloc]init];
    LatestPublishModel *model = _datasource[indexPath.row];
    vc.count = model.currentValue;
    vc.showType = TreasureDetailHeaderTypeCountdown;
    [self pushController:vc];
    
}

#pragma mark - LatestPublishCellDelegate
- (void)countdownDidEnd:(NSIndexPath *)indexpath {
    _type = TreasureDetailTypePublished;
    [_collectionView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
