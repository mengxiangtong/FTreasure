//
//  NoticeSetCell.m
//  WinTreasure
//
//  Created by Apple on 16/6/30.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import "NoticeSetCell.h"

@interface NoticeSetCell ()

@property (nonatomic, strong) UISwitch *msgSwitch;

@end

@implementation NoticeSetCell

+ (instancetype)cellWithTableView:(UITableView *)tableview {
    static NSString *cellID = @"NoticeSetCell";
    NoticeSetCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    if(cell == nil) {
        cell = [[NoticeSetCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
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
    self.exclusiveTouch = YES;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentView.backgroundColor = [UIColor whiteColor];
    if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
        [self setLayoutMargins:UIEdgeInsetsZero];
    }
    self.textLabel.textColor = UIColorHex(333333);
    self.textLabel.font = SYSTEM_FONT(15);
    self.accessoryType = UITableViewCellAccessoryNone;
    _msgSwitch = [[UISwitch alloc]init];
    _msgSwitch.on = YES;
    [_msgSwitch addTarget:self action:@selector(openMsgPush:) forControlEvents:UIControlEventValueChanged];
    self.accessoryView = _msgSwitch;
    return self;
}

- (void)openMsgPush:(UISwitch *)sender {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
