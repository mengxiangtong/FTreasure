//
//  DetailTreasureRecordHeader.h
//  WinTreasure
//
//  Created by Apple on 16/6/15.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemHeader : UIView

+ (id)loadFromXib;

+ (CGFloat)height;

@end

@interface DetailTreasureRecordHeader : UIView
/**产品名
 */
@property (strong, nonatomic) UILabel *nameLabel;

/**产品期号
 */
@property (strong, nonatomic) YYLabel *periodLabel;

/**参与人次
 */
@property (strong, nonatomic) YYLabel *paticipateLabel;


@end
