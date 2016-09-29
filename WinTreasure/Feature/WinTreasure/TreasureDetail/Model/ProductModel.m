//
//  ProductModel.m
//  WinTreasure
//
//  Created by Apple on 16/7/11.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import "ProductModel.h"

@implementation ProductModel

- (NSMutableArray *)imgUrls {
    if (!_imgUrls) {
        _imgUrls = [NSMutableArray array];
    }
    return _imgUrls;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

@end
