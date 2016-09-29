//
//  SettingCell.m
//  WinTreasure
//
//  Created by Apple on 16/6/24.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import "SettingCell.h"

@implementation SettingCell

- (void)awakeFromNib {
    // Initialization code
}
+ (instancetype)cellWithTableView:(UITableView *)tableview {
    static NSString *cellID = @"SettingCell";
    SettingCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    if(cell == nil) {
        cell = [[SettingCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    for (UIView *view in self.subviews) {
        if([view isKindOfClass:[UIScrollView class]]) {
            ((UIScrollView *)view).delaysContentTouches = NO;
            // Remove touch delay for iOS 7
            break;
        }
    }
    self.textLabel.textColor = UIColorHex(333333);
    self.textLabel.font = SYSTEM_FONT(15);
    self.exclusiveTouch = YES;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentView.backgroundColor = [UIColor whiteColor];

    return self;
    
}

- (void)setIndexpath:(NSIndexPath *)indexpath {
    _indexpath = indexpath;
    if (_indexpath.section==0 || (_indexpath.section==1&&_indexpath.row==0)) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else if (_indexpath.section==1&&_indexpath.row==1) {
        self.detailTextLabel.font = SYSTEM_FONT(14);
        self.detailTextLabel.textColor = kDefaultColor;
        self.detailTextLabel.text = @"v1.0.0";
    } else if (indexpath.section==2) {
        self.detailTextLabel.textColor = UIColorHex(666666);
        self.detailTextLabel.font = SYSTEM_FONT(14);
    } if (indexpath.section==3) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, kScreenWidth, self.height);
        button.backgroundColor = [UIColor whiteColor];
        button.titleLabel.font = SYSTEM_FONT(15);
        [button setTitleColor:UIColorHex(333333) forState:UIControlStateNormal];
        [button setTitleColor:[[UIColor whiteColor] colorWithAlphaComponent:0.6] forState:UIControlStateHighlighted];
        [button setTitle:@"退出帐号" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(logOut) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:button];
    }
}

- (void)logOut {
    if (_logout) {
        _logout();
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
