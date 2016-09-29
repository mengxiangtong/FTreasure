//
//  DreamListView.h
//  WinTreasure
//
//  Created by Apple on 16/6/21.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DreamListViewBlock)(void);

@interface DreamListView : UIView

@property (copy, nonatomic) DreamListViewBlock chooseDreamGift;

@end
