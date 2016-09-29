//
//  PayResultCell.h
//  WinTreasure
//
//  Created by Apple on 16/6/22.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PayResultModel.h"

@interface PayResultCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *paticipateLabel;

@property (weak, nonatomic) IBOutlet UILabel *periodLabel;

@property (weak, nonatomic) IBOutlet UILabel *treasureNoLabel;

@property (nonatomic, strong) PayResultModel *model;

+ (instancetype)cellWithTableView:(UITableView *)tableview;

@end
