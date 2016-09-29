//
//  BonusModel.h
//  WinTreasure
//
//  Created by Apple on 16/6/17.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BonusModel : NSObject

/**红包金额
 */
@property (nonatomic, copy) NSString *bonusSum;

/**红包使用条件
 */
@property (nonatomic, copy) NSString *useCondition;

/**红包名称
 */
@property (nonatomic, copy) NSString *bonusName;

/**红包生效期
 */
@property (nonatomic, copy) NSString *effectiveTime;

/**红包有效期
 */
@property (nonatomic, copy) NSString *indate;

/**红包是否使用 0.未使用 1.已使用 2.已过期
 */
@property (nonatomic, assign) NSInteger bonusType;



@end
