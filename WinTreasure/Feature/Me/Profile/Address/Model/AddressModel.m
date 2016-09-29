//
//  AddressModel.m
//  WinTreasure
//
//  Created by Apple on 16/6/22.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import "AddressModel.h"

@implementation AddressModel

- (instancetype)init {
    self = [super init];
    if (self) {
        self.name = @"王大锤";
        self.address = @"广州市天河区XX路XX号XXXXX大厦XXX房";
        self.phone = @"135*****3455";
    }
    return self;
}

@end
