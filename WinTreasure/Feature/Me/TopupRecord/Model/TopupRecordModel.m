//
//  TopupModel.m
//  WinTreasure
//
//  Created by Apple on 16/6/17.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import "TopupRecordModel.h"

@implementation TopupRecordModel

- (instancetype)init {
    self = [super init];
    if (self) {
        self.topupAmount = @"14元";
        self.topupTime = @"2016-06-12 16:08:34";
        self.topupWay = @"微信支付";
        self.isTopup = YES;
    }
    return self;
}

@end
