//
//  LatestPublishCell.h
//  WinTreasure
//
//  Created by Apple on 16/6/16.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TSCountLabel.h"
#import "LatestPublishModel.h"

@protocol LatestPublishCellDelegate;

@interface LatestPublishCell : UICollectionViewCell

@property (nonatomic, weak) NSIndexPath *indexPath;

@property (nonatomic, assign) BOOL isDisplayed;

@property (weak, nonatomic) IBOutlet UILabel *countLabel;

@property (weak, nonatomic) id<LatestPublishCellDelegate>delegate;

@property (strong, nonatomic) LatestPublishModel *model;

- (void)loadData:(LatestPublishModel *)model indexPath:(NSIndexPath *)indexPath;

+ (CGSize)itemSize;

@end

@protocol LatestPublishCellDelegate <NSObject>

@optional;
- (void)countdownDidEnd:(NSIndexPath *)indexpath;

@end
