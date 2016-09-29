//
//  TreasureDetailViewController.h
//  WinTreasure
//
//  Created by Apple on 16/6/3.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import "BaseViewController.h"
#import "TreasureDetailHeader.h"

@class WinTreasureModel;

typedef NS_ENUM(NSUInteger, TreasureDetailType) {
   TreasureDetailTypePublished = 0,
   TreasureDetailTypeToBePublished
};

@interface TreasureDetailViewController : BaseViewController

@property (nonatomic, assign) NSInteger count;

@property (nonatomic, strong) WinTreasureModel *model;

@property (nonatomic, assign) TreasureDetailHeaderType showType;

@end
