//
//  MyBonusModel.m
//  WinTreasure
//
//  Created by Apple on 16/7/4.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import "MyDiamondModel.h"

@implementation MyDiamondModel

- (instancetype)init {
    self = [super init];
    if (self) {
        self.title = @"夺宝获得";
        self.time = @"2016-07-01 10:00:00";
        self.bonusAmount = @"+1";
    }
    return self;
}

@end
