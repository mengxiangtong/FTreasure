//
//  SearchCell.h
//  WinTreasure
//
//  Created by Apple on 16/6/24.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchModel.h"

typedef void(^SearchCellBlock)(void);

@interface SearchCell : UITableViewCell

@property (nonatomic,copy) SearchCellBlock clearBlock;

+ (instancetype)cellWithTableView:(UITableView *)tableview;

@end

@interface SearchResultCell : UITableViewCell

@property (nonatomic, strong) YYLabel *nameLabel;

@property (nonatomic, strong) SearchModel *model;

+ (instancetype)cellWithTableView:(UITableView *)tableview;

@end
