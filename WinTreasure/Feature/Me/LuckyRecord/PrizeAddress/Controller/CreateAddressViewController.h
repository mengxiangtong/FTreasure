//
//  CreateAddressViewController.h
//  WinTreasure
//
//  Created by Apple on 16/6/28.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import "BaseViewController.h"
@class AddressModel;

@interface CreateAddressViewController : BaseViewController

/**是否是登记领奖
 */
@property (nonatomic, assign) BOOL isSigned;

@property (strong, nonatomic) AddressModel *model;

@end
