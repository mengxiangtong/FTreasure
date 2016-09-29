//
//  LuckyRecordCell.m
//  WinTreasure
//
//  Created by Apple on 16/6/27.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import "LuckyRecordCell.h"

@interface LuckyRecordCell ()


@end

@implementation LuckyRecordCell

+ (instancetype)cellWithTableView:(UITableView *)tableview {
    static NSString *cellID = @"LuckyRecordCell";
    LuckyRecordCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    if(cell == nil) {
        cell = [[LuckyRecordCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
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
    _productImgView = [[UIImageView alloc]initWithFrame:({
        CGRect rect = {kLuckyRecordPaddingLeft,kLuckyRecordMargin,kLuckyRecordImageWidth,kLuckyRecordImageWidth};
        rect;
    })];
    _productImgView.backgroundColor = UIColorHex(0xeeeeee);
    [self.contentView addSubview:_productImgView];
    
    _nameLabel = [YYLabel new];
    _nameLabel.origin = CGPointMake(_productImgView.right+kLuckyRecordPaddingRight, _productImgView.top);
    _nameLabel.size = CGSizeMake(kLuckyRecordNameWidth, 16);
    _nameLabel.numberOfLines = 2;
    _nameLabel.displaysAsynchronously = YES;
    [self.contentView addSubview:_nameLabel];
    
    _periodNumberLabel = [YYLabel new];
    _periodNumberLabel.origin = CGPointMake(_nameLabel.left, _nameLabel.bottom+kLuckyRecordPaddingRight);
    _periodNumberLabel.size = CGSizeMake(kLuckyRecordNameWidth, 16);
    _periodNumberLabel.numberOfLines = 1;
    _periodNumberLabel.displaysAsynchronously = YES;
    [self.contentView addSubview:_periodNumberLabel];
    
    _totalLabel = [YYLabel new];
    _totalLabel.origin = CGPointMake(_nameLabel.left, _periodNumberLabel.bottom+kLuckyRecordPaddingRight);
    _totalLabel.size = CGSizeMake(kLuckyRecordNameWidth, 16);
    _totalLabel.numberOfLines = 1;
    _totalLabel.displaysAsynchronously = YES;
    [self.contentView addSubview:_totalLabel];
    
    _luckyNumberLabel = [YYLabel new];
    _luckyNumberLabel.origin = CGPointMake(_nameLabel.left, _totalLabel.bottom+kLuckyRecordLabelMargin);
    _luckyNumberLabel.size = CGSizeMake(kLuckyRecordNameWidth, 16);
    _luckyNumberLabel.numberOfLines = 1;
    _luckyNumberLabel.displaysAsynchronously = YES;
    [self.contentView addSubview:_luckyNumberLabel];
    
    _participateLabel = [YYLabel new];
    _participateLabel.origin = CGPointMake(_nameLabel.left, _luckyNumberLabel.bottom+kLuckyRecordLabelMargin);
    _participateLabel.size = CGSizeMake(kLuckyRecordNameWidth, 16);
    _participateLabel.numberOfLines = 1;
    _participateLabel.displaysAsynchronously = YES;
    [self.contentView addSubview:_participateLabel];
    
    _timeLabel = [YYLabel new];
    _timeLabel.origin = CGPointMake(_nameLabel.left, _participateLabel.bottom+kLuckyRecordLabelMargin);
    _timeLabel.size = CGSizeMake(kLuckyRecordNameWidth, 16);
    _timeLabel.numberOfLines = 1;
    _timeLabel.displaysAsynchronously = YES;
    [self.contentView addSubview:_timeLabel];
    
    _prizeView = [PrizeView new];
    _prizeView.origin = CGPointMake(0, _timeLabel.bottom+kLuckyRecordPaddingLeft);
    _prizeView.size = CGSizeMake(kScreenWidth, kLuckyRecordPrizeViewHeight);
    _prizeView.cell = self;
    [self.contentView addSubview:_prizeView];
    
}

- (void)setLayout:(LuckyRecordLayout *)layout {
    _layout = layout;
    self.height = _layout.height;
    self.contentView.height = _layout.height;
    CGFloat top = kLuckyRecordMargin;
    [_productImgView setImageWithURL:[NSURL URLWithString:_layout.model.productImgUrl] options:YYWebImageOptionShowNetworkActivity];
    _productImgView.top = top;
    
    _nameLabel.top = top;
    _nameLabel.height = _layout.nameHeight;
    _nameLabel.textLayout = _layout.nameLayout;
    
    top += _layout.nameHeight+kLuckyRecordMargin;
    _periodNumberLabel.top = top;
    _periodNumberLabel.height = _layout.periodHeight;
    _periodNumberLabel.textLayout = _layout.periodLayout;
    
    top += _layout.periodHeight + kLuckyRecordPaddingRight;
    _totalLabel.top = top;
    _totalLabel.height = _layout.amountHeight;
    _totalLabel.textLayout = _layout.amountLayout;
    
    top += _layout.amountHeight + kLuckyRecordPaddingRight;
    _luckyNumberLabel.top = top;
    _luckyNumberLabel.height = _layout.luckyNumberHeight;
    _luckyNumberLabel.textLayout = _layout.luckyNumberLayout;
    
    top += _layout.luckyNumberHeight + kLuckyRecordPaddingRight;
    _participateLabel.top = top;
    _participateLabel.height = _layout.partInHeight;
    _participateLabel.textLayout = _layout.partInLayout;
    
    top += _layout.partInHeight + kLuckyRecordPaddingRight;
    _timeLabel.top = top;
    _timeLabel.height = _layout.timeHeight;
    _timeLabel.textLayout = _layout.timeLayout;
    
    top += _layout.timeHeight + kLuckyRecordMargin;
    _prizeView.top = top;
    _prizeView.height = _layout.prizeViewHeight;
    _prizeView.type = PrizeViewTypeUnSigned;
    
    CAShapeLayer *bottomLayer = [CAShapeLayer layer];
    bottomLayer.origin = CGPointMake(0, _prizeView.bottom);
    bottomLayer.size = CGSizeMake(kScreenWidth, kLuckyRecordPaddingRight);
    bottomLayer.backgroundColor = UIColorHex(0xE9E5E1).CGColor;
    [self.contentView.layer addSublayer:bottomLayer];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

@implementation PrizeView

- (instancetype)initWithFrame:(CGRect)frame type:(PrizeViewType)type {
    self = [super init];
    if (self) {
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (void)commontInit {
    switch (_type) {
        case PrizeViewTypeSigned: {
            _logisticsButton = [UIButton buttonWithType:UIButtonTypeCustom];
            _logisticsButton.origin = CGPointMake(kScreenWidth-kLuckyRecordPaddingLeft-kLuckyRecordButtonWidth, (kLuckyRecordPrizeViewHeight-kLuckyRecordButtonHeight)/2.0);
            _logisticsButton.size = CGSizeMake(kLuckyRecordButtonWidth, kLuckyRecordButtonHeight);
            _logisticsButton.backgroundColor = kDefaultColor;
            _logisticsButton.layer.cornerRadius = 4.0;
            _logisticsButton.titleLabel.font = SYSTEM_FONT(13);
            _logisticsButton.layer.borderColor = UIColorHex(0xeeeeee).CGColor;
            _logisticsButton.layer.borderWidth = CGFloatFromPixel(1);
            [_logisticsButton setTitle:@"查看物流" forState:UIControlStateNormal];
            [_logisticsButton addTarget:self action:@selector(checkLogistics) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:_logisticsButton];
            
            _shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
            _shareButton.origin = CGPointMake(_logisticsButton.left-kLuckyRecordPaddingLeft-kLuckyRecordButtonWidth, (kLuckyRecordPrizeViewHeight-kLuckyRecordButtonHeight)/2.0);
            _shareButton.size = CGSizeMake(kLuckyRecordButtonWidth, kLuckyRecordButtonHeight);
            _shareButton.layer.cornerRadius = 4.0;
            _shareButton.titleLabel.font = SYSTEM_FONT(13);
            _shareButton.layer.borderColor = kDefaultColor.CGColor;
            _shareButton.layer.borderWidth = CGFloatFromPixel(1);
            [_shareButton setTitleColor:kDefaultColor forState:UIControlStateNormal];
            [_shareButton setTitle:@"晒单" forState:UIControlStateNormal];
            [_shareButton addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:_shareButton];
            
            _signedLabel = [YYLabel new];
            _signedLabel.origin = CGPointMake(kLuckyRecordPaddingLeft, (kLuckyRecordPrizeViewHeight-16)/2.0);
            _signedLabel.size = CGSizeMake(100, 16);
            _signedLabel.font = SYSTEM_FONT(15);
            _signedLabel.textColor = kDefaultColor;
            _signedLabel.text = @"已登记领奖";
            [self addSubview:_signedLabel];
            [_signedLabel sizeToFit];
        }
            break;
        case PrizeViewTypeUnSigned: {
            _signButton = [UIButton buttonWithType:UIButtonTypeCustom];
            _signButton.origin = CGPointMake(kScreenWidth-kLuckyRecordPaddingLeft-kLuckyRecordButtonWidth, (kLuckyRecordPrizeViewHeight-kLuckyRecordButtonHeight)/2.0);
            _signButton.size = CGSizeMake(kLuckyRecordButtonWidth, kLuckyRecordButtonHeight);
            _signButton.backgroundColor = kDefaultColor;
            _signButton.layer.cornerRadius = 4.0;
            _signButton.titleLabel.font = SYSTEM_FONT(13);
            [_signButton setTitle:@"登记领奖" forState:UIControlStateNormal];
            [_signButton addTarget:self action:@selector(getPrize) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:_signButton];
        }
            break;
        default:
            break;
    }
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.frame = CGRectMake(kLuckyRecordPaddingLeft, 0, kScreenWidth-kLuckyRecordPaddingLeft, CGFloatFromPixel(1));
    layer.backgroundColor = UIColorHex(0xeeeeee).CGColor;
    [self.layer addSublayer:layer];
}

- (void)setType:(PrizeViewType)type {
    _type = type;
    [self commontInit];
}

- (void)checkLogistics {
    if (_cell.delegate && [_cell.delegate respondsToSelector:@selector(logisticButtonClickedCell:)]) {
        [_cell.delegate logisticButtonClickedCell:_cell];
    }
}

- (void)share {
    if (_cell.delegate && [_cell.delegate respondsToSelector:@selector(shareButtonClickedCell:)]) {
        [_cell.delegate shareButtonClickedCell:_cell];
    }
}

- (void)getPrize {
    if (_cell.delegate && [_cell.delegate respondsToSelector:@selector(signButtonClickedCell:)]) {
        [_cell.delegate signButtonClickedCell:_cell];
    }
}

@end
