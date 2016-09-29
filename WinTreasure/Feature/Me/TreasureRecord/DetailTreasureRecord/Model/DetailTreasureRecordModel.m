//
//  DetailTreasureRecordModel.m
//  WinTreasure
//
//  Created by Apple on 16/6/15.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import "DetailTreasureRecordModel.h"

@implementation DetailTreasureRecordModel

- (instancetype)init {
    self = [super init];
    if (self) {
        self.time = @"2016-06-28 18:18:18.123";
        self.participateAmount = @"2人次";
    }
    return self;
}

@end
