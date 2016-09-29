//
//  WinnerInfoModel.m
//  WinTreasure
//
//  Created by Apple on 16/6/27.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import "WinnerInfoModel.h"

@implementation WinnerInfoModel

- (instancetype)init {
    self = [super init];
    if (self) {
        self.name = @"王大锤";
        self.number = @"13886868686";
        self.address = @"广州市天河区XX路XX号XXXXX大厦XXXXXX房";
    }
    return self;
}

@end
