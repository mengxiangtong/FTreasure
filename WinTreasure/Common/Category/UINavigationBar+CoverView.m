//
//  UINavigationBar+CoverView.m
//  WinTreasure
//
//  Created by Apple on 16/6/8.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import "UINavigationBar+CoverView.h"
#import <objc/runtime.h>

static char key;

@implementation UINavigationBar (CoverView)

- (void)setCoverView:(UIView *)coverView {
    objc_setAssociatedObject(self, &key, coverView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)coverView {
   return objc_getAssociatedObject(self, &key);
}

- (void)setCoverViewBackgroundColor:(UIColor *)color {
    if (!self.coverView) {
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        [self setShadowImage:[UIImage new]];
        UIView *aView = [[UIView alloc]initWithFrame:({
            CGRect rect = {0, -20, kScreenWidth, CGRectGetHeight(self.bounds)+20};
            rect;
        })];
        aView.userInteractionEnabled = NO;
        aView.autoresizingMask = UIViewAutoresizingFlexibleWidth |UIViewAutoresizingFlexibleHeight;
        [self insertSubview:aView atIndex:0];
        aView.backgroundColor = color;
        self.coverView = aView;
        return;
    }
    self.coverView.backgroundColor = color;
}

- (void)_setTranslationY:(CGFloat)translationY
{
    self.transform = CGAffineTransformMakeTranslation(0, translationY);
}

- (void)_setElementsAlpha:(CGFloat)alpha
{
    [[self valueForKey:@"_leftViews"] enumerateObjectsUsingBlock:^(UIView *view, NSUInteger i, BOOL *stop) {
        view.alpha = alpha;
    }];
    
    [[self valueForKey:@"_rightViews"] enumerateObjectsUsingBlock:^(UIView *view, NSUInteger i, BOOL *stop) {
        view.alpha = alpha;
    }];
    
    UIView *titleView = [self valueForKey:@"_titleView"];
    titleView.alpha = alpha;
    //    when viewController first load, the titleView maybe nil
    [[self subviews] enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:NSClassFromString(@"UINavigationItemView")]) {
            obj.alpha = alpha;
            *stop = YES;
        }
    }];
}

- (void)_resetCoverView {
    [self setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.coverView removeFromSuperview];
    self.coverView = nil;
}

@end
