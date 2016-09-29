//
//  TopUpCell.m
//  WinTreasure
//
//  Created by Apple on 16/6/17.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import "TopUpCell.h"

@implementation TopUpCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];

}

+ (instancetype)cellWithTableView:(UITableView *)tableview {
    static NSString *cellID = @"TopUpCell";
    TopUpCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = (TopUpCell *)[[[NSBundle mainBundle] loadNibNamed:@"TopUpCell" owner:self options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
