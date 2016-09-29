//
//  WinTreasureMenuHeader.h
//  WinTreasure
//
//  Created by Apple on 16/6/3.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import <UIKit/UIKit.h>
extern CGFloat kTSMenuHeight;

typedef void(^WinTreasureMenuHeaderBlock)(id object);
typedef void(^WinTreasureSortBlock)(void);

@interface WinTreasureMenuHeader : UICollectionReusableView

@property (nonatomic, copy) WinTreasureMenuHeaderBlock block;

@property (nonatomic, copy) WinTreasureSortBlock descBlock;

@property (nonatomic, copy) WinTreasureSortBlock aescBlock;

+ (CGFloat)menuHeight;

- (void)selectAMenu:(WinTreasureMenuHeaderBlock)block;

- (void)descend:(WinTreasureSortBlock)block;

- (void)aescend:(WinTreasureSortBlock)block;

@end

typedef void (^TSHomeMenuSelectedBlock)(id object);
typedef void(^TSHomeMenuAescBlock)(void);
typedef void(^TSHomeMenuDescBlock)(void);

@interface TSHomeMenu : UIView

@property (nonatomic, assign) NSInteger selectIndex;

@property (nonatomic, strong) NSArray *data;

@property (nonatomic, strong) CAShapeLayer *bottomLine;

@property (nonatomic, copy) TSHomeMenuSelectedBlock menuBlock;

@property (nonatomic, copy) TSHomeMenuDescBlock descBlock;

@property (nonatomic, copy) TSHomeMenuAescBlock aescBlock;

- (instancetype)initWithDataArray:(NSArray *)data;

@end
