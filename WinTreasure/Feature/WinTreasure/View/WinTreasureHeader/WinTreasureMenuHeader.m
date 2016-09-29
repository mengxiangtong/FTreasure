//
//  WinTreasureMenuHeader.m
//  WinTreasure
//
//  Created by Apple on 16/6/3.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import "WinTreasureMenuHeader.h"


@interface WinTreasureMenuHeader ()

@property (nonatomic, strong) NSArray *selectItems;
@property (nonatomic, strong) TSHomeMenu *menu;

@end

@implementation WinTreasureMenuHeader

- (NSArray *)selectItems {
    if (!_selectItems) {
        _selectItems = @[@"人气",@"最新",@"进度",@"总需人次"];
    }
    return _selectItems;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _menu = [[TSHomeMenu alloc]initWithDataArray:self.selectItems];
        _menu.origin = CGPointMake(0, 0);
        _menu.size = CGSizeMake(kScreenWidth, kTSMenuHeight);
        [self addSubview:_menu];
        
        CAShapeLayer *lineLayer = [CAShapeLayer layer];
        lineLayer.origin = CGPointMake(0, kTSMenuHeight-CGFloatFromPixel(0.5));
        lineLayer.size = CGSizeMake(self.width, CGFloatFromPixel(0.5));
        lineLayer.backgroundColor = UIColorHex(0xEAE5E1).CGColor;
        [self.layer addSublayer:lineLayer];
    }
    return self;
}

+ (CGFloat)menuHeight {
    return kTSMenuHeight;
}

- (void)selectAMenu:(WinTreasureMenuHeaderBlock)block {
    _block = block;
    @weakify(self);
    _menu.menuBlock = ^(UIButton *sender) {
        @strongify(self);
        if (self.block) {
            self.block(sender);
        }
    };
}

- (void)descend:(WinTreasureSortBlock)block {
    _descBlock = block;
    @weakify(self);
    _menu.descBlock = ^(void) {
        @strongify(self);
        if (self.descBlock) {
            self.descBlock();
        }
    };
}

- (void)aescend:(WinTreasureSortBlock)block {
    _aescBlock = block;
    @weakify(self);
    _menu.aescBlock = ^(void) {
        @strongify(self);
        if (self.aescBlock) {
            self.aescBlock();
        }
    };
}

@end

@interface TSHomeMenu ()
{
    UIButton *_selectedBtn;
}

@end

@implementation TSHomeMenu

const CGFloat kTSHomeMenuHeight = 45.0;
const CGFloat kTSHomeMenuDefaultHeight = 44.0;
const CGFloat kTSHomeMenuLineHeight = 2.5;
const CGFloat kTSHomeMenuLineSpacing = 20.0;

- (CAShapeLayer *)bottomLine {
    if (!_bottomLine) {
        _bottomLine = [CAShapeLayer layer];
        _bottomLine.frame = CGRectMake(kTSHomeMenuLineSpacing,
                                       kTSHomeMenuDefaultHeight-kTSHomeMenuLineHeight,
                                       (kScreenWidth-(kTSHomeMenuLineSpacing*2*_data.count))/_data.count,
                                       kTSHomeMenuLineHeight);
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
        menuBtn.size = CGSizeMake(kScreenWidth/_data.count, kTSHomeMenuDefaultHeight);
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
        if ([[menuBtn titleForState:UIControlStateNormal] isEqualToString:@"总需人次"]) {
            [menuBtn setImage:IMAGE_NAMED(@"list_nav_need") forState:UIControlStateNormal];
            [menuBtn setImageEdgeInsets:UIEdgeInsetsMake(0, kScreenWidth/_data.count-14, 0, 0)];
        }
        
    }];
    [self.layer addSublayer:self.bottomLine];
}

- (void)selectMenu:(UIButton *)sender {
    if ([[sender titleForState:UIControlStateNormal] isEqualToString:@"总需人次"]) {
        if ([[sender imageForState:UIControlStateNormal] isEqual:IMAGE_NAMED(@"list_nav_need_aesc_7x10_")]) {
            [sender setImage:IMAGE_NAMED(@"list_nav_need_desc_7x10_") forState:UIControlStateNormal];
            if (_descBlock) {
                _descBlock();
            }
            return;
        }
        [sender setImage:IMAGE_NAMED(@"list_nav_need_aesc_7x10_") forState:UIControlStateNormal];
        if (_aescBlock) {
            _aescBlock();
        }
    } else {
        UIButton *button = [self viewWithTag:4];
        [button setImage:IMAGE_NAMED(@"list_nav_need") forState:UIControlStateNormal];
    }
    [self refreshButtonState:sender];
    CGFloat lineWidth = _bottomLine.width;
    CGFloat x = (sender.tag-1) * (kTSHomeMenuLineSpacing + lineWidth) + (sender.tag) * kTSHomeMenuLineSpacing;
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
    if (_selectedBtn.tag==4) {
        _selectedBtn.userInteractionEnabled = YES;
    }

}

- (void)scrollBottomLine:(CGFloat)x {
    [UIView animateWithDuration:0.3 animations:^{
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
    CGFloat x = (sender.tag-1) * (kTSHomeMenuLineSpacing + lineWidth) + (sender.tag) * kTSHomeMenuLineSpacing;
    [self scrollBottomLine:x];
}


@end
