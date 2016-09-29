//
//  TreasureDetailHeader.h
//  WinTreasure
//
//  Created by Apple on 16/6/8.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TreaureHeaderMenu.h"
@class TSProgressView;
@class TSCountLabel;

typedef NS_ENUM(NSUInteger, TreasureDetailHeaderType) {
    TreasureDetailHeaderTypeNotParticipate = 0, //未参加
    TreasureDetailHeaderTypeCountdown, //倒计时
    TreasureDetailHeaderTypeWon, //已获奖
    TreasureDetailHeaderTypeParticipated //参加
};

typedef void(^TreasureDetailHeaderClickImageBlock)(id object);
typedef void(^TreasureDetailHeaderClickMenuButtonBlock)(id object);
typedef void(^TreasureDetailHeaderCountDetailButtonBlock)(void);

typedef void(^TreasureCountDetailButtonBlock)(void);

@interface TreasureProgressView : UIView

@property (nonatomic, assign) NSInteger countTime;

@property (nonatomic, assign) TreasureDetailHeaderType type;
/**期号
 */
@property (nonatomic, strong) YYLabel *periodNumberLabel;

/**倒计时label
 */
@property (nonatomic, strong) YYLabel *countLabel;

/**时间
 */
@property (nonatomic, strong) TSCountLabel *countDownLabel;

/**计算详情
 */
@property (nonatomic, strong) UIButton *countDetailButton;

/**进度
 */
@property (nonatomic, strong)  TSProgressView *progressView;

/**参与人次
 */
@property (nonatomic, strong) YYLabel *totalLabel;

/**剩余
 */
@property (nonatomic, strong) YYLabel *leftLabel;

/**揭晓时间
 */
@property (nonatomic, strong) YYLabel *publishTimeLabel;

/**用户ID
 */
@property (nonatomic, strong) YYLabel *IDLabel;

/**获奖者
 */
@property (nonatomic, strong) YYLabel *winnerLabel;

/**幸运号码
 */
@property (nonatomic, strong) YYLabel *luckyNumberLabel;

/**获奖者头像
 */
@property (nonatomic, strong) UIImageView *winnerImgView;

/**获奖者标志图片
 */
@property (nonatomic, strong) UIImageView *markImgView;

/**背景图片
 */
@property (nonatomic, strong) UIView *backImgView;

@property (nonatomic, strong) TreasureCountDetailButtonBlock block;

- (instancetype)initWithFrame:(CGRect)frame
                         type:(TreasureDetailHeaderType)type
                    countTime:(NSInteger)countTime;
- (void)start;

@end

/**是否已参与
 */
@interface ParticipateView : UIView

@property (nonatomic, strong) YYLabel *participateLabel;

@property (nonatomic, strong) YYLabel *numberLabel;

@property (nonatomic, assign) BOOL isParticipated;

- (instancetype)initWithFrame:(CGRect)frame
               isParticipated:(BOOL)isParticipated;

@end

@interface TreasureDetailHeader : UIView

/**是否参与视图
 */
@property (nonatomic, strong) ParticipateView *participateView;

@property (nonatomic, assign) TreasureDetailHeaderType type;

@property (nonatomic, copy) TreasureDetailHeaderClickImageBlock imageBlock;

@property (nonatomic, copy) TreasureDetailHeaderClickMenuButtonBlock clickMenuBlock;

/**计算详情
 */
@property (nonatomic, copy) TreasureDetailHeaderCountDetailButtonBlock countDetailBlock;

@property (nonatomic, strong) TreasureProgressView *treasureProgressView;

@property (nonatomic, strong) TreaureHeaderMenu *headerMenu;

@property (nonatomic, assign) NSInteger count;

- (instancetype)initWithFrame:(CGRect)frame
                         type:(TreasureDetailHeaderType)type
                    countTime:(NSInteger)countTime;
+ (CGFloat)getHeight;

@end
