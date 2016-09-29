//
//  DiscoveryCell.m
//  WinTreasure
//
//  Created by Apple on 16/6/1.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import "DiscoveryCell.h"

#define kDiscoveryImageViewMargin 8
#define kDiscoveryImageViewHeight 50
@implementation DiscoveryCell

+ (instancetype)cellWithTableView:(UITableView *)tableview {
    static NSString *cellID = @"DiscoveryCell";
    DiscoveryCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    if(cell == nil) {
        cell = [[DiscoveryCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
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
    [self setup];
    return self;

}

- (void)setup {
    _arrowImgView = [UIImageView new];
    _arrowImgView.origin = CGPointMake(kScreenWidth-29, 29);
    _arrowImgView.size = CGSizeMake(8, 14);
    _arrowImgView.image = [UIImage imageNamed:@"right_Arrow"];
    [self.contentView addSubview:_arrowImgView];
    
    _discoveryImgView = [UIImageView new];
    _discoveryImgView.origin = CGPointMake(kDiscoveryImageViewMargin, kDiscoveryImageViewMargin);
    _discoveryImgView.size = CGSizeMake(kDiscoveryImageViewHeight, kDiscoveryImageViewHeight);
    _discoveryImgView.backgroundColor = UIColorHex(0xeeeeee);
    _discoveryImgView.layer.cornerRadius = _discoveryImgView.height / 2.0;
    _discoveryImgView.layer.shouldRasterize = YES;
    _discoveryImgView.layer.masksToBounds = YES;
    _discoveryImgView.layer.rasterizationScale = kScreenScale;
    _discoveryImgView.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:_discoveryImgView];
    
    _titleLabel = [YYLabel new];
    _titleLabel.font = SYSTEM_FONT(14);
    _titleLabel.origin = CGPointMake(_discoveryImgView.right+20, 15);
    _titleLabel.size = CGSizeMake(_arrowImgView.left-10-_discoveryImgView.right-20, 14);
    [self.contentView addSubview:_titleLabel];
    
    _descriptLabel = [YYLabel new];
    _descriptLabel.font = SYSTEM_FONT(12);
    _descriptLabel.textColor = UIColorHex(999999);
    _descriptLabel.origin = CGPointMake(_discoveryImgView.right+20, _titleLabel.bottom+5);
    _descriptLabel.size = CGSizeMake(_arrowImgView.left-10-_discoveryImgView.right-20, 14);
    [self.contentView addSubview:_descriptLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
