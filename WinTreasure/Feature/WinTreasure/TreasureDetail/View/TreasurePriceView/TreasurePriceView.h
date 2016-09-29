//
//  TreasurePriceView.h
//  WinTreasure
//
//  Created by Apple on 16/6/20.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^PriceViewWinTreasureBlock)(void);

@interface TreasurePriceView : UIView

@property (nonatomic, copy) NSArray *data;

@property (nonatomic, copy) PriceViewWinTreasureBlock winTreasure;

+ (TreasurePriceView *)priceViewWithData:(NSArray *)data;
- (void)show;

@end
