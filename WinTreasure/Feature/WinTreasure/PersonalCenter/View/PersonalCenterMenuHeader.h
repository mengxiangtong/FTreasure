//
//  PersonalCenterMenuHeader.h
//  WinTreasure
//
//  Created by Apple on 16/6/14.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import <UIKit/UIKit.h>

extern CGFloat kTSMenuHeight;

typedef void(^PersonalCenterMenuHeaderBlock)(id object);

@interface PersonalCenterMenuHeader : UIView

@property (nonatomic, copy) PersonalCenterMenuHeaderBlock block;

+ (CGFloat)menuHeight;

- (void)selectAMenu:(PersonalCenterMenuHeaderBlock)block;

@end
