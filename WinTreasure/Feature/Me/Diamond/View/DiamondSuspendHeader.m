//
//  BonusSuspendHeader.m
//  WinTreasure
//
//  Created by Apple on 16/7/4.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import "DiamondSuspendHeader.h"
#import "TSMenu.h"

@interface DiamondSuspendHeader ()

@property (nonatomic, strong) NSArray *selectItems;

@property (nonatomic, strong) TSMenu *menu;

@end

@implementation DiamondSuspendHeader

- (NSArray *)selectItems {
    if (!_selectItems) {
        _selectItems = @[@"默认",@"收入",@"支出",@"折半与清零"];        
    }
    return _selectItems;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _menu = [[TSMenu alloc]initWithDataArray:self.selectItems];
        _menu.origin = CGPointMake(0, 0);
        _menu.size = CGSizeMake(kScreenWidth, kTSMenuHeight);
        [self addSubview:_menu];
        
        CAShapeLayer *lineLayer = [CAShapeLayer layer];
        lineLayer.origin = CGPointMake(0, kTSMenuHeight-CGFloatFromPixel(0.5));
        lineLayer.size = CGSizeMake(self.width, CGFloatFromPixel(0.5));
        lineLayer.backgroundColor = UIColorHex(0xeeeeee).CGColor;
        [self.layer addSublayer:lineLayer];
    }
    return self;
}

+ (CGFloat)menuHeight {
    return kTSMenuHeight;
}

- (void)selectAMenu:(DiamondSuspendHeaderBlock)block {
    _block = block;
    @weakify(self);
    _menu.menuBlock = ^(UIButton *sender) {
        @strongify(self);
        if (self.block) {
            self.block(sender);
        }
    };
}
@end
