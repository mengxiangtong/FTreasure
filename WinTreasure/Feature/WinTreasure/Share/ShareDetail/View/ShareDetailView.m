//
//  ShareDetailView.m
//  WinTreasure
//
//  Created by Apple on 16/7/5.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import "ShareDetailView.h"
#import "YYControl.h"

@implementation ShareDetailView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    _containerView = [UIView new];
    _containerView.width = kScreenWidth;
    _containerView.height = 1;
    _containerView.backgroundColor = [UIColor whiteColor];
    _containerView.userInteractionEnabled = YES;
    [self addSubview:_containerView];
    
    _headLabel = [YYLabel new];
    _headLabel.origin = CGPointMake(kShareDetailPadding, kShareDetailPadding);
    _headLabel.size = CGSizeMake(kShareDetailContentWidth, 16);
    [_containerView addSubview:_headLabel];
    
    _usernameLabel = [YYLabel new];
    _usernameLabel.origin = CGPointMake(kShareDetailPadding, _headLabel.bottom+kShareDetailPadding);
    _usernameLabel.size = CGSizeMake(kScreenWidth/2.0, 16);
    [_containerView addSubview:_usernameLabel];
    
    _timeLabel = [YYLabel new];
    _timeLabel.size = CGSizeMake(kScreenWidth/2.0, 16);
    _timeLabel.left = kScreenWidth/2.0-kShareDetailPadding;
    _timeLabel.textAlignment = NSTextAlignmentRight;
    [_containerView addSubview:_timeLabel];
    
    _infoView = [ProductInfoView new];
    _infoView.origin = CGPointMake(0, _usernameLabel.bottom+kShareDetailPadding);
    _infoView.size = CGSizeMake(kScreenWidth, 1);
    [_containerView addSubview:_infoView];
    
    _contentLabel = [YYLabel new];
    _contentLabel.origin = CGPointMake(kShareDetailPadding, _infoView.bottom+kShareDetailPadding);
    _contentLabel.size = CGSizeMake(kShareDetailContentWidth, 16);
    [_containerView addSubview:_contentLabel];
    
    NSMutableArray *picViews = [NSMutableArray new];
    for (int i=0; i<3; i++) {
        YYControl *imageView = [YYControl new];
        imageView.backgroundColor = UIColorHex(0xe5e5e5);
        imageView.size = CGSizeMake(kShareDetailContentWidth, kShareDetailContentWidth*3/4.0);
        imageView.hidden = YES;
        imageView.clipsToBounds = YES;
        imageView.exclusiveTouch = YES;
        [picViews addObject:imageView];
        [self addSubview:imageView];
    }
    _picViews = picViews;
}

- (void)_hideImageViews {
    for (UIImageView *imageView in _picViews) {
        imageView.hidden = YES;
    }
}

- (void)setLayout:(ShareDetailLayout *)layout {
    _layout = layout;
    self.height = layout.height;
    _containerView.height = _containerView.height;
    _infoView.layout = layout;
    
    CGFloat top = kShareDetailPadding;
    
    _headLabel.top = top;
    _headLabel.height = layout.titleHeight;
    _headLabel.textLayout = layout.titleTextLayout;

    top += _headLabel.height + kShareDetailPadding;
    _usernameLabel.top = top;
    _usernameLabel.height = layout.nameHeight;
    _usernameLabel.textLayout = layout.nameTextLayout;
    
    _timeLabel.top = top;
    _timeLabel.height = layout.nameHeight;
    _timeLabel.textLayout = layout.timeTextLayout;
    
    top += _usernameLabel.height + kShareDetailPadding;
    _infoView.top = top;
    _infoView.height = layout.infoHeight;
    
    top += _infoView.height + 8;
    _contentLabel.top = top;
    _contentLabel.height = layout.contentHeight;
    _contentLabel.textLayout = layout.contentTextLayout;
    
    top += _contentLabel.height + kShareDetailPadding;
    
    if (layout.picHeight == 0) {
        [self _hideImageViews];
    }
    if (layout.picHeight > 0) {
        [self setImageViewWithTop:top];
    }
}

- (void)setImageViewWithTop:(CGFloat)imageTop {
    CGSize picSize = _layout.picSize;
    NSArray *pics = _layout.model.imageList;
    int picsCount = (int)pics.count;
    
    for (int i = 0; i < 3; i++) {
        UIView *imageView = _picViews[i];
        if (i >= picsCount) {
            [imageView.layer cancelCurrentImageRequest];
            imageView.hidden = YES;
        } else {
            CGPoint origin = {0};
            origin.x = kShareDetailPadding;
            origin.y = (picSize.height+kShareDetailPadding)*i + imageTop;
            imageView.frame = (CGRect){.origin = origin, .size = picSize};
            imageView.hidden = NO;
            [imageView.layer removeAnimationForKey:@"contents"];
            
            @weakify(imageView);
            [imageView.layer setImageWithURL:[NSURL URLWithString:pics[i]]
                                 placeholder:nil
                                     options:YYWebImageOptionAvoidSetImage
                                  completion:^(UIImage *image, NSURL *url, YYWebImageFromType from, YYWebImageStage stage, NSError *error) {
                 @strongify(imageView);
                 if (!imageView) return;
                 if (image && stage == YYWebImageStageFinished) {
                     imageView.contentMode = UIViewContentModeScaleAspectFill;
                     imageView.layer.contentsRect = CGRectMake(0, 0, 1, 1);
                     
                     ((YYControl *)imageView).image = image;
                     if (from != YYWebImageFromMemoryCacheFast) {
                         CATransition *transition = [CATransition animation];
                         transition.duration = 0.15;
                         transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
                         transition.type = kCATransitionFade;
                         [imageView.layer addAnimation:transition forKey:@"contents"];
                     }
                 }
             }];
        }
    }
}

@end

@implementation ProductInfoView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColorHex(0xf5f5f5);
        _productNameLabel = [YYLabel new];
        _productNameLabel.origin = CGPointMake(kShareDetailPadding, kProductInfoMargin);
        _productNameLabel.size = CGSizeMake(kShareDetailContentWidth, 16);
        [self addSubview:_productNameLabel];
        
        _periodLabel = [YYLabel new];
        _periodLabel.origin = CGPointMake(kShareDetailPadding, _productNameLabel.bottom+kProductInfoMargin);
        _periodLabel.size = CGSizeMake(kShareDetailContentWidth, 16);
        [self addSubview:_periodLabel];
        
        _participateLabel = [YYLabel new];
        _participateLabel.origin = CGPointMake(kShareDetailPadding, _periodLabel.bottom+kProductInfoMargin);
        _participateLabel.size = CGSizeMake(kShareDetailContentWidth, 16);
        [self addSubview:_participateLabel];
        
        _luckyNumberLabel = [YYLabel new];
        _luckyNumberLabel.origin = CGPointMake(kShareDetailPadding, _participateLabel.bottom+kProductInfoMargin);
        _luckyNumberLabel.size = CGSizeMake(kShareDetailContentWidth, 16);
        [self addSubview:_luckyNumberLabel];
        
        _publishTimeLabel = [YYLabel new];
        _publishTimeLabel.origin = CGPointMake(kShareDetailPadding, _luckyNumberLabel.bottom+kProductInfoMargin);
        _publishTimeLabel.size = CGSizeMake(kShareDetailContentWidth, 16);
        [self addSubview:_publishTimeLabel];
    }
    return self;
}

- (void)setLayout:(ShareDetailLayout *)layout {
    _layout = layout;
    self.height = _layout.infoHeight;
    
    CGFloat top = kProductInfoMargin;
    _productNameLabel.top = top;
    _productNameLabel.height = _layout.productNameHeight;
    _productNameLabel.textLayout = _layout.productNameTextLayout;
    
    top += _productNameLabel.height + kProductInfoMargin;
    _periodLabel.top = top;
    _periodLabel.height = _layout.periodHeight;
    _periodLabel.textLayout = _layout.periodTextLayout;
    
    top += _periodLabel.height + kProductInfoMargin;
    _participateLabel.top = top;
    _participateLabel.height = _layout.paticipateHeight;
    _participateLabel.textLayout = _layout.paticipateLayout;
    
    top += _participateLabel.height + kProductInfoMargin;
    _luckyNumberLabel.top = top;
    _luckyNumberLabel.height = _layout.luckyNumberHeight;
    _luckyNumberLabel.textLayout = _layout.luckyNumberLayout;
    
    top += _luckyNumberLabel.height + kProductInfoMargin;
    _publishTimeLabel.top = top;
    _publishTimeLabel.height = _layout.publishTimeHeight;
    _publishTimeLabel.textLayout = _layout.publishTimeLayout;
}

@end
