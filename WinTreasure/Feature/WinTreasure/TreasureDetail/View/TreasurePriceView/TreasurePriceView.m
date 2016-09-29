//
//  TreasurePriceView.m
//  WinTreasure
//
//  Created by Apple on 16/6/20.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import "TreasurePriceView.h"
#import "ListCountView.h"

@interface TreasurePriceView ()
{
    UIView *_backgroundView;
}
@property (nonatomic, strong) ListCountView *listView;

@property (nonatomic, strong) UIButton *treasureButton;

@property (nonatomic, strong) YYLabel *coinLabel;

@end

const CGFloat kListCountViewPadding = 50.0;
const CGFloat kPriceButtonPadding = 10.0;
const CGFloat kPriceButtonHeight = 25.0;


@implementation TreasurePriceView

+ (TreasurePriceView *)priceViewWithData:(NSArray *)data {
    TreasurePriceView *priceView = [[TreasurePriceView alloc]initWithData:data];
    return priceView;
}

- (instancetype)initWithData:(NSArray *)data {
    self = [super init];
    if (self) {
        _data = data;
        self.userInteractionEnabled = YES;
        self.backgroundColor = UIColorHex(0xE8E8E8);
        self.frame = ({
            CGRect rect = {0,0,kScreenWidth,kScreenHeight/3.0};
            rect;
        });
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillShow:)
                                                     name:UIKeyboardWillShowNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardShow:)
                                                     name:UIKeyboardDidShowNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillHide:)
                                                     name:UIKeyboardWillHideNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardHide:)
                                                     name:UIKeyboardDidHideNotification
                                                   object:nil];

        [self setup];
    }
    return self;
}

- (void)setup {
    
    YYLabel *titleLabel = [YYLabel new];
    titleLabel.origin = CGPointMake(0, 10);
    titleLabel.size = CGSizeMake(kScreenWidth, 15);
    titleLabel.textColor = UIColorHex(666666);
    titleLabel.font = SYSTEM_FONT(13);
    titleLabel.text = @"参与人次";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:titleLabel];
    
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    closeButton.origin = CGPointMake(kScreenWidth-20-10, 10);
    closeButton.size = CGSizeMake(20, 20);
    [closeButton setImage:IMAGE_NAMED(@"common_close") forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:closeButton];
    
    _listView = [[ListCountView alloc]initWithFrame:({
        CGRect rect = {kListCountViewPadding,
            titleLabel.bottom+10,
            kScreenWidth-kListCountViewPadding*2,
            30};
        rect;
    })];
    [_listView setSelectedCount:10 totalCount:100];
    [self addSubview:_listView];
    
    CGFloat width = (_listView.width-kPriceButtonPadding*(_data.count-1))/_data.count;
    [_data enumerateObjectsUsingBlock:^(id  _Nonnull obj,
                                        NSUInteger idx,
                                        BOOL * _Nonnull stop) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.origin = CGPointMake(kListCountViewPadding+idx*(kPriceButtonPadding+width), _listView.bottom+30);
        button.size = CGSizeMake(width, kPriceButtonHeight);
        button.layer.cornerRadius = 2.0;
        button.layer.borderColor = UIColorHex(999999).CGColor;
        button.layer.borderWidth = CGFloatFromPixel(1);
        button.titleLabel.font = SYSTEM_FONT(13);
        button.backgroundColor = [UIColor whiteColor];
        [button setTitle:_data[idx] forState:UIControlStateNormal];
        [button setTitleColor:UIColorHex(333333) forState:UIControlStateNormal];
        [button setTitleColor:UIColorHex(999999) forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(selectPrice:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }];
    
    CAShapeLayer *line = [CAShapeLayer layer];
    line.origin = CGPointMake(0, _listView.bottom+30+kPriceButtonHeight+15);
    line.size = CGSizeMake(kScreenWidth, CGFloatFromPixel(1));
    line.backgroundColor = UIColorHex(999999).CGColor;
    [self.layer addSublayer:line];
    
    _coinLabel = [YYLabel new];
    _coinLabel.origin = CGPointMake(0, line.bottom+15);
    _coinLabel.size = CGSizeMake(kScreenWidth, 15);
    _coinLabel.text = @"共 10夺宝币";
    _coinLabel.font = SYSTEM_FONT(15);
    _coinLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_coinLabel];
    
    _treasureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _treasureButton.origin = CGPointMake(0, self.height-40);
    _treasureButton.size = CGSizeMake(kScreenWidth, 40);
    _treasureButton.backgroundColor = kDefaultColor;
    _treasureButton.titleLabel.font = SYSTEM_FONT(15);
    [_treasureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_treasureButton setTitleColor:[UIColorHex(666666) colorWithAlphaComponent:0.1] forState:UIControlStateHighlighted];
    [_treasureButton setTitle:@"立即夺宝" forState:UIControlStateNormal];
    [_treasureButton addTarget:self action:@selector(clickWinTreasure) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_treasureButton];
    
    @weakify(self);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
        @strongify(self);
        [self.listView resignFirstRespond];
    }];
    [self addGestureRecognizer:tap];
}

- (void)selectPrice:(UIButton *)sender {
    _listView.selectedCount = [[sender titleForState:UIControlStateNormal] integerValue];
    _coinLabel.text = [NSString stringWithFormat:@"共 %@夺宝币",[sender titleForState:UIControlStateNormal]];
}

- (void)clickWinTreasure {
    [_listView resignFirstRespond];
    [self hide];
    if (_winTreasure) {
        _winTreasure();
    }
}

- (void)show {
    _backgroundView = [[UIView alloc]initWithFrame:({
        CGRect rect = [UIScreen mainScreen].bounds;
        rect;
    })];
    _backgroundView.backgroundColor = [UIColorHex(0x333333) colorWithAlphaComponent:0.6];
    @weakify(self);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
        @strongify(self);
        [self hide];
    }];
    [_backgroundView addGestureRecognizer:tap];

    self.frame = ({
        CGRect rect = {0,kScreenHeight,kScreenWidth,kScreenHeight/3.0};
        rect;
    });
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = ({
            CGRect rect = {0,kScreenHeight-kScreenHeight/3.0,kScreenWidth,kScreenHeight/3.0};
            rect;
        });
    }];
    [[AppDelegate getAppDelegate].window addSubview:_backgroundView];
    [[AppDelegate getAppDelegate].window addSubview:self];
}

- (void)hide {
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight/3.0);
        _backgroundView.alpha = 0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
            [_backgroundView removeFromSuperview];
        }
    }];
}


#pragma mark - key board notice 
- (void)keyboardWillShow:(NSNotification *)notif {
    if (self.hidden == YES) {
        return;
    }
    CGRect rect = [[notif.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [UIView animateWithDuration:0.25 animations:^{
        self.origin  = CGPointMake(0, self.origin.y-rect.size.height);
    }];
}

- (void)keyboardShow:(NSNotification *)notif {

}

- (void)keyboardWillHide:(NSNotification *)notif {
    if (self.hidden == YES) {
        return;
    }
    [UIView animateWithDuration:0.25 animations:^{
        self.origin  = CGPointMake(0, kScreenHeight-kScreenHeight/3.0);
    }];
}

- (void)keyboardHide:(NSNotification *)notif {

}

- (void)dealloc {
    NSLog(@"%s",__func__);
}

@end
