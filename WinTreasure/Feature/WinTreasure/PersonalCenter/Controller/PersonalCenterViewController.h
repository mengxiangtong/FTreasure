//
//  PersonalCenterViewController.h
//  WinTreasure
//
//  Created by Apple on 16/6/14.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import "BaseViewController.h"

typedef NS_ENUM(NSUInteger, PersonalCenterRecordType) {
    PersonalCenterRecordLuckyType = 0,
    PersonalCenterRecordTreasureType,
    PersonalCenterRecordShareType,
    PersonalCenterRecordDreamType
};

@interface PersonalCenterViewController : BaseViewController

@property (nonatomic, assign) PersonalCenterRecordType type;

@end
