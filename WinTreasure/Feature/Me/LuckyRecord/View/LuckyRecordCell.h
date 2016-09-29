//
//  LuckyRecordCell.h
//  WinTreasure
//
//  Created by Apple on 16/6/27.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LuckyRecordLayout.h"
@class PrizeView;

typedef NS_ENUM(NSUInteger, PrizeViewType) {
    PrizeViewTypeSigned,
    PrizeViewTypeUnSigned,
};

@protocol LuckyRecordCellDelegate;

@interface LuckyRecordCell : UITableViewCell

@property (nonatomic, strong) YYLabel *nameLabel;

@property (nonatomic, strong) YYLabel *periodNumberLabel;

@property (nonatomic, strong) YYLabel *totalLabel;

@property (nonatomic, strong) YYLabel *luckyNumberLabel;

@property (nonatomic, strong) YYLabel *participateLabel;

@property (nonatomic, strong) YYLabel *timeLabel;

@property (nonatomic, strong) UIImageView *productImgView;

@property (nonatomic, strong) PrizeView *prizeView;

@property (nonatomic, strong) LuckyRecordLayout *layout;

@property (nonatomic, weak) id<LuckyRecordCellDelegate>delegate;

+ (instancetype)cellWithTableView:(UITableView *)tableview;

@end

@protocol LuckyRecordCellDelegate <NSObject>

@optional
- (void)signButtonClickedCell:(LuckyRecordCell *)cell;
- (void)shareButtonClickedCell:(LuckyRecordCell *)cell;
- (void)logisticButtonClickedCell:(LuckyRecordCell *)cell;

@end

@interface PrizeView : UIView

@property (nonatomic, strong) YYLabel *signedLabel;

@property (nonatomic, strong) UIButton *shareButton;

@property (nonatomic, strong) UIButton *logisticsButton;

@property (nonatomic, strong) UIButton *signButton;

@property (nonatomic, assign) PrizeViewType type;

@property (nonatomic, weak) LuckyRecordCell *cell;


- (instancetype)initWithFrame:(CGRect)frame type:(PrizeViewType)type;

@end










