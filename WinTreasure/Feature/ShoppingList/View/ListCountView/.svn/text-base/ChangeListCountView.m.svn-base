//
//  ChangeListCountView.m
//  WinTreasure
//
//  Created by Apple on 16/6/20.
//  Copyright © 2016年 i-mybest. All rights reserved.
//

#import "ChangeListCountView.h"

const CGFloat kChangeListViewWidth = 80.0+36*2;
const CGFloat kHandleButtonWidth = 36.0;
const CGFloat kNumberTextFieldWidth = 80.0;

@interface ChangeListCountView ()

/**数字
 */
@property (nonatomic, strong) UITextField *numberFD;

@end

@implementation ChangeListCountView

- (instancetype)initWithFrame:(CGRect)frame
                selectedCount:(NSInteger)selectedCount
                   totalCount:(NSInteger)totalCount {
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = 5.0;
        self.layer.masksToBounds = YES;
        self.layer.borderColor = UIColorHex(333333).CGColor;
        self.layer.borderWidth = CGFloatFromPixel(0.5);
        self.layer.shouldRasterize = YES;
        self.layer.rasterizationScale = kScreenScale;
        self.selectedCount = selectedCount;
        self.totalCount = totalCount;
        [self setup];
    }
    return self;
}

- (void)setup {
    _minusButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _minusButton.exclusiveTouch = YES;
    _minusButton.origin = CGPointMake(0, 0);
    _minusButton.size = CGSizeMake(self.height, self.height);
    [_minusButton setImage:IMAGE_NAMED(@"cart_minus_btn_16x16_") forState:UIControlStateNormal];
    [self addSubview:_minusButton];
    [_minusButton addTarget:self action:@selector(minus:) forControlEvents:UIControlEventTouchUpInside];
    _minusButton.enabled = (_selectedCount <= 1) ? NO : YES;
    
    _numberFD = [[UITextField alloc]initWithFrame:({
        CGRect rect = {
            _minusButton.right,
            0,
            self.width-self.height*2,
            self.height};
        rect;
    })];
    _numberFD.tintColor = kDefaultColor;
    _numberFD.textAlignment=NSTextAlignmentCenter;
    _numberFD.keyboardType=UIKeyboardTypeNumberPad;
    _numberFD.clipsToBounds = YES;
    _numberFD.font = SYSTEM_FONT(13);
    _numberFD.text=[NSString stringWithFormat:@"%zi",self.selectedCount];
    _numberFD.textColor = kDefaultColor;
    [self addSubview:_numberFD];
    
    CAShapeLayer *leftBorder = [CAShapeLayer layer];
    leftBorder.backgroundColor = UIColorHex(999999).CGColor;
    leftBorder.frame = CGRectMake(_minusButton.right, 0, CGFloatFromPixel(1), self.height);
    [self.layer addSublayer:leftBorder];
    
    CAShapeLayer *rightBorder = [CAShapeLayer layer];
    rightBorder.backgroundColor = UIColorHex(999999).CGColor;
    rightBorder.frame = CGRectMake(_numberFD.right, 0, CGFloatFromPixel(1), self.height);
    [self.layer addSublayer:rightBorder];
    
    _plusButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _plusButton.exclusiveTouch = YES;
    _plusButton.origin = CGPointMake(_numberFD.right, 0);
    _plusButton.size = CGSizeMake(self.height, self.height);
    [_plusButton setImage:IMAGE_NAMED(@"cart_plus_btn_16x16_") forState:UIControlStateNormal];
    [_plusButton addTarget:self action:@selector(plus:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_plusButton];
    _plusButton.enabled = (_selectedCount >= _totalCount) ? NO : YES;
    
}

- (void)setSelectedCount:(NSInteger)selectedCount {
    _selectedCount = selectedCount;
    _numberFD.text = [NSString stringWithFormat:@"%zi",_selectedCount];
}

- (void)resignFirstRespond {
    if ([_numberFD isFirstResponder]) {
        [_numberFD resignFirstResponder];
    }
}

#pragma mark - button events
- (void)plus:(UIButton *)sender {
    ++ _selectedCount;
    if (_selectedCount>1) {
        _minusButton.userInteractionEnabled = YES;
    }
    if (_selectedCount>=99) {
        _selectedCount = 99;
        _plusButton.userInteractionEnabled = NO;
    }
    _numberFD.text = [NSString stringWithFormat:@"%zi",_selectedCount];
    
}

- (void)minus:(UIButton *)sender {
    -- _selectedCount;
    if (_selectedCount<99) {
        _plusButton.userInteractionEnabled = YES;
    }
    if (_selectedCount<=1) {
        _selectedCount = 1;
        _minusButton.userInteractionEnabled = NO;
    }
    
    _numberFD.text = [NSString stringWithFormat:@"%zi",_selectedCount];
    
}

- (void)add {
    
}

@end

@interface ShopListKeyBoard ()



@end

@implementation ShopListKeyBoard

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

@end































