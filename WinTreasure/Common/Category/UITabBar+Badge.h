//
//  UITabBar+Badge.h
//  WinTreasure
//
//  Created by Apple on 16/6/29.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (Badge)

- (void)showBadgeOnItemIndex:(int)index;    //显示小红点

- (void)hideBadgeOnItemIndex:(int)index;    //隐藏小红点

- (void)setBadgeValue:(NSInteger)value AtIndex:(NSInteger)index;

- (void)hideBadgeValueAtIndex:(NSInteger)index;

@end
