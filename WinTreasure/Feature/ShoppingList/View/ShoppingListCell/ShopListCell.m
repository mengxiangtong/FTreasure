//
//  ShopListCell.m
//  WinTreasure
//
//  Created by Apple on 16/6/30.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import "ShopListCell.h"

@implementation ShopListCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableview {
    static NSString *cellID = @"ShopListCell";
    ShopListCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = (ShopListCell *)[[[NSBundle mainBundle] loadNibNamed:@"ShopListCell" owner:self options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


@end
