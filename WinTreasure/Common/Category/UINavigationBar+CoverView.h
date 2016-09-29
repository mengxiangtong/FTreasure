//
//  UINavigationBar+CoverView.h
//  WinTreasure
//
//  Created by Apple on 16/6/8.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (CoverView)

@property (nonatomic, strong) UIView *coverView;

- (void)setCoverViewBackgroundColor:(UIColor *)color;

- (void)_setElementsAlpha:(CGFloat)alpha;
- (void)_setTranslationY:(CGFloat)translationY;
- (void)_resetCoverView;
@end
