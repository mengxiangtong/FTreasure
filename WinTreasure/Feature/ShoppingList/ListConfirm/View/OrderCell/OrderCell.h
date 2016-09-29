//
//  OrderCell.h
//  WinTreasure
//
//  Created by Apple on 16/6/20.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableview;

+ (CGFloat)height;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end


@interface OrderIntroCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableview;

+ (CGFloat)height;

@end

@interface BonusDisacountCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableview;

+ (CGFloat)height;

@end
