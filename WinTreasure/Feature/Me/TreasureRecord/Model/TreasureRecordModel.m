//
//  TreasureRecordModel.m
//  WinTreasure
//
//  Created by Apple on 16/6/2.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import "TreasureRecordModel.h"

@implementation TreasureRecordModel

- (instancetype)init {
    self = [super init];
    if (self) {
        self.productImgUrl = @"http://images2.fanpop.com/image/photos/8800000/Scarlett-Johansson-scarlett-johansson-8836648-2478-1650.jpg";
        self.productName = @"这是一个产品名字";
        self.periodNumber = @"30092523";
        self.totalAmount = @"9999";
        self.leftAmount = @"1000";
        self.partInTimes = @"99";
        self.progress = @(([self.totalAmount integerValue]-[self.leftAmount integerValue])*1.0/[self.totalAmount integerValue]*100.0);
        self.type = 0;
        self.winner = @"无敌浩克";
        self.winnerParticiTimes = @"4";
    }
    return self;
}

@end
