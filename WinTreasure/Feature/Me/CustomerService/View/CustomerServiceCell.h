//
//  CustomerServiceCell.h
//  WinTreasure
//
//  Created by Apple on 16/7/6.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomerServiceModel.h"

@interface CustomerServiceCell : UITableViewCell

@property (nonatomic, strong) CustomerServiceModel *model;

+ (instancetype)cellWithTableView:(UITableView *)tableview;

@end

@interface ServiceCell : UITableViewCell


+ (instancetype)cellWithTableView:(UITableView *)tableview;

@end
