//
//  PayorderView.m
//  WinTreasure
//
//  Created by Apple on 16/6/21.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import "PayorderView.h"

@interface PayorderView ()
{
    NSInteger minute , second;
}
@property (nonatomic, strong) YYLabel *timeLabel;

@property (nonatomic, strong) YYLabel *sumLabel;

@property (nonatomic, strong) YYLabel *paySumLabel;

@property (nonatomic, strong) YYLabel *orderNumberLabel;

@property (nonatomic, strong) NSTimer *timer;

@end

const CGFloat kPayorderViewPadding = 10.0;

@implementation PayorderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        second = 59;
        minute = 29;
        self.backgroundColor = [UIColor whiteColor];
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    YYLabel *descriptLabel = [YYLabel new];
    descriptLabel.origin = CGPointMake(kPayorderViewPadding, kPayorderViewPadding);
    descriptLabel.size = CGSizeMake(kScreenWidth, 15);
    descriptLabel.font = SYSTEM_FONT(16);
    descriptLabel.textColor = UIColorHex(333333);
    descriptLabel.text = @"订单提交成功，只差最后一步支付就可以啦！";
    [self addSubview:descriptLabel];
    [descriptLabel sizeToFit];
    
    NSString *timeString = @"请您在提交订单后30分00秒内完成支付，否则订单自动取消!";
    _timeLabel = [YYLabel new];
    _timeLabel.origin = CGPointMake(kPayorderViewPadding, descriptLabel.bottom+8);
    _timeLabel.size = CGSizeMake(kScreenWidth-kPayorderViewPadding*2, 15);
    _timeLabel.numberOfLines = 0;
    _timeLabel.font = SYSTEM_FONT(14);
    _timeLabel.textColor = UIColorHex(666666);
    _timeLabel.height = [timeString sizeWithAttributes:@{NSFontAttributeName:SYSTEM_FONT(14)}].height;
    _timeLabel.text = timeString;
    [self addSubview:_timeLabel];
    [_timeLabel sizeToFit];
    
    CAShapeLayer *lineOne = [CAShapeLayer layer];
    lineOne.origin = CGPointMake(kPayorderViewPadding, _timeLabel.bottom+8);
    lineOne.size = CGSizeMake(kScreenWidth-kPayorderViewPadding, CGFloatFromPixel(1));
    lineOne.backgroundColor = UIColorHex(0xe5e5e5).CGColor;
    [self.layer addSublayer:lineOne];
    
    YYLabel *productLabel = [YYLabel new];
    productLabel.origin = CGPointMake(kPayorderViewPadding, lineOne.bottom+kPayorderViewPadding);
    productLabel.size = CGSizeMake(100, 15);
    productLabel.font = SYSTEM_FONT(14);
    productLabel.textColor = UIColorHex(666666);
    productLabel.text = @"商品金额";
    [self addSubview:productLabel];
    [productLabel sizeToFit];
    
    _sumLabel = [YYLabel new];
    _sumLabel.size = CGSizeMake(kScreenWidth-productLabel.right, 15);
    _sumLabel.right = kScreenWidth-15;
    _sumLabel.top = productLabel.top;
    _sumLabel.font = SYSTEM_FONT(14);
    _sumLabel.textColor = kDefaultColor;
    _sumLabel.text = @"10.00元";
    _sumLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:_sumLabel];
    [_sumLabel sizeToFit];
    
    CAShapeLayer *lineTwo = [CAShapeLayer layer];
    lineTwo.origin = CGPointMake(kPayorderViewPadding, _sumLabel.bottom+8);
    lineTwo.size = CGSizeMake(kScreenWidth-kPayorderViewPadding, CGFloatFromPixel(1));
    lineTwo.backgroundColor = UIColorHex(0xe5e5e5).CGColor;
    [self.layer addSublayer:lineTwo];

    UIView *contentView = [[UIView alloc]initWithFrame:({
        CGRect rect = {0, lineTwo.bottom, kScreenWidth, 60};
        rect;
    })];
    contentView.backgroundColor = UIColorHex(0xF6F6F6);
    [self addSubview:contentView];
    
    CAShapeLayer *lineThree = [CAShapeLayer layer];
    lineThree.origin = CGPointMake(kPayorderViewPadding, contentView.height-CGFloatFromPixel(1));
    lineThree.size = CGSizeMake(kScreenWidth-kPayorderViewPadding, CGFloatFromPixel(1));
    lineThree.backgroundColor = UIColorHex(0xe5e5e5).CGColor;
    [contentView.layer addSublayer:lineThree];
    
    _orderNumberLabel = [YYLabel new];
    _orderNumberLabel.origin = CGPointMake(kPayorderViewPadding, (contentView.height-15)/2.0);
    _orderNumberLabel.size = CGSizeMake(kScreenWidth-kPayorderViewPadding, 15);
    _orderNumberLabel.font = SYSTEM_FONT(14);
    _orderNumberLabel.textColor = UIColorHex(999999);
    _orderNumberLabel.text = @"订单号：2924592835923";
    [contentView addSubview:_orderNumberLabel];
    
    YYLabel *paywayLabel = [YYLabel new];
    paywayLabel.origin = CGPointMake(kPayorderViewPadding, contentView.bottom+kPayorderViewPadding);
    paywayLabel.size = CGSizeMake(100, 15);
    paywayLabel.font = SYSTEM_FONT(14);
    paywayLabel.textColor = UIColorHex(666666);
    paywayLabel.text = @"其他支付方式";
    [self addSubview:paywayLabel];
    [productLabel sizeToFit];
    
    _paySumLabel = [YYLabel new];
    _paySumLabel.size = CGSizeMake(kScreenWidth-paywayLabel.right, 15);
    _paySumLabel.right = kScreenWidth-15;
    _paySumLabel.top = paywayLabel.top;
    _paySumLabel.font = SYSTEM_FONT(14);
    _paySumLabel.textColor = kDefaultColor;
    _paySumLabel.text = @"10.00元";
    _paySumLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:_paySumLabel];
    [_paySumLabel sizeToFit];
    
    CAShapeLayer *lineFour = [CAShapeLayer layer];
    lineFour.origin = CGPointMake(kPayorderViewPadding, paywayLabel.bottom+kPayorderViewPadding);
    lineFour.size = CGSizeMake(kScreenWidth-kPayorderViewPadding, CGFloatFromPixel(1));
    lineFour.backgroundColor = UIColorHex(0xe5e5e5).CGColor;
    [self.layer addSublayer:lineFour];
    
    self.height = lineFour.bottom;
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(count) userInfo:nil repeats:YES];
}

- (void)count {
    second --;
    if (minute==0&&second==0) {
        _timeLabel.text = @"已超出支付时间，请重新提交订单!";
        [_timer invalidate];
        _timer = nil;
        return;
    }
    if (second==0) {
        second = 59;
        minute -= 1;
    }

    NSString *timeString = [NSString stringWithFormat:@"请您在提交订单后%@分%@秒内完成支付，否则订单自动取消!",@(minute),@(second)];
    _timeLabel.text = timeString;

}

- (void)setOrderNumber:(NSString *)orderNumber {
    _orderNumber = orderNumber;
    _orderNumberLabel.text = [NSString stringWithFormat:@"订单号：%@",_orderNumber];
}

- (void)setOrderSum:(NSString *)orderSum {
    _orderSum = orderSum;
    _paySumLabel.text = _orderSum;
    _sumLabel.text = _orderSum;
}

- (void)dealloc {
    NSLog(@"%s",__func__);
}

@end




































