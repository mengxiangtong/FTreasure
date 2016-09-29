//
//  TopupCell.m
//  WinTreasure
//
//  Created by Apple on 16/6/17.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import "TopupRecordCell.h"

@implementation TopupRecordCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];

}

+ (instancetype)cellWithTableView:(UITableView *)tableview {
    static NSString *cellID = @"TopupRecordCell";
    TopupRecordCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = (TopupRecordCell *)[[[NSBundle mainBundle] loadNibNamed:@"TopupRecordCell" owner:self options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)setModel:(TopupRecordModel *)model {
    _model = model;
    _topupWayLabel.text = _model.topupWay;
    _amoutLabel.text = _model.topupAmount;
    _timeLabel.text = _model.topupTime;
    _ifTopupLabel.text = _model.isTopup ? @"已支付" : @"未支付";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
