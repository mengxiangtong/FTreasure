//
//  PayResultCell.m
//  WinTreasure
//
//  Created by Apple on 16/6/22.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import "PayResultCell.h"

@implementation PayResultCell

- (void)awakeFromNib {
    // Initialization code
}

+ (instancetype)cellWithTableView:(UITableView *)tableview {
    static NSString *cellID = @"PayResultCell";
    PayResultCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = (PayResultCell *)[[[NSBundle mainBundle] loadNibNamed:@"PayResultCell" owner:self options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(PayResultModel *)model {
    _model = model;
    _nameLabel.text = _model.productName;
    _periodLabel.text = _model.periodNumber;
    _treasureNoLabel.text = _model.treasureNumber;
    _paticipateLabel.text = _model.paticipateNumber;
}

@end
