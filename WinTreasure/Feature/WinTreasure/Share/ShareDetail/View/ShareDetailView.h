//
//  ShareDetailView.h
//  WinTreasure
//
//  Created by Apple on 16/7/5.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShareDetailLayout.h"


@interface ProductInfoView : UIView

/**产品名称
 */
@property (nonatomic, strong) YYLabel *productNameLabel;

/**产品期号
 */
@property (nonatomic, strong) YYLabel *periodLabel;
/**本期参与
 */
@property (nonatomic, strong) YYLabel *participateLabel;

/**幸运号码
 */
@property (nonatomic, strong) YYLabel *luckyNumberLabel;

/**揭晓时间
 */
@property (nonatomic, strong) YYLabel *publishTimeLabel;

@property (nonatomic, strong) ShareDetailLayout *layout;

@end


@interface ShareDetailView : UIView

@property (nonatomic, strong) UIView *containerView;

/**用户名
 */
@property (nonatomic, strong) YYLabel *usernameLabel;

/**晒单时间
 */
@property (nonatomic, strong) YYLabel *timeLabel;

/**分享标题
 */
@property (nonatomic, strong) YYLabel *headLabel;

/**分享内容
 */
@property (nonatomic, strong) YYLabel *contentLabel;

@property (nonatomic, strong) NSArray<UIView *> *picViews;

@property (nonatomic, strong) ProductInfoView *infoView;

@property (nonatomic, strong) ShareDetailLayout *layout;

- (void)setLayout:(ShareDetailLayout *)layout;

- (void)_hideImageViews;

@end




