//
//  PurchaseHeader.m
//  WinTreasure
//
//  Created by Apple on 16/6/27.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import "PurchaseHeader.h"

@interface PurchaseHeader ()
{
    UIButton *_selectedBtn;
}
@property (nonatomic, strong) NSArray *titles;

@property (nonatomic, strong) CAShapeLayer *bottomLine;

@end

const CGFloat kPurchaseLineSpacing = 15.0;
const CGFloat kPurchaseDefaultHeight = 70.0;

@implementation PurchaseHeader

- (NSArray *)titles {
    if (!_titles) {
        _titles = @[@"全部",@"待付款",@"待发货",@"待收货"];
    }
    return _titles;
}

- (CAShapeLayer *)bottomLine {
    if (!_bottomLine) {
        _bottomLine = [CAShapeLayer layer];
        _bottomLine.frame = CGRectMake(kPurchaseLineSpacing,
                                       kPurchaseDefaultHeight-kTSMenuLineHeight,
                                       (kScreenWidth-(kPurchaseLineSpacing*2*_titles.count))/_titles.count,
                                       kTSMenuLineHeight);
        _bottomLine.backgroundColor = kDefaultColor.CGColor;
    }
    return _bottomLine;
}

+ (PurchaseHeader *)puchaseHeader {
    PurchaseHeader *header = [[PurchaseHeader alloc]initWithFrame:({
        CGRect rect = {0,kNavigationBarHeight,kScreenHeight,kPurchaseDefaultHeight};
        rect;
    })];
    return header;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self.titles enumerateObjectsUsingBlock:^(id  _Nonnull obj,
                                                  NSUInteger idx,
                                                  BOOL * _Nonnull stop) {
            PurchaseHeaderButton *menuBtn = [PurchaseHeaderButton buttonWithType:UIButtonTypeCustom];
            menuBtn.origin = CGPointMake(idx*kScreenWidth/_titles.count, 0);
            menuBtn.size = CGSizeMake(kScreenWidth/_titles.count, self.height);
            menuBtn.titleLabel.font = SYSTEM_FONT(13);
            [menuBtn setImage:IMAGE_NAMED(_titles[idx])
                        title:_titles[idx]
                     forState:UIControlStateNormal];
            NSString *selectName = [NSString stringWithFormat:@"%@_sel",_titles[idx]];
            [menuBtn setImage:IMAGE_NAMED(selectName)
                        title:_titles[idx]
                     forState:UIControlStateSelected];
            menuBtn.tag = idx + 1;
            [menuBtn setTitleColor:UIColorHex(666666) forState:UIControlStateNormal];
            [menuBtn setTitleColor:kDefaultColor forState:UIControlStateSelected];
            [menuBtn addTarget:self action:@selector(clickMenu:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:menuBtn];
            if (idx == 0) {
                menuBtn.selected = YES;
                menuBtn.userInteractionEnabled = NO;
                _selectedBtn = menuBtn;
            }

        }];
        [self.layer addSublayer:self.bottomLine];
    }
    return self;
}

- (void)clickMenu:(PurchaseHeaderButton *)sender {
    [self refreshState:sender];
    CGFloat lineWidth = _bottomLine.width;
    CGFloat x = (sender.tag-1) * (kPurchaseLineSpacing + lineWidth) + (sender.tag) * kPurchaseLineSpacing;
    [self scrollBottomLine:x];
}

- (void)refreshState:(UIButton *)sender {
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

@end

@implementation PurchaseHeaderButton

- (void)setImage:(UIImage *)image
           title:(NSString *)title
        forState:(UIControlState)state {
    [self setImage:image forState:state];
    [self setTitle:title forState:state];
}


- (void)layoutSubviews {
    [super layoutSubviews];
    //调整图片(imageView)的位置和尺寸
    CGPoint center = self.titleLabel.center;
    center.x = self.width/2;
    center.y = self.height-self.titleLabel.height;
    self.titleLabel.center = center;
    NSLog(@"y is %f",self.imageView.center.y);
    //调整文字(titleLable)的位置和尺寸
    CGPoint newPoint = self.imageView.center;
    newPoint.x = self.width/2.0;
    newPoint.y = (self.height-self.titleLabel.height)/2.0;
    self.imageView.center = newPoint;
    //让文字居中
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}


@end
