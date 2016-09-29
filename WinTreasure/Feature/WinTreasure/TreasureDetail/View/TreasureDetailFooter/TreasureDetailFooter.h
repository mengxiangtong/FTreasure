//
//  TreasureDetailFooter.h
//  WinTreasure
//
//  Created by Apple on 16/6/23.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, TreasureDetailFooterType) {
    TreasureUnPublishedType = 0,
    TreasurePublishedType
};

typedef void(^TreasureDetailPublishedBlock)(void);
typedef void(^TreasureDetailUnPublishedBlock)(NSInteger index);

@protocol TreasureDetailFooterDelegate;

@interface TreasureDetailFooter : UIView

@property (assign, nonatomic) TreasureDetailFooterType type;

@property (copy, nonatomic) TreasureDetailPublishedBlock checkNewTreasre;

@property (copy, nonatomic) TreasureDetailUnPublishedBlock goTreasure;

@property (weak, nonatomic) id<TreasureDetailFooterDelegate>delegate;

- (instancetype)initWithType:(TreasureDetailFooterType)type;

@end

@protocol TreasureDetailFooterDelegate <NSObject>

@optional;
- (void)checkNewTreasre;
- (void)clickMenuButtonWithIndex:(NSInteger)index;

@end
