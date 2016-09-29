//
//  TSAnimation.m
//  WinTreasure
//
//  Created by Apple on 16/6/7.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import "TSAnimation.h"

static TSAnimation *sharedInstance = nil;

@implementation TSAnimation

+ (TSAnimation *)sharedAnimation {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!sharedInstance) {
            sharedInstance = [[[self class]alloc]init];
        }
    });
    return sharedInstance;
}

- (void)throwTheView:(UIView *)view
                path:(UIBezierPath *)path
           isRotated:(BOOL)isRotated
            endScale:(CGFloat)endScale {
    self.showingView = view;
    [self groupAnimation:path
              isRotation:isRotated
                endScale:endScale];
}

- (void)groupAnimation:(UIBezierPath *)path {
    [self groupAnimation:path isRotation:YES endScale:0.1f];
}

- (void)groupAnimation:(UIBezierPath *)path
            isRotation:(BOOL)isRotation
              endScale:(CGFloat )endScale {
    [self groupAnimation:path
                endScale:endScale
              isRotation:isRotation
       animationDuration:0.9f];
}

- (void)groupAnimation:(UIBezierPath *)path
              endScale:(CGFloat )endScale
            isRotation:(BOOL)isRotation
     animationDuration:(CFTimeInterval)animationDuration {
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = path.CGPath;
    animation.rotationMode = kCAAnimationRotateAuto;
    
    CABasicAnimation *narrowAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    //    narrowAnimation.beginTime = 0.5;
    narrowAnimation.fromValue = [NSNumber numberWithFloat:1.0f];
    narrowAnimation.duration = animationDuration;
    narrowAnimation.toValue = [NSNumber numberWithFloat:endScale];
    
    narrowAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = 0.3f;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = animationDuration/0.3f;
    
    CAAnimationGroup *groups = [CAAnimationGroup animation];
    if (isRotation) {
        groups.animations = @[animation,rotationAnimation,narrowAnimation];
    } else {
        groups.animations = @[animation,narrowAnimation];
    }
    
    groups.duration = animationDuration;
    groups.removedOnCompletion=NO;
    groups.fillMode=kCAFillModeForwards;
    groups.delegate = self;
    _isShowing = YES;
    [self.showingView.layer addAnimation:groups forKey:@"group"];

}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    _isShowing = NO;
    if (_delegate && [_delegate respondsToSelector:@selector(animationFinished)]) {
        [_delegate animationFinished];
    }
    [self.showingView removeFromSuperview];
    self.showingView = nil;
}

@end
