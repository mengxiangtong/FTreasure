//
//  OrderView.h
//  WinTreasure
//
//  Created by Apple on 16/6/20.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^OrderViewBlock)(void);

@interface OrderView : UIView

@property (nonatomic, copy) NSNumber *payAmout;

@property (nonatomic, copy) OrderViewBlock block;

+ (CGFloat)height;


@end
