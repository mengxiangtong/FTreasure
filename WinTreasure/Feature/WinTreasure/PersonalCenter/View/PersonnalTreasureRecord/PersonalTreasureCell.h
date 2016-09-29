//
//  PersonalCenterCell.h
//  WinTreasure
//
//  Created by Apple on 16/6/14.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ResultViewType) {
    ResultViewTypeUnPublished, //未揭晓
    ResultViewTypePublished, //已揭晓
    ResultViewTypeNotFull,  //人数未满
};

@interface ResultView : UIView

/**获奖者
 */
@property (nonatomic, strong) YYLabel *nameLabel;

/**参与人次
 */
@property (nonatomic, strong) YYLabel *totalLabel;

/**即将揭晓
 */
@property (nonatomic, strong) YYLabel *publishLabel;

/**即将揭晓
 */
@property (nonatomic, strong) UIImageView *publishImageView;

/**购买
 */
@property (nonatomic, strong) UIButton *buyButton;

@property (nonatomic, assign) ResultViewType type;

- (instancetype)initWithFrame:(CGRect)frame type:(ResultViewType)type;

@end

@interface PersonalTreasureCell : UITableViewCell

@property (nonatomic, strong) UIImageView *productImageView;

@property (nonatomic, strong) YYLabel *productNameLabel;

@property (nonatomic, strong) YYLabel *periodNumberLabel;

@property (nonatomic, strong) YYLabel *participateLabel;

+ (instancetype)cellWithTableView:(UITableView *)tableview;

@end












