//
//  UIButton+Block.h
//  WA
//
//  Created by Haitao.Li on 15/2/2.
//  Copyright (c) 2015年 Pactera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

typedef void (^ActionBlock)();

@interface UIButton (Block)

@property (nonatomic, copy) NSString *Type;

@property (readonly) NSMutableDictionary *event;

- (void) handleControlEvent:(UIControlEvents)controlEvent withBlock:(ActionBlock)action;


@end
