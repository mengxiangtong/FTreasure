//
//  SectionHeader.h
//  WinTreasure
//
//  Created by Apple on 16/6/20.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SectionHeaderProductDetailBlock)(UIButton *sender);

@interface SectionHeader : UIView

@property (nonatomic, copy) NSNumber *goodsSum;

@property (nonatomic, copy) SectionHeaderProductDetailBlock checkDetailBlock;


+ (SectionHeader *)header;

+ (CGFloat)height;

@end

typedef void(^BonusSectionlBlock)(void);

@interface BonusSection : UIView

@property (nonatomic, copy) NSNumber *bonusSum;

@property (nonatomic, copy) BonusSectionlBlock checkBonus;

+ (BonusSection *)header;

@end

@interface SumSection : UIView

@property (nonatomic, copy) NSNumber *moneySum;


+ (SumSection *)header;

@end
