//
//  RedBook.m
//  WinTreasure
//
//  Created by Apple on 16/6/7.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import "RedBook.h"

#define kRedBookDotWidth 10.0

@interface RedBook ()
{
    CABasicAnimation *pathAnimation;
    CAAnimationGroup *groupAnimation;
}
@property (nonatomic, strong) CAShapeLayer *dotLayer;

@property (nonatomic, strong) CAShapeLayer *bgLayer;

@property (nonatomic, strong) CAShapeLayer *lineLayer;

@property (nonatomic, strong) CAShapeLayer *animatedLayer;

@property (nonatomic, strong) YYLabel *label;

@property (nonatomic, strong) NSTimer *timer;

@end


@implementation RedBook

- (YYLabel *)label {
    if (!_label) {
        _label = [YYLabel new];
        _label.text = _dataArray[0];
        _label.font = SYSTEM_FONT(12);
        _label.textColor = [UIColor whiteColor];
        _label.origin = CGPointMake(kRedBookDotWidth+20, 5);
        _label.size = CGSizeMake(kScreenWidth, 12);
        _label.alpha = 0.0;
        [_label sizeToFit];
    }
    return _label;
}

- (CAShapeLayer *)dotLayer {
    if (!_dotLayer) {
        _dotLayer = [CAShapeLayer layer];
        _dotLayer.origin = CGPointMake(17.5, 17.5);
        _dotLayer.size = CGSizeMake(kRedBookDotWidth/2, kRedBookDotWidth/2);
        _dotLayer.backgroundColor = [UIColor whiteColor].CGColor;
        _dotLayer.cornerRadius = kRedBookDotWidth/4.0;
        _dotLayer.masksToBounds = YES;
    }
    return _dotLayer;
}

- (CAShapeLayer *)bgLayer {
    if (!_bgLayer) {
        _bgLayer = [CAShapeLayer layer];
        _bgLayer.origin = CGPointMake(15, 15);
        _bgLayer.size = CGSizeMake(kRedBookDotWidth, kRedBookDotWidth);
        _bgLayer.backgroundColor = [UIColor blackColor].CGColor;
        _bgLayer.cornerRadius = kRedBookDotWidth/2.0;
        _bgLayer.masksToBounds = YES;
    }
    return _bgLayer;
}

- (CAShapeLayer *)animatedLayer {
    if (!_animatedLayer) {
        _animatedLayer = [CAShapeLayer layer];
        _animatedLayer.origin = CGPointMake(15, 15);
        _animatedLayer.size = CGSizeMake(kRedBookDotWidth, kRedBookDotWidth);
        _animatedLayer.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.2].CGColor;
        _animatedLayer.cornerRadius = kRedBookDotWidth/2.0;
        _animatedLayer.masksToBounds = YES;
    }
    return _animatedLayer;
}


- (instancetype)initWithArray:(NSArray *)array {
    self = [super init];
    if (self) {
        self.dataArray = array;
        self.dataArray = @[@"Dior T-Shirtfasdfsagsdags"];
        [self addSubview:self.label];
        [self.layer addSublayer:self.animatedLayer];
        [self.layer addSublayer:self.bgLayer];
        [self.layer addSublayer:self.dotLayer];

        _lineLayer = [CAShapeLayer layer];
        _lineLayer.frame = CGRectMake(10, 9.5, 1, 1);
        _lineLayer.backgroundColor = [UIColor whiteColor].CGColor;
        _lineLayer.strokeColor = [UIColor whiteColor].CGColor;
        _lineLayer.fillColor = [UIColor whiteColor].CGColor;
        _lineLayer.lineCap = kCALineCapSquare;
        _lineLayer.lineWidth = 0.8;
        _lineLayer.strokeStart = 0.0;
        _lineLayer.strokeEnd = 0.0;
        [self.layer addSublayer:_lineLayer];
        [self setup];

        CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
        scaleAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 1)];
        scaleAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(5, 5, 1)];
        
        CABasicAnimation *alphaAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
        alphaAnimation.fromValue = @1;
        alphaAnimation.toValue = @0;
        
        groupAnimation = [CAAnimationGroup animation];
        groupAnimation.animations = @[scaleAnimation, alphaAnimation];
        groupAnimation.delegate = self;
        groupAnimation.duration = 0.5;
        groupAnimation.repeatCount = 2;
        groupAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];

        pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        pathAnimation.duration = 2.5;
        pathAnimation.delegate = self;
        pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        pathAnimation.autoreverses = NO;
        [self.timer fire];
    }
    return self;
}

- (void)setup {
    switch (_dataArray.count) {
        case 0: case 1: {
            NSString *string = _dataArray[0];
            CGFloat width = [string sizeWithAttributes:@{NSFontAttributeName:SYSTEM_FONT(12)}].width+15;
            UIBezierPath *path = [UIBezierPath bezierPath];
            [path moveToPoint:CGPointMake(_lineLayer.origin.x, _lineLayer.bottom)];
            [path addLineToPoint:CGPointMake(_lineLayer.origin.x+width, _lineLayer.bottom)];
            _lineLayer.path = path.CGPath;
            _label.text = [_dataArray firstObject];
        }
            break;
        case 2: {
            UIBezierPath *path = [UIBezierPath bezierPath];
            [path moveToPoint:CGPointMake(_lineLayer.origin.x, _lineLayer.bottom)];
            [path addLineToPoint:CGPointMake(_lineLayer.origin.x+100, _lineLayer.bottom)];
            _lineLayer.path = path.CGPath;
            _label.text = [_dataArray firstObject];
        }
            break;
        case 3:
            break;
        default:
            break;
    }
    [_lineLayer addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
}

- (void)strokeEnd {
    [UIView animateWithDuration:1 animations:^{
        _lineLayer.speed = 0.6;
        pathAnimation.fromValue = @1.0;
        pathAnimation.toValue = @0.0;
        _lineLayer.strokeEnd = 0.0;
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 animations:^{
            _label.alpha = 0.0;
        }];
    }];
}

- (void)strokeStart {

    [UIView animateWithDuration:1 animations:^{
        pathAnimation.fromValue = @0.0f;
        pathAnimation.toValue = @1.0f;
        _lineLayer.speed = 0.6;
        _lineLayer.strokeEnd = 1.0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 animations:^{
            _label.alpha = 1.0;
        }];
    }];
}

- (NSTimer *)timer{
    if (!_timer) {
        _timer = [NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(timeRepeat) userInfo:self repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
    }
    return _timer;
}

- (void)timeRepeat {
    [_animatedLayer addAnimation:groupAnimation forKey:@"groupAnimation"];

}

- (void)startAnimation {
    [_animatedLayer addAnimation:groupAnimation forKey:@"groupAnimation"];
}

- (void)dealloc {
    NSLog(@"%s",__func__);
}


@end
