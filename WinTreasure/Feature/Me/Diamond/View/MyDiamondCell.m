//
//  MyBonusCell.m
//  WinTreasure
//
//  Created by Apple on 16/7/4.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import "MyDiamondCell.h"

@implementation MyDiamondCell

+ (instancetype)cellWithTableView:(UITableView *)tableview {
    static NSString *cellID = @"MyDiamondCell";
    MyDiamondCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = (MyDiamondCell *)[[[NSBundle mainBundle] loadNibNamed:@"MyDiamondCell" owner:self options:nil] lastObject];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    return cell;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)setModel:(MyDiamondModel *)model {
    _model = model;
    _titleLabel.text = _model.title;
    _timeLabel.text = _model.time;
    _diamondLabel.text = _model.bonusAmount;
}

@end
