//
//  BillView.m
//  WinTreasure
//
//  Created by Apple on 16/6/6.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import "BillView.h"

@interface BillView ()

@property (nonatomic, strong) YYLabel *totalLabel;

@property (nonatomic, strong) YYLabel *riskLabel;

@property (nonatomic, strong) UIButton *billButton;

@property (nonatomic, strong) UIButton *deleteButton;

@property (nonatomic, strong) UIButton *selectButton;

@end

const CGFloat kBillButtonWidth = 80.0;
const CGFloat kBillButtonheight = 30.0;

@implementation BillView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        CAShapeLayer *topLine = [CAShapeLayer layer];
        topLine.origin = CGPointMake(0, 0);
        topLine.size = CGSizeMake(kScreenWidth, CGFloatFromPixel(1));
        topLine.backgroundColor = UIColorHex(0xe5e5e5).CGColor;
        [self.layer addSublayer:topLine];
        [self setup];
    }
    return self;
}

- (void)setup {
    _selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _selectButton.origin = CGPointMake(15, (self.height-40)/2.0);
    _selectButton.size = CGSizeMake(150, 40);
    _selectButton.titleLabel.font = SYSTEM_FONT(14);
    _selectButton.titleLabel.numberOfLines = 0;
    _selectButton.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    _selectButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [_selectButton setImage:IMAGE_NAMED(@"未选中") forState:UIControlStateNormal];
    [_selectButton setImage:IMAGE_NAMED(@"选中") forState:UIControlStateSelected];
    [_selectButton setTitle:@"全选\n共选中0件商品" forState:UIControlStateNormal];
    [_selectButton setTitleColor:UIColorHex(666666) forState:UIControlStateNormal];
    [_selectButton setTitleColor:UIColorHex(666666) forState:UIControlStateSelected];
    [_selectButton addTarget:self action:@selector(select:) forControlEvents:UIControlEventTouchUpInside];
    _selectButton.hidden = YES;
    [self addSubview:_selectButton];
    
    _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _deleteButton.origin = CGPointMake(self.width-100-15, (self.height-40)/2.0);
    _deleteButton.size = CGSizeMake(100, 40);
    _deleteButton.layer.cornerRadius = 4.0;
    _deleteButton.layer.borderColor = kDefaultColor.CGColor;
    _deleteButton.layer.borderWidth = CGFloatFromPixel(1);
    _deleteButton.layer.masksToBounds = YES;
    _deleteButton.layer.shouldRasterize = YES;
    _deleteButton.layer.rasterizationScale = kScreenScale;
    _deleteButton.titleLabel.font = SYSTEM_FONT(15);
    _deleteButton.hidden = YES;
    [_deleteButton setTitle:@"删除" forState:UIControlStateNormal];
    [_deleteButton setTitleColor:kDefaultColor forState:UIControlStateNormal];
    [_deleteButton addTarget:self action:@selector(delete) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_deleteButton];
    _selectButton.centerY = _deleteButton.centerY;

    _billButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _billButton.origin = CGPointMake(self.width-kBillButtonWidth-15, (self.height-kBillButtonheight)/2.0);
    _billButton.size = CGSizeMake(kBillButtonWidth, kBillButtonheight);
    _billButton.layer.cornerRadius = 4.0;
    _billButton.layer.masksToBounds = YES;
    _billButton.layer.shouldRasterize = YES;
    _billButton.layer.rasterizationScale = kScreenScale;
    _billButton.backgroundColor = kDefaultColor;
    _billButton.titleLabel.font = SYSTEM_FONT(15);
    [_billButton addTarget:self action:@selector(buy) forControlEvents:UIControlEventTouchUpInside];
    [_billButton setTitle:@"结算" forState:UIControlStateNormal];
    [self addSubview:_billButton];
    
    _totalLabel = [YYLabel new];
    _totalLabel.origin = CGPointMake(15, 10);
    _totalLabel.size = CGSizeMake(self.width-15*2-_billButton.width, 15);
    _totalLabel.font = SYSTEM_FONT(16);
    _totalLabel.textColor = UIColorHex(666666);
    [self addSubview:_totalLabel];
    
    _riskLabel = [YYLabel new];
    _riskLabel.origin = CGPointMake(15, _totalLabel.bottom+5);
    _riskLabel.size = CGSizeMake(self.width-15*2-_billButton.width, 15);
    _riskLabel.text = @"夺宝有风险，参与需谨慎";
    _riskLabel.font = SYSTEM_FONT(14);
    _riskLabel.textColor = UIColorHex(999999);
    [_riskLabel sizeToFit];
    [self addSubview:_riskLabel];
}

- (void)setDeleteStyle {
    _selectButton.selected = NO;
    _riskLabel.hidden = YES;
    _totalLabel.hidden = YES;
    _billButton.hidden = YES;
    _selectButton.hidden = NO;
    _deleteButton.hidden = NO;
}

- (void)setNormalStyle {
    _riskLabel.hidden = NO;
    _totalLabel.hidden = NO;
    _billButton.hidden = NO;
    _deleteButton.hidden = YES;
    _selectButton.hidden = YES;
    [self setAttributeTitle:@"全选\n共选中0件商品" forState:UIControlStateNormal];
}

- (void)setAttributeTitle:(NSString *)text forState:(UIControlState)state{
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc]initWithString:text];
    [_selectButton setAttributedTitle:title forState:state];
}

- (void)setMoneySum:(NSNumber *)money {
    _totalLabel.text = [NSString stringWithFormat:@"共%@件商品,总计：%@元",@([AppDelegate getAppDelegate].value),money];
    _totalLabel.width = [_totalLabel.text sizeWithAttributes:@{NSFontAttributeName :  SYSTEM_FONT(16)}].width;
}

- (void)buy {
    if (_buyBlock) {
        _buyBlock();
    }
}

- (void)delete {
    if (_deleteBlock) {
        _deleteBlock();
    }
}

- (void)select:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.isSelect = sender.selected ? YES : NO;
    if (_selectBlock) {
        _selectBlock(sender);
    }
}

- (void)setSelected:(BOOL)selected {
    _selectButton.selected = selected;
}

+ (CGFloat)getHeight {
    return 60.0;
}

@end
