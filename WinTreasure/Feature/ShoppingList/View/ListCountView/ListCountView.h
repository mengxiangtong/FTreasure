//
//  ChangeListCountView.h
//  WinTreasure
//
//  Created by Apple on 16/6/20.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopListKeyBoard : UIView

@property (nonatomic, strong) UIButton *previousButton;

@property (nonatomic, strong) UIButton *nextButton;

@end


@interface ListCountView : UIView

/**加
 */
@property (nonatomic, strong) UIButton *plusButton;

/**减
 */
@property (nonatomic, strong) UIButton *minusButton;

/**已选数
 */
@property (nonatomic, assign) NSInteger selectedCount;

/**总数
 */
@property (nonatomic, assign) NSInteger totalCount;

@property (nonatomic, copy) void (^latestCount)(NSNumber *listCount);


- (void)resignFirstRespond;

- (void)setSelectedCount:(NSInteger)selectedCount
              totalCount:(NSInteger)totalCount;
@end
