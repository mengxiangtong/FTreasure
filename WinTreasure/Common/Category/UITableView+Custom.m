//
//  UITableView+Custom.m
//  UITableView+Custom
//
//  Created by linitial on 15-3-12.
//  Copyright (c) 2015年 linitial. All rights reserved.
//

#import "UITableView+Custom.h"

@implementation UITableView (Custom)

- (void)setCustomSeparatorInset:(UIEdgeInsets)Inset {
    if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
        [self setSeparatorInset:Inset];
    }
    
    if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
        [self setLayoutMargins:Inset];
    }
}

@end
