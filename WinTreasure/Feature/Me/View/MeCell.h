//
//  MeCell.h
//  WinTreasure
//
//  Created by Apple on 16/6/1.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MeCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *menuLabel;

@property (weak, nonatomic) IBOutlet UIImageView *menuImgView;

+ (instancetype)cellWithTableView:(UITableView *)tableview;

@end
