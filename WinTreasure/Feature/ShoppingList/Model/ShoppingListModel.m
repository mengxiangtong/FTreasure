//
//  ShoppingListModel.m
//  WinTreasure
//
//  Created by Apple on 16/6/21.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import "ShoppingListModel.h"

@implementation ShoppingListModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.imgUrl = @"http://onegoods.nosdn.127.net/goods/1093/5095bc4b3f4228b69d6b58acf67cae1c.jpg";
        self.name = @"iPhone 6s 64G 玫瑰金 玫瑰金玫瑰金玫瑰金玫瑰金玫瑰金玫瑰金金";
        self.totalAmount = @"总需6400人次";
        self.leftAmount = @"剩余300人次";
        self.selectCount = @6;
        self.isChecked = NO;
        self.unitCost = @1;
    }
    return self;
}

@end
