//
//  TreasureRecordViewController.h
//  WinTreasure
//
//  Created by Apple on 16/6/2.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import "BaseViewController.h"

extern CGFloat kTSMenuHeight;

typedef NS_ENUM(NSInteger, TreasureRecordType) {
    TreasureRecordTypeInProceed = 0,// 正在进行
    TreasureRecordTypePublished,// 已经揭晓
    TreasureRecordTypePaticipated, //多期参与
};

@interface TreasureRecordViewController : BaseViewController

@property (nonatomic, assign) TreasureRecordType recordType;

@end
