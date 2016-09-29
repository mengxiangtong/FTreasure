//
//  TSMenu.m
//  WinTreasure
//
//  Created by Apple on 16/6/2.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import "TSMenu.h"

const CGFloat kTSMenuHeight = 45.0;
const CGFloat kTSMenuDefaultHeight = 44.0;
const CGFloat kTSMenuLineHeight = 2.5;
const CGFloat kTSMenuLineSpacing = 20.0;
const CGFloat kAnimationDuration = 0.3;

@interface TSMenu ()
{
    UIButton *_selectedBtn;
}


@end

@implementation TSMenu

- (CAShapeLayer *)bottomLine {
    if (!_bottomLine) {
        _bottomLine = [CAShapeLayer layer];
        _bottomLine.frame = CGRectMake(kTSMenuLineSpacing,
                                       kTSMenuDefaultHeight-kTSMenuLineHeight,
                                       (kScreenWidth-(kTSMenuLineSpacing*2*_data.count))/_data.count,
                                       kTSMenuLineHeight);
        _bottomLine.backgroundColor = kDefaultColor.CGColor;
    }
    return _bottomLine;
}

- (instancetype)initWithDataArray:(NSArray *)data {
    self = [super init];
    if (self) {
        _data = data;
        self.backgroundColor = [UIColor whiteColor];
        [self configMenu];
    }
    return self;
}

- (void)configMenu {
    [_data enumerateObjectsUsingBlock:^(id  _Nonnull obj,
                                        NSUInteger idx,
                                        BOOL * _Nonnull stop) {
        UIButton *menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        menuBtn.tag = idx+1;
        menuBtn.origin = CGPointMake(idx*kScreenWidth/_data.count, 0);
        menuBtn.size = CGSizeMake(kScreenWidth/_data.count, kTSMenuDefaultHeight);
        [menuBtn setTitle:_data[idx] forState:UIControlStateNormal];
        [menuBtn setTitleColor:UIColorHex(666666) forState:UIControlStateNormal];
        [menuBtn setTitleColor:kDefaultColor forState:UIControlStateSelected];
        [menuBtn addTarget:self action:@selector(selectMenu:) forControlEvents:UIControlEventTouchUpInside];
        menuBtn.titleLabel.font = SYSTEM_FONT(14);
        [self addSubview:menuBtn];
        if (idx == 0) {
            menuBtn.selected = YES;
            menuBtn.userInteractionEnabled = NO;
            _selectedBtn = menuBtn;
        }
        
    }];
    [self.layer addSublayer:self.bottomLine];
}

- (void)selectMenu:(UIButton *)sender {
    [self refreshButtonState:sender];
    CGFloat lineWidth = _bottomLine.width;
    CGFloat x = (sender.tag-1) * (kTSMenuLineSpacing + lineWidth) + (sender.tag) * kTSMenuLineSpacing;
    [self scrollBottomLine:x];
    if (_menuBlock) {
        _menuBlock(sender);
    }
}

- (void)refreshButtonState:(UIButton *)sender {
    _selectedBtn.selected = NO;
    _selectedBtn.userInteractionEnabled = YES;
    sender.selected = !sender.selected;
    sender.userInteractionEnabled = NO;
    _selectedBtn = sender;
}

- (void)scrollBottomLine:(CGFloat)x {
    [UIView animateWithDuration:kAnimationDuration animations:^{
        CGRect rect = _bottomLine.frame;
        rect.origin.x = x;
        _bottomLine.frame = rect;
    }];
}

- (void)setSelectIndex:(NSInteger)selectIndex {
    _selectIndex = selectIndex;
    UIButton *sender = [self viewWithTag:_selectIndex+1];
    [self refreshButtonState:sender];
    CGFloat lineWidth = _bottomLine.width;
    CGFloat x = (sender.tag-1) * (kTSMenuLineSpacing + lineWidth) + (sender.tag) * kTSMenuLineSpacing;
    [self scrollBottomLine:x];

}

@end
