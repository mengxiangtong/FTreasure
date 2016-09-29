//
//  DetailTreasureRecordCell.m
//  WinTreasure
//
//  Created by Apple on 16/6/15.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import "DetailTreasureRecordCell.h"

@implementation DetailTreasureRecordCell

- (void)awakeFromNib {
    [super awakeFromNib];

    if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
        [self setLayoutMargins:UIEdgeInsetsZero];
    }
}

+ (instancetype)cellWithTableView:(UITableView *)tableview {
    static NSString *cellID = @"DetailTreasureRecordCell";
    DetailTreasureRecordCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = (DetailTreasureRecordCell *)[[[NSBundle mainBundle] loadNibNamed:@"DetailTreasureRecordCell" owner:self options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (IBAction)checkNumber:(UIButton *)sender {
    if (_checkNumber) {
        _checkNumber(_indexPath);
    }
}

- (void)setModel:(DetailTreasureRecordModel *)model {
    _model = model;
    _participateAmountLabel.text = _model.participateAmount;
    _timeLabel.text = _model.time;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
