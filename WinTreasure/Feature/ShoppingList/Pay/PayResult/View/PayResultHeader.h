//
//  PayResultHeader.h
//  WinTreasure
//
//  Created by Apple on 16/6/22.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^PayResultHeaderBlock)(NSInteger index);

@interface PayResultHeader : UIView

@property (copy, nonatomic) PayResultHeaderBlock clickButton;

@end
