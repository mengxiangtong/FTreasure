//
//  TreasureDetailHeader.m
//  WinTreasure
//
//  Created by Apple on 16/6/8.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import "TreasureDetailHeader.h"
#import "TSProgressView.h"
#import "TSCountLabel.h"

#define  kTreasureDetailHeaderMarginBottom 10

const CGFloat kTreasureDetailHeaderPadding = 8.0; //左右边距

const CGFloat kTreasureDetailHeaderPageControlHeight = 30.0; //pagecontroll height

@interface TreasureDetailHeader () <UIScrollViewDelegate, TSCountLabelDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, strong) YYLabel *productNameLabel;

@property (nonatomic, strong) NSArray *images;

@end

@implementation TreasureDetailHeader

+ (CGFloat)getHeight {
    return kScreenWidth*2;
}

- (NSArray *)images {
    if (!_images) {
        _images = @[@"goods1.jpg",
                    @"goods2.jpg",
                    @"goods3.jpg"];
    }
    return _images;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:({
            CGRect rect = {0,0,kScreenWidth,kScreenWidth};
            rect;
        })];
        _scrollView.delegate = self;
        _scrollView.contentSize = CGSizeMake(self.images.count*kScreenWidth, kScreenWidth);
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        [_images enumerateObjectsUsingBlock:^(id  _Nonnull obj,
                                              NSUInteger idx,
                                              BOOL * _Nonnull stop) {
            UIImageView *imgView = [UIImageView new];
            imgView.tag = idx;
            imgView.userInteractionEnabled = YES;
            imgView.image = IMAGE_NAMED(_images[arc4random() % (_images.count - 1)]);
            imgView.origin = CGPointMake(idx*kScreenWidth, 0);
            imgView.size = CGSizeMake(_scrollView.width, _scrollView.height);
            imgView.contentMode = UIViewContentModeScaleAspectFill;
            [_scrollView addSubview:imgView];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
                if (_imageBlock) {
                    _imageBlock(sender);
                }
            }];
            [imgView addGestureRecognizer:tap];
        }];
    }
    return _scrollView;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc]initWithFrame:({
            CGRect rect = {0,kScreenWidth-kTreasureDetailHeaderPageControlHeight,kScreenWidth,kTreasureDetailHeaderPageControlHeight};
            rect;
        })];
        _pageControl.numberOfPages = self.images.count;
        _pageControl.currentPageIndicatorTintColor = kDefaultColor;
        _pageControl.pageIndicatorTintColor = UIColorHex(666666);
        _pageControl.userInteractionEnabled = NO;
    }
    return _pageControl;
}

- (instancetype)initWithFrame:(CGRect)frame
                         type:(TreasureDetailHeaderType)type
                    countTime:(NSInteger)countTime {
    self = [super initWithFrame:frame];
    if (self) {
        _count = countTime;
        _type = type;
        [self setup];
    }
    return self;
}

- (void)setup {
    [self addSubview:self.scrollView];
    [self addSubview:self.pageControl];
    
    NSMutableAttributedString *name = [[NSMutableAttributedString alloc]initWithString:@"Apple Watch Sport 42毫米 铝金属表壳 运动表带 颜色随机"];
    name.color = UIColorHex(333333);
    name.font = SYSTEM_FONT(14);
    name.lineSpacing = 1.0;
    YYTextContainer *container = [YYTextContainer containerWithSize:CGSizeMake(kScreenWidth-kTreasureDetailHeaderPadding*2, HUGE)];
    YYTextLayout *layout = [YYTextLayout layoutWithContainer:container text:name];
    
    _productNameLabel = [YYLabel new];
    _productNameLabel.displaysAsynchronously = YES;
    _productNameLabel.origin = CGPointMake(kTreasureDetailHeaderPadding, _scrollView.bottom+kTreasureDetailHeaderPadding);
    _productNameLabel.size = CGSizeMake(kScreenWidth-kTreasureDetailHeaderPadding*2, 16*layout.rowCount);
    _productNameLabel.numberOfLines = 0;
    _productNameLabel.textLayout = layout;
    
    [self addSubview:_productNameLabel];
    
    @weakify(self);
    _treasureProgressView = [[TreasureProgressView alloc]initWithFrame:({
        CGRect rect = {kTreasureDetailHeaderPadding,
                        _productNameLabel.bottom+8,
        kScreenWidth-kTreasureDetailHeaderPadding*2,
                                                1};
        rect;
    }) type:_type countTime:_count];
    _treasureProgressView.countDownLabel.delegate = self;
    _treasureProgressView.block = ^() {
        @strongify(self);
        if (self.countDetailBlock) {
            self.countDetailBlock();
        }
    };
    [self addSubview:_treasureProgressView];
    
    _participateView = [[ParticipateView alloc]initWithFrame:({
        CGRect rect = {(self.width-_treasureProgressView.width)/2.0,
            _treasureProgressView.bottom+kTreasureDetailHeaderMarginBottom,
            _treasureProgressView.width,
            30};
        rect;
    }) isParticipated:_type==TreasureDetailHeaderTypeParticipated?YES:NO];

    _participateView.backgroundColor = UIColorHex(0xF5F5F5);
    [self addSubview:_participateView];
    
    _headerMenu = [[TreaureHeaderMenu alloc]initWithFrame:({
        CGRect rect = {0,_participateView.bottom+5,kScreenWidth,1};
        rect;
    }) data:@[@"图文详情",
              @"往期揭晓",
              @"晒单分享"]];
    _headerMenu.block = ^(NSInteger index){
        @strongify(self);
        if (self.clickMenuBlock) {
            self.clickMenuBlock(@(index));
        }
    };
    [self addSubview:_headerMenu];
    self.height = _headerMenu.bottom;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _participateView.top = _treasureProgressView.bottom+kTreasureDetailHeaderMarginBottom;
    _headerMenu.top = _participateView.bottom+5;
    self.height = _headerMenu.bottom;
}

#pragma mark - TSCountLabelDelegate
- (void)countdownDidEnd {
    _treasureProgressView.type = TreasureDetailHeaderTypeWon;
    [self setNeedsLayout];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    _pageControl.currentPage = scrollView.contentOffset.x/kScreenWidth;
}

@end

@interface ParticipateView ()

@end

@implementation ParticipateView

- (instancetype)initWithFrame:(CGRect)frame
               isParticipated:(BOOL)isParticipated {
    self = [super initWithFrame:frame];
    if (self) {
        _isParticipated = isParticipated;
        [self _init];
    }
    return self;
}

- (void)_init {
    if (!_isParticipated) {
        _participateLabel = [YYLabel new];
        _participateLabel.backgroundColor = UIColorHex(0xF5F5F5);
        _participateLabel.origin = CGPointMake(0, 0);
        _participateLabel.size = CGSizeMake(self.width, self.height);
        _participateLabel.text = @"您没有参与本次夺宝哦！";
        _participateLabel.textAlignment = NSTextAlignmentCenter;
        _participateLabel.textColor = UIColorHex(666666);
        _participateLabel.font = SYSTEM_FONT(12);
        [self addSubview:_participateLabel];
        return;
    }
    _participateLabel = [YYLabel new];
    _participateLabel.origin = CGPointMake(5, 5);
    _participateLabel.size = CGSizeMake(self.width-5*2, 15);
    _participateLabel.textColor = UIColorHex(666666);
    _participateLabel.font = SYSTEM_FONT(12);
    _participateLabel.text = @"您参与了：2人次";
    [self addSubview:_participateLabel];
    
    _numberLabel = [YYLabel new];
    _numberLabel.origin = CGPointMake(5, _participateLabel.bottom+5);
    _numberLabel.size = CGSizeMake(self.width-5*2, 15);
    _numberLabel.textColor = UIColorHex(666666);
    _numberLabel.font = SYSTEM_FONT(12);
    _numberLabel.text = @"夺宝号码：10004253 10003234";
    [self addSubview:_numberLabel];
    self.height = _numberLabel.bottom+5;
}

@end

//计算详情按钮宽高
const CGFloat kTreasureProgressViewCountButtonHeight = 26.0;
const CGFloat kTreasureProgressViewCountButtonWidth = 80.0;
const CGFloat kWinnerImageWidth = 60.0;
const CGFloat kWinnerImagePadding = 15.0;
const CGFloat kBackImageViewHeight = 36.0;

@implementation TreasureProgressView

- (instancetype)initWithFrame:(CGRect)frame
                         type:(TreasureDetailHeaderType)type
                    countTime:(NSInteger)countTime {
    self = [super initWithFrame:frame];
    if (self) {
        _countTime = countTime;
        _type = type;
        [self setup];
    }
    return self;
}

- (void)setType:(TreasureDetailHeaderType)type {
    _type = type;
    [self removeAllSubviews];
    [self setup];
}

- (void)setup {
    switch (_type) {
        case TreasureDetailHeaderTypeNotParticipate:case TreasureDetailHeaderTypeParticipated: {
            _periodNumberLabel = [YYLabel new];
            _periodNumberLabel.origin = CGPointMake(0, 0);
            _periodNumberLabel.size = CGSizeMake(self.width, 12);
            _periodNumberLabel.font = SYSTEM_FONT(12);
            _periodNumberLabel.textColor = UIColorHex(999999);
            _periodNumberLabel.text = @"期号：306131836";
            [self addSubview:_periodNumberLabel];
            
            _progressView = [[TSProgressView alloc] initWithFrame:({
                CGRect rect = {0,_periodNumberLabel.bottom+5,self.width,10};
                rect;
            })];
            _progressView.progress = (1588/2588) *100.0;
            [self addSubview:_progressView];
            
            _leftLabel = [YYLabel new];
            _leftLabel.size = CGSizeMake(100, 12);
            _leftLabel.left = self.width-100;
            _leftLabel.top = _progressView.bottom+2;
            _leftLabel.textColor = UIColorHex(999999);
            _leftLabel.text = @"剩余1000";
            _leftLabel.textAlignment = NSTextAlignmentRight;
            _leftLabel.font = SYSTEM_FONT(12);
            [self addSubview:_leftLabel];
            
            _totalLabel = [YYLabel new];
            _totalLabel.origin = CGPointMake(0, _progressView.bottom+2);
            _totalLabel.size = CGSizeMake(self.width-_leftLabel.width, 12);
            _totalLabel.font = SYSTEM_FONT(12);
            _totalLabel.textColor = UIColorHex(999999);
            _totalLabel.text = @"总需2588人次";
            [self addSubview:_totalLabel];
            self.height = _totalLabel.bottom + kTreasureDetailHeaderMarginBottom;
        }
            break;
        case TreasureDetailHeaderTypeCountdown:{
            self.backgroundColor = UIColorHex(0xDC1639);
            _periodNumberLabel = [YYLabel new];
            _periodNumberLabel.origin = CGPointMake(5, 10);
            _periodNumberLabel.size = CGSizeMake(self.width-kTreasureProgressViewCountButtonWidth, 12);
            _periodNumberLabel.font = SYSTEM_FONT(12);
            _periodNumberLabel.textColor = [UIColor whiteColor];
            _periodNumberLabel.text = @"期号：306131836";
            [self addSubview:_periodNumberLabel];
            
            _countLabel = [YYLabel new];
            _countLabel.origin = CGPointMake(5, _periodNumberLabel.bottom+8);
            _countLabel.size = CGSizeMake(self.width-kTreasureProgressViewCountButtonWidth, 16);
            _countLabel.font = SYSTEM_FONT(12);
            _countLabel.textColor = [UIColor whiteColor];
            _countLabel.text = @"揭晓倒计时:";
            [self addSubview:_countLabel];
            [_countLabel sizeToFit];
            
            _countDownLabel = [TSCountLabel new];
            _countDownLabel.origin = CGPointMake(_countLabel.right+5, _periodNumberLabel.bottom+8);
            _countDownLabel.size = CGSizeMake(self.width-kTreasureProgressViewCountButtonWidth-(_countLabel.right+5), 16);
            _countDownLabel.centerY = _countLabel.centerY;
            _countDownLabel.font = SYSTEM_FONT(15);
            _countDownLabel.textColor = [UIColor whiteColor];
            _countDownLabel.textAlignment = NSTextAlignmentLeft;
            _countDownLabel.startValue = _countTime;
            [self addSubview:_countDownLabel];
            [_countDownLabel start];
            self.height = _countDownLabel.bottom + 8;

            _countDetailButton = [UIButton buttonWithType:UIButtonTypeCustom];
            _countDetailButton.origin = CGPointMake(self.width-kTreasureProgressViewCountButtonWidth-kTreasureDetailHeaderPadding, (self.height-kTreasureProgressViewCountButtonHeight)/2.0);
            _countDetailButton.size = CGSizeMake(kTreasureProgressViewCountButtonWidth, kTreasureProgressViewCountButtonHeight);
            _countDetailButton.titleLabel.font = SYSTEM_FONT(14);
            _countDetailButton.layer.cornerRadius = 5;
            _countDetailButton.layer.borderColor = [UIColor whiteColor].CGColor;
            _countDetailButton.layer.borderWidth = CGFloatFromPixel(1);
            _countDetailButton.layer.shouldRasterize = YES;
            _countDetailButton.layer.rasterizationScale = kScreenScale;
            [_countDetailButton setTitle:@"计算详情" forState:UIControlStateNormal];
            [_countDetailButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [_countDetailButton addTarget:self action:@selector(countDetail) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:_countDetailButton];
        }
            
            break;
        case TreasureDetailHeaderTypeWon: {
            [self setupWinnerView];

        }
            
            break;
        default:
            break;
    }
}

- (void)setupWinnerView {
    UIColor *defaultColor = UIColorHex(666666);
    UIFont *defaultFont = SYSTEM_FONT(13);
    
    _winnerImgView = [UIImageView new];
    _winnerImgView.origin = CGPointMake(kWinnerImagePadding, kWinnerImagePadding);
    _winnerImgView.size = CGSizeMake(kWinnerImageWidth, kWinnerImageWidth);
    _winnerImgView.image = IMAGE_NAMED(@"curry");
    [self addSubview:_winnerImgView];
    
    YYLabel *aLabel = [YYLabel new];
    aLabel.origin = CGPointMake(_winnerImgView.right+10, _winnerImgView.top);
    aLabel.size = CGSizeMake(self.width-(_winnerImgView.right+5)-5, 16);
    aLabel.font = defaultFont;
    aLabel.text = @"获奖者：";
    aLabel.textColor = defaultColor;
    aLabel.numberOfLines = 0;
    [self addSubview:aLabel];
    [aLabel sizeToFit];
    
    _winnerLabel = [YYLabel new];
    _winnerLabel.origin = CGPointMake(aLabel.right, _winnerImgView.top);
    _winnerLabel.size = CGSizeMake(self.width-aLabel.right, 16);
    _winnerLabel.font = defaultFont;
    _winnerLabel.text = @"我被坑了\n(中国)";
    _winnerLabel.textColor = defaultColor;
    _winnerLabel.numberOfLines = 0;
    [self addSubview:_winnerLabel];
    [_winnerLabel sizeToFit];

    _IDLabel = [YYLabel new];
    _IDLabel.origin = CGPointMake(aLabel.left, _winnerLabel.bottom+2);
    _IDLabel.size = CGSizeMake(self.width-(_winnerImgView.right+5)-5, 16);
    _IDLabel.font = defaultFont;
    _IDLabel.textColor = defaultColor;
    _IDLabel.text = @"用户ID：30985239";
    [self addSubview:_IDLabel];
    [_IDLabel sizeToFit];
    
    _periodNumberLabel = [YYLabel new];
    _periodNumberLabel.origin = CGPointMake(aLabel.left, _IDLabel.bottom+2);
    _periodNumberLabel.size = CGSizeMake(self.width-(_winnerImgView.right+5)-5, 16);
    _periodNumberLabel.font = defaultFont;
    _periodNumberLabel.textColor = defaultColor;
    _periodNumberLabel.text = @"期号：30981005";
    [self addSubview:_periodNumberLabel];
    [_periodNumberLabel sizeToFit];
    
    _totalLabel = [YYLabel new];
    _totalLabel.origin = CGPointMake(aLabel.left, _periodNumberLabel.bottom+2);
    _totalLabel.size = CGSizeMake(self.width-(_winnerImgView.right+5)-5, 16);
    _totalLabel.font = defaultFont;
    _totalLabel.textColor = defaultColor;
    _totalLabel.text = @"本期参与：1000人次";
    [self addSubview:_totalLabel];
    [_totalLabel sizeToFit];
    
    _publishTimeLabel = [YYLabel new];
    _publishTimeLabel.origin = CGPointMake(aLabel.left, _totalLabel.bottom+2);
    _publishTimeLabel.size = CGSizeMake(self.width-(_winnerImgView.right+5)-5, 16);
    _publishTimeLabel.font = defaultFont;
    _publishTimeLabel.textColor = defaultColor;
    _publishTimeLabel.text = @"揭晓时间：2016-06-10 14:15:16";
    [self addSubview:_publishTimeLabel];
    [_publishTimeLabel sizeToFit];

    _backImgView = [UIView new];
    _backImgView.origin = CGPointMake(0, _publishTimeLabel.bottom+20);
    _backImgView.size = CGSizeMake(self.width, kBackImageViewHeight);
    _backImgView.backgroundColor = [UIColor colorWithPatternImage:IMAGE_NAMED(@"winner_bottom_bg")];
    [self addSubview:_backImgView];
    
    _countDetailButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _countDetailButton.origin = CGPointMake(self.width-kTreasureProgressViewCountButtonWidth-kTreasureDetailHeaderPadding, _backImgView.top+(kBackImageViewHeight-kTreasureProgressViewCountButtonHeight)/2.0);
    _countDetailButton.size = CGSizeMake(kTreasureProgressViewCountButtonWidth, kTreasureProgressViewCountButtonHeight);
    _countDetailButton.titleLabel.font = SYSTEM_FONT(14);
    _countDetailButton.layer.cornerRadius = 5;
    _countDetailButton.layer.borderColor = [UIColor whiteColor].CGColor;
    _countDetailButton.layer.borderWidth = CGFloatFromPixel(1);
    _countDetailButton.layer.shouldRasterize = YES;
    _countDetailButton.layer.rasterizationScale = kScreenScale;
    [_countDetailButton setTitle:@"计算详情" forState:UIControlStateNormal];
    [_countDetailButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_countDetailButton addTarget:self action:@selector(countDetail) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_countDetailButton];
    
    _luckyNumberLabel = [YYLabel new];
    _luckyNumberLabel.origin = CGPointMake(kWinnerImagePadding, _backImgView.top+(kBackImageViewHeight-16)/2.0);
    _luckyNumberLabel.size = CGSizeMake(self.width-kWinnerImagePadding*2, 16);
    _luckyNumberLabel.font = SYSTEM_FONT(15);
    _luckyNumberLabel.textColor = [UIColor whiteColor];
    _luckyNumberLabel.text = @"幸运号码：10004038";
    [self addSubview:_luckyNumberLabel];
    [_luckyNumberLabel sizeToFit];
    
    self.backgroundColor = UIColorHex(0xFBF1ED);
    self.height = _backImgView.bottom;
    self.layer.shadowColor = UIColorHex(333333).CGColor;
    self.layer.shadowOpacity = 0.3;
}

- (void)countDetail {
    if (_block) {
        _block();
    }
}

#pragma mark - public
- (void)start {
    [_countDownLabel start];
}

@end

