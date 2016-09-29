//
//  BonusHeader.m
//  WinTreasure
//
//  Created by Apple on 16/7/4.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import "DiamondHeader.h"

@interface DiamondHeader ()

@property (nonatomic, strong) YYLabel *diamondLabel;

@end

@implementation DiamondHeader

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.size = CGSizeMake(kScreenWidth, kScreenWidth*235/750.0);
        UIImageView *bgImgView = [[UIImageView alloc]initWithFrame:self.bounds];
        bgImgView.image = IMAGE_NAMED(@"bonusBg");
        bgImgView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:bgImgView];
        
        YYLabel *label = [YYLabel new];
        label.origin = CGPointMake(0, 15);
        label.size = CGSizeMake(kScreenWidth, 16);
        label.textColor = [UIColor whiteColor];
        label.font = SYSTEM_FONT(15);
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"我的宝石";
        [self addSubview:label];
        
        UIButton *qaButton = [UIButton buttonWithType:UIButtonTypeCustom];
        qaButton.origin = CGPointMake(kScreenWidth-15-20, 15);
        qaButton.size = CGSizeMake(20, 20);
        [qaButton setImage:IMAGE_NAMED(@"bonusQa") forState:UIControlStateNormal];
        [qaButton addTarget:self action:@selector(bonusQuestion) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:qaButton];
        
        _diamondLabel = [YYLabel new];
        _diamondLabel.origin = CGPointMake(0, label.bottom+10);
        _diamondLabel.size = CGSizeMake(kScreenWidth, 16);
        _diamondLabel.textColor = [UIColor whiteColor];
        _diamondLabel.font = SYSTEM_FONT(15);
        _diamondLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_diamondLabel];
    }
    return self;
}

- (void)setDiamondSum:(NSNumber *)diamondSum {
    _diamondSum = diamondSum;
    _diamondLabel.text = [NSString stringWithFormat:@"%@",_diamondSum];

}

- (void)bonusQuestion {
    if (_ruleBlock) {
        _ruleBlock();
    }
}

@end
