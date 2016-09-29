//
//  CategoryModel.h
//  WinTreasure
//
//  Created by Apple on 16/6/23.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CategoryModel : NSObject <NSCopying>

@property (nonatomic, copy) NSString *productImgUrl;

@property (nonatomic, copy) NSString *productName;

@property (nonatomic, copy) NSNumber *publishProgress;

@property (nonatomic, copy) NSNumber *totalAmount;

@property (nonatomic, copy) NSNumber *leftAmount;

@property (nonatomic, assign) BOOL isSelected;

@end
