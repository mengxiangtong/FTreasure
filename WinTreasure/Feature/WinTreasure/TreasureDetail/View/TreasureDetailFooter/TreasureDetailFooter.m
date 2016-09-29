//
//  TreasureDetailFooter.m
//  WinTreasure
//
//  Created by Apple on 16/6/23.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import "TreasureDetailFooter.h"

@interface TreasureDetailFooter ()
{

}
@property (nonatomic, strong) NSArray *titles;

@end

const CGFloat kTreasureDetailFooterPadding = 10.0;
const CGFloat kFooterButtonHeight = 40.0;

@implementation TreasureDetailFooter

- (NSArray *)titles {
    if (!_titles) {
        _titles = @[@"立即夺宝",@"加入清单"];
    }
    return _titles;
}

- (instancetype)initWithType:(TreasureDetailFooterType)type {
    self = [super init];
    if (self) {
        _type = type;
        self.backgroundColor = [UIColor whiteColor];
        self.frame = ({
            CGRect rect = {0,kScreenHeight-60,kScreenWidth,60};
            rect;
        });
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    CAShapeLayer *topLine = [CAShapeLayer layer];
    topLine.origin = CGPointMake(0, 0);
    topLine.size = CGSizeMake(kScreenWidth, CGFloatFromPixel(1));
    topLine.backgroundColor = UIColorHex(0xe5e5e5).CGColor;
    [self.layer addSublayer:topLine];
    
    switch (_type) {
        case TreasureUnPublishedType: {
            CGFloat buttonWidth = (kScreenWidth-kTreasureDetailFooterPadding*(self.titles.count+1))/self.titles.count;
            @weakify(self);
            [self.titles enumerateObjectsUsingBlock:^(id  _Nonnull obj,
                                                      NSUInteger idx,
                                                      BOOL * _Nonnull stop) {
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                button.origin = CGPointMake(kTreasureDetailFooterPadding*(idx+1)+buttonWidth*idx, (self.height-kFooterButtonHeight)/2.0);
                button.tag = idx + 1;
                button.size = CGSizeMake(buttonWidth, kFooterButtonHeight);
                button.layer.cornerRadius = 4.0;
                button.backgroundColor = kDefaultColor;
                [button setTitle:_titles[idx] forState:UIControlStateNormal];
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                if (idx==1) {
                    button.backgroundColor = [UIColor whiteColor];
                    button.layer.borderColor = kDefaultColor.CGColor;
                    button.layer.borderWidth = CGFloatFromPixel(1);
                    button.layer.masksToBounds = YES;
                    [button setTitleColor:kDefaultColor forState:UIControlStateNormal];
                }
                [button addTarget:weak_self action:@selector(winTreasure:) forControlEvents:UIControlEventTouchUpInside];
                [weak_self addSubview:button];
            }];
        }
            break;
        case TreasurePublishedType: {
            YYLabel *label = [YYLabel new];
            label.origin = CGPointMake(kTreasureDetailFooterPadding, (self.height-15)/2.0);
            label.size = CGSizeMake(150, 15);
            label.font = SYSTEM_FONT(13);
            label.textColor = UIColorHex(666666);
            label.text = @"新一期正在火热进行...";
            [self addSubview:label];
            [label sizeToFit];
            
            UIButton *goButton = [UIButton buttonWithType:UIButtonTypeCustom];
            goButton.origin = CGPointMake(kScreenWidth-kTreasureDetailFooterPadding-80, (self.height-30)/2.0);
            goButton.size = CGSizeMake(80, 30);
            goButton.titleLabel.font = SYSTEM_FONT(14);
            goButton.layer.cornerRadius = 4.0;
            goButton.layer.masksToBounds = YES;
            goButton.layer.shouldRasterize = YES;
            goButton.layer.rasterizationScale = kScreenScale;
            goButton.backgroundColor = kDefaultColor;
            [goButton addTarget:self action:@selector(cilickGoBtn) forControlEvents:UIControlEventTouchUpInside];
            [goButton setTitle:@"立即前往" forState:UIControlStateNormal];
            [self addSubview:goButton];
        }
            break;
        default:
            break;
    }
}

- (void)winTreasure:(UIButton *)sender {
    if (_delegate&&[_delegate respondsToSelector:@selector(clickMenuButtonWithIndex:)]) {
        [_delegate clickMenuButtonWithIndex:sender.tag];
    }
}

- (void)cilickGoBtn {
    if (_delegate&&[_delegate respondsToSelector:@selector(checkNewTreasre)]) {
        [_delegate checkNewTreasre];
    }
}

@end
