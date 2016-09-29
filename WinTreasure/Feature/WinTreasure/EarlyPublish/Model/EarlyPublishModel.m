//
//  EarlyPublishModel.m
//  WinTreasure
//
//  Created by Apple on 16/6/29.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import "EarlyPublishModel.h"

@implementation EarlyPublishModel

- (instancetype)init {
    self = [super init];
    if (self) {
        self.winnerImgUrl = @"https://tse4-mm.cn.bing.net/th?id=OIP.M9271c634f71d813901afbc9e69602dcfo2&pid=15.1";
        self.periodNumber = @"300003200";
        self.publishTime = @"2016-06-26 16:26:36";
        self.winner = @"Scarllet JohannsonScarllet JohannsonScarllet JohannsonScarllet JohannsonScarllet Johannson";
        self.luckyNumber = @"1000041";
        self.userIP = @"好莱坞 IP:1.1.1.1";
        self.userID = @"100001";
        self.partInAmount = @"9999";
    }
    return self;
}
@end
