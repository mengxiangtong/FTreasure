//
//  TreasureRecordCell.m
//  WinTreasure
//
//  Created by Apple on 16/6/2.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import "TreasureRecordCell.h"
#import "TreasureRecordModel.h"



@implementation TreasureRecordCell

+ (instancetype)cellWithTableView:(UITableView *)tableview {
    static NSString *cellID = @"TreasureRecordCell";
    TreasureRecordCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    if(!cell) {
        cell = [[TreasureRecordCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = UIColorHex(0xe5e5e5);
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _containerView = [ContainerView new];
        _containerView.origin = CGPointMake(0, 0);
        _containerView.size = CGSizeMake(kScreenWidth, 1);
        _containerView.cell = self;
        _containerView.userInteractionEnabled = YES;
        [self.contentView addSubview:_containerView];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)setLayout:(TreasureRecordLayout *)layout {
    self.height = layout.height;
    self.contentView.height = layout.height;
    _containerView.top = kProductNameLabelPadding;
    _containerView.layout = layout;
}


@end

@implementation ContainerView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _productView = [[ProductView alloc]initWithFrame:({
            CGRect rect = {0,0,kScreenWidth,kProductViewHeight};
            rect;
        })];
        [self addSubview:_productView];
        [_productView.detailButton addTarget:self
                                      action:@selector(checkDetails:)
                            forControlEvents:UIControlEventTouchUpInside];
        
        _descriptionView = [DescriptionView new];
        _descriptionView.origin = CGPointMake(0, _productView.bottom+1);
        _descriptionView.size = CGSizeMake(kScreenWidth, 1);
        [self addSubview:_descriptionView];

    }
    return self;
}

- (void)setType:(DescriptionViewType)type {
    _type = type;
}

- (void)checkDetails:(UIButton *)sender {
    if (self.cell.checkDetails) {
        self.cell.checkDetails(self.cell.indexPath);
    }
}


- (void)purchase {
    if (self.cell.purchaseBlock) {
        self.cell.purchaseBlock(self.cell.indexPath);
    }
}

- (void)setLayout:(TreasureRecordLayout *)layout {
    _layout = layout;
    self.height = layout.containerHeight;
    [_productView setLayout:_layout];
    _descriptionView.top = _productView.bottom;
    [_descriptionView setLayout:_layout];
    [_descriptionView.buyButton addTarget:self
                                   action:@selector(purchase)
                         forControlEvents:UIControlEventTouchUpInside];
}

@end

@implementation ProductView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self _init];
    }
    return self;
}

- (void)_init {
    _productImgView = [UIImageView new];
    _productImgView.origin = CGPointMake(kProductImgViewPadding, kProductImgViewPadding);
    _productImgView.size = CGSizeMake(kProductImgViewWidth, kProductImgViewWidth);
    _productImgView.contentMode = UIViewContentModeScaleAspectFill;
    _productImgView.clipsToBounds = YES;
    _productImgView.backgroundColor = UIColorHex(0xeeeeee);
    [self addSubview:_productImgView];
    
    _productNameLabel = [YYLabel new];
    _productNameLabel.origin = CGPointMake(_productImgView.right+kProductNameLabelPadding, kProductImgViewPadding+5);
    _productNameLabel.size = CGSizeMake(kScreenWidth-(_productImgView.right+kProductNameLabelPadding)-kProductNameLabelPadding, 16);
    _productNameLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    [self addSubview:_productNameLabel];
    
    _periodNoLabel = [YYLabel new];
    _periodNoLabel.origin = CGPointMake(_productNameLabel.left, _productNameLabel.bottom+kProductNameLabelPadding);
    _periodNoLabel.size = CGSizeMake(_productNameLabel.width, 16);
    [self addSubview:_periodNoLabel];

    _detailButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _detailButton.origin = CGPointMake(kScreenWidth-kDetailButtonWidth-kProductNameLabelPadding, _periodNoLabel.bottom+kProductNameLabelPadding);
    _detailButton.size = CGSizeMake(kDetailButtonWidth, 30);
    _detailButton.titleLabel.font = SYSTEM_FONT(13);
    [_detailButton setTitle:@"查看详情" forState:UIControlStateNormal];
    [self addSubview:_detailButton];
    
    _participateLabel = [YYLabel new];
    _participateLabel.origin = CGPointMake(_productNameLabel.left, _periodNoLabel.bottom+kProductNameLabelPadding);
    _participateLabel.size = CGSizeMake(_detailButton.left-_productNameLabel.left-kProductNameLabelPadding*2, 16);
    [self addSubview:_participateLabel];

}

- (void)layoutSubviews {
    [super layoutSubviews];
    _detailButton.centerY = _participateLabel.centerY;
}

- (void)setLayout:(TreasureRecordLayout *)layout {
    self.height = layout.productViewHeight;
    CGFloat top = kProductImgViewPadding;
    _productImgView.top = top;
    [_productImgView setImageWithURL:[NSURL URLWithString:layout.model.productImgUrl] options:YYWebImageOptionShowNetworkActivity];
    
    _productNameLabel.top = top;
    _productNameLabel.height = layout.nameHeight;
    _productNameLabel.textLayout = layout.nameLayout;

    top += layout.nameHeight + kProductNameLabelPadding;
    _periodNoLabel.top = top;
    _periodNoLabel.height = layout.periodNumberHeight;
    _periodNoLabel.textLayout = layout.periodNumberLayout;
    
    top += layout.periodNumberHeight + kProductNameLabelPadding;
    _participateLabel.top = top;
    _participateLabel.height = layout.participateHeight;
    _participateLabel.textLayout = layout.participateLayout;
    
    _detailButton.centerY = _participateLabel.centerY;
    
    CAShapeLayer *line = [CAShapeLayer layer];
    line.origin = CGPointMake(kProductImgViewPadding, self.height-CGFloatFromPixel(1));
    line.size = CGSizeMake(kScreenWidth-kProductImgViewPadding, CGFloatFromPixel(1));
    line.backgroundColor = UIColorHex(0xeeeeee).CGColor;
    [self.layer addSublayer:line];
    
}

@end

@implementation DescriptionView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) { 
    }
    return self;
}

- (void)setType:(DescriptionViewType)type {
    [self removeAllSubviews];
    _buyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _buyButton.origin = CGPointMake(kScreenWidth-kProductImgViewPadding-kDescriptionBuyButtonWidth, (kDescriptionViewHeight-kDescriptionBuyButtonHeight)/2.0);
    _buyButton.size = CGSizeMake(kDescriptionBuyButtonWidth, kDescriptionBuyButtonHeight);
    _buyButton.titleLabel.font = SYSTEM_FONT(13);
    _buyButton.layer.cornerRadius = 4.0;
    _buyButton.layer.borderColor = kDefaultColor.CGColor;
    _buyButton.layer.borderWidth = CGFloatFromPixel(0.6);
    _buyButton.layer.masksToBounds = YES;
    _buyButton.layer.shouldRasterize = YES;
    _buyButton.layer.rasterizationScale = kScreenScale;
    _type = type;
    switch (_type) {
        case DescriptionViewTypeUnPublished: {
            [_buyButton setTitleColor:kDefaultColor forState:UIControlStateNormal];
            [_buyButton setTitle:@"购买" forState:UIControlStateNormal];
            [self addSubview:_buyButton];
            
            _timeImageView = [UIImageView new];
            _timeImageView.size = CGSizeMake(12, 12);
            _timeImageView.origin = CGPointMake(kProductImgViewPadding, (self.height-12)/2.0);
            _timeImageView.image = IMAGE_NAMED(@"list_publish");
            [self addSubview:_timeImageView];
            
            _winnerLabel = [YYLabel new];
            _winnerLabel.left = _timeImageView.right+2;
            _winnerLabel.centerY = _buyButton.centerY;
            _winnerLabel.size = CGSizeMake(_buyButton.left-kProductImgViewPadding-(_timeImageView.right+2), 15);
            _winnerLabel.textColor = kDefaultColor;
            _winnerLabel.font = SYSTEM_FONT(13);
            _winnerLabel.text = @"即将揭晓 正在计算，请稍后...";
            [_winnerLabel sizeToFit];
            _winnerLabel.centerY = _timeImageView.centerY;
            [self addSubview:_winnerLabel];
        }
            break;
        case DescriptionViewTypePublished: {
            [_buyButton setTitleColor:kDefaultColor forState:UIControlStateNormal];
            [_buyButton setTitle:@"再次购买" forState:UIControlStateNormal];
            [self addSubview:_buyButton];
            
            NSString *winner = [NSString stringWithFormat:@"获奖者：%@",_layout.model.winner];
            NSMutableAttributedString *attrWinner = [[NSMutableAttributedString alloc]initWithString:winner];
            attrWinner.font = SYSTEM_FONT(13);
            attrWinner.color = UIColorHex(666666);
            [attrWinner setColor:UIColorHex(0x367ED9) range:NSMakeRange(4, _layout.model.winner.length)];
            _winnerLabel = [YYLabel new];
            _winnerLabel.left = kProductNameLabelPadding;
            _winnerLabel.centerY = _buyButton.centerY;
            _winnerLabel.size = CGSizeMake(attrWinner.size.width, 15);
            _winnerLabel.centerY = _buyButton.centerY;
            _winnerLabel.attributedText = attrWinner;
            [self addSubview:_winnerLabel];
            
            NSString *totalNeed = [NSString stringWithFormat:@"%@人次",_layout.model.winnerParticiTimes];
            NSMutableAttributedString *attrTotalNeed = [[NSMutableAttributedString alloc]initWithString:totalNeed];
            attrTotalNeed.color = UIColorHex(666666);
            attrTotalNeed.font = SYSTEM_FONT(13);
            [attrTotalNeed setColor:kDefaultColor range:NSMakeRange(0, _layout.model.winnerParticiTimes.length)];
            _totalLabel = [YYLabel new];
            _totalLabel.textAlignment = NSTextAlignmentRight;
            _totalLabel.size = CGSizeMake(attrTotalNeed.size.width, 15);
            _totalLabel.right = _buyButton.left - kProductNameLabelPadding;
            _totalLabel.centerY = _buyButton.centerY;
            _totalLabel.attributedText = attrTotalNeed;
            [self addSubview:_totalLabel];
        }
            break;
        case DescriptionViewTypeNotFull: {
            _buyButton.backgroundColor = kDefaultColor;
            [_buyButton setTitle:@"追加" forState:UIControlStateNormal];
            [self addSubview:_buyButton];
            
            _totalLabel = [YYLabel new];
            _totalLabel.origin = CGPointMake(kProductImgViewPadding, 10);
            _totalLabel.size = CGSizeMake(_buyButton.left-kProductImgViewPadding*2, 14);
            _totalLabel.font = SYSTEM_FONT(13);
            _totalLabel.textColor = UIColorHex(666666);
            _totalLabel.text = [NSString stringWithFormat:@"总需%@人次",_layout.model.totalAmount];
            [_totalLabel sizeToFit];
            [self addSubview:_totalLabel];
            
            _progressView = [[TSProgressView alloc]initWithFrame:({
                CGRect rect = {kProductImgViewPadding,_totalLabel.bottom+5,_buyButton.left-kProductImgViewPadding*2,10};
                rect;
            })];
            _progressView.progress = _layout.model.progress.integerValue;
            [self addSubview:_progressView];
            
            _leftLabel = [YYLabel new];
            _leftLabel.size = CGSizeMake(_buyButton.left-kProductImgViewPadding*2, 14);
            _leftLabel.top = _totalLabel.top;
            _leftLabel.right = _progressView.right;
            _leftLabel.textAlignment = NSTextAlignmentRight;
            _leftLabel.font = SYSTEM_FONT(13);
            _leftLabel.textColor = UIColorHex(666666);
            _leftLabel.text = [NSString stringWithFormat:@"剩余 %@",_layout.model.leftAmount];
            [_leftLabel sizeToFit];
            [self addSubview:_leftLabel];
        }
            break;
        default:
            break;
    }
}

- (void)setLayout:(TreasureRecordLayout *)layout {
    _layout = layout;
    self.height = _layout.descriptionHeight;
    self.type = _layout.model.type;
}

@end
