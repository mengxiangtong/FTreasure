//
//  ShoppingListModel.h
//  WinTreasure
//
//  Created by Apple on 16/6/21.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShoppingListModel : NSObject

@property (nonatomic, assign) BOOL isChecked;

@property (nonatomic, copy) NSString *imgUrl;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *totalAmount;

@property (nonatomic, copy) NSString *leftAmount;

@property (nonatomic, copy) NSNumber *selectCount;

@property (nonatomic, copy) NSNumber *unitCost;

@end
