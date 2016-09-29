//
//  PayResultModel.m
//  WinTreasure
//
//  Created by Apple on 16/6/22.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import "PayResultModel.h"

@implementation PayResultModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.productName = @"iPhone6s 4.7英寸 16G 新旧包装随机发放";
        self.periodNumber = @"商品期号:30520053";
        self.paticipateNumber = @"1人次";
        self.treasureNumber = @"夺宝号码:1000053";
    }
    return self;
}

@end
