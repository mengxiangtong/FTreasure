//
//  CityModel.h
//  iLight
//
//  Created by Apple on 15/5/22.
//  Copyright (c) 2015年 linitial. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityModel : NSObject

@property (nonatomic) NSString *CityCode;
@property (nonatomic) NSString *CityId;
@property (nonatomic) NSString *CityPinyin;
@property (nonatomic) NSString *CityName;

@property (nonatomic) NSMutableArray *districArray;
- (id)initWithDictionary:(NSDictionary *)dic;

@end
