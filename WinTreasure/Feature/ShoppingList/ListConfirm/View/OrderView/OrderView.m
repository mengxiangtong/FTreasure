//
//  OrderView.m
//  WinTreasure
//
//  Created by Apple on 16/6/20.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import "OrderView.h"

@interface OrderView ()

@property (nonatomic, strong) UIButton *submitButton;

@property (nonatomic, strong) YYLabel *amoutLabel;

@end

@implementation OrderView

- (UIButton *)submitButton {
    if (!_submitButton) {
        _submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _submitButton.origin = CGPointMake(kScreenWidth-150-15, (self.height-40)/2.0);
        _submitButton.size = CGSizeMake(150, 40);
        _submitButton.backgroundColor = kDefaultColor;
        _submitButton.layer.cornerRadius = 4.0;
        _submitButton.titleLabel.font = SYSTEM_FONT(15);
        [_submitButton setTitle:@"提交订单" forState:UIControlStateNormal];
        [_submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_submitButton addTarget: self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitButton;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.submitButton];
        _amoutLabel = [YYLabel new];
        _amoutLabel.origin = CGPointMake(15, (self.height-16)/2.0);
        _amoutLabel.size = CGSizeMake(_submitButton.left-15*2, 16);
        _amoutLabel.font = SYSTEM_FONT(15);
        _amoutLabel.textColor = UIColorHex(666666);
        [self addSubview:_amoutLabel];
    }
    return self;
}

- (void)setPayAmout:(NSNumber *)payAmout {
    _payAmout = payAmout;
    _amoutLabel.text = [NSString stringWithFormat:@"实付款：¥%@",payAmout];
    [_amoutLabel sizeToFit];
}

- (void)submit {
    if (_block) {
        _block();
    }
}

+ (CGFloat)height {
    return 60.0;
}

@end
