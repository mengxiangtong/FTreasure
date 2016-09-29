//
//  TSMenu.h
//  WinTreasure
//
//  Created by Apple on 16/6/2.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void (^TSMenuSelectedBlock)(id object);

@interface TSMenu : UIView

@property (nonatomic, assign) NSInteger selectIndex;

@property (nonatomic, strong) NSArray *data;

@property (nonatomic, strong) CAShapeLayer *bottomLine;

@property (nonatomic, copy) TSMenuSelectedBlock menuBlock;

- (instancetype)initWithDataArray:(NSArray *)data;

@end
