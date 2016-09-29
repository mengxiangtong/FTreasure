//
//  BonusCell.h
//  WinTreasure
//
//  Created by Apple on 16/6/17.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BonusModel.h"

@interface BonusCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *sumLabel;

@property (weak, nonatomic) IBOutlet UILabel *conditionLabel;

@property (weak, nonatomic) IBOutlet UILabel *bonusNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *effectDateLabel;

@property (weak, nonatomic) IBOutlet UILabel *indateLabel;

@property (weak, nonatomic) IBOutlet UIImageView *bonusTypeImgView;

@property (weak, nonatomic) IBOutlet UIButton *useButton;

@property (strong, nonatomic) BonusModel *model;

+ (instancetype)cellWithTableView:(UITableView *)tableview;

@end
