//
//  DreamListView.m
//  WinTreasure
//
//  Created by Apple on 16/6/21.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import "DreamListView.h"

@interface DreamListView ()

@property (nonatomic, strong) NSArray *titles;

@end

@implementation DreamListView

- (NSArray *)titles {
    if (!_titles) {
        _titles = @[@"发送付款链接给朋友凑单",@"凑单到目标值，心愿达成",@"收到一元夺宝寄出的礼物"];
    }
    return _titles;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.size = CGSizeMake(kScreenWidth, kScreenHeight);
        [self setup];
    }
    return self;
}

- (void)setup {
    YYLabel *titleLabel = [YYLabel new];
    titleLabel.origin = CGPointMake(0, 0);
    titleLabel.size = CGSizeMake(kScreenWidth, 20);
    titleLabel.font = SYSTEM_FONT(20);
    titleLabel.textColor = UIColorHex(333333);
    titleLabel.text = @"设置心愿单，让亲朋好友为您凑单!";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:titleLabel];
    
    YYLabel *labelOne = [YYLabel new];
    labelOne.origin = CGPointMake(70, titleLabel.bottom+30);
    labelOne.size = CGSizeMake(25, 25);
    labelOne.text = @"1";
    labelOne.font = SYSTEM_FONT(16);
    labelOne.textColor = UIColorHex(0xffffff);
    labelOne.textAlignment = NSTextAlignmentCenter;
    labelOne.layer.cornerRadius = labelOne.height/2.0;
    labelOne.backgroundColor = kDefaultColor;
    [self addSubview:labelOne];
    
    YYLabel *one = [YYLabel new];
    one.origin = CGPointMake(labelOne.right+5, labelOne.top);
    one.size = CGSizeMake(kScreenWidth-labelOne.right+5, 25);
    one.font = SYSTEM_FONT(16);
    one.textColor = UIColorHex(666666);
    one.text = @"选一件幸运的商品";
    [self addSubview:one];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.origin = CGPointMake(one.left+20, one.bottom+30);
    button.size = CGSizeMake(130, 130);
    button.backgroundColor = [UIColor redColor];
    [button setImage:IMAGE_NAMED(@"点击挑选") forState:UIControlStateNormal];
    [button addTarget:self action:@selector(chooseList) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    
    [self.titles enumerateObjectsUsingBlock:^(id  _Nonnull obj,
                                              NSUInteger idx,
                                              BOOL * _Nonnull stop) {
        YYLabel *sortLabel = [YYLabel new];
        sortLabel.origin = CGPointMake(labelOne.left, button.bottom+30*(idx+1)+25*idx);
        sortLabel.size = CGSizeMake(25, 25);
        sortLabel.text = [NSString stringWithFormat:@"%@",@(idx+2)];
        sortLabel.font = SYSTEM_FONT(16);
        sortLabel.textColor = UIColorHex(0xffffff);
        sortLabel.textAlignment = NSTextAlignmentCenter;
        sortLabel.layer.cornerRadius = sortLabel.height/2.0;
        sortLabel.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:sortLabel];
        
        YYLabel *descrptLabel = [YYLabel new];
        descrptLabel.origin = CGPointMake(sortLabel.right+5, sortLabel.top);
        descrptLabel.size = CGSizeMake(kScreenWidth-sortLabel.right+5, 25);
        descrptLabel.text = _titles[idx];
        descrptLabel.font = SYSTEM_FONT(16);
        descrptLabel.textColor = UIColorHex(666666);
        [self addSubview:descrptLabel];

    }];
    
    CAShapeLayer *line = [CAShapeLayer layer];
    line.origin = CGPointMake(labelOne.left+labelOne.width/2.0, labelOne.top);
    line.size = CGSizeMake(CGFloatFromPixel(1), button.bottom+30*_titles.count);
    line.backgroundColor = UIColorHex(999999).CGColor;
    [self.layer insertSublayer:line atIndex:0];
    
    
}

- (void)chooseList {
    if (_chooseDreamGift) {
        _chooseDreamGift();
    }
}

@end

























