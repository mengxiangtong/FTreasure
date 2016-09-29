//
//  ProductModel.h
//  WinTreasure
//
//  Created by Apple on 16/7/11.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductModel : NSObject

@property (nonatomic, copy) NSString *imgs;

@property (nonatomic, copy) NSString *productName;

@property (nonatomic, copy) NSNumber *countTime;

@property (nonatomic, strong) NSMutableArray *imgUrls;

@end
