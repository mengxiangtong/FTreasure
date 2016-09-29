//
//  BonusModel.m
//  WinTreasure
//
//  Created by Apple on 16/6/17.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import "BonusModel.h"

@implementation BonusModel

- (instancetype)init {
    self = [super init];
    if (self) {
        self.bonusName = @"新用户激励红包";
        self.useCondition = @"满5元使用";
        self.bonusSum = @"5元";
        self.effectiveTime = @"生效期：2016-06-28 18:42:21";
        self.indate = @"有效期：2016-07-08 18:42:21";
        self.bonusType = 0;
    }
    return self;
}

@end
