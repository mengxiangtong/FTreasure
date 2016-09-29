//
//  LogisticsModel.h
//  WinTreasure
//
//  Created by Apple on 16/6/28.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LogisticsModel : NSObject

@property (nonatomic, assign) BOOL isUpdated;

@property (nonatomic, copy) NSString *status;

@property (nonatomic, copy) NSString *time;

@property (nonatomic, copy) NSString *imgUrl;

/**物流公司
 */
@property (nonatomic, copy) NSString *logisticsInc;

/**物流订单编号
 */
@property (nonatomic, copy) NSString *orderNumber;

/**物流状态
 */
@property (nonatomic, copy) NSString *logisticsStatus;

/**配送地址
 */
@property (nonatomic, copy) NSString *recieverAddress;

/**收货人
 */
@property (nonatomic, copy) NSString *reciever;

/**收货人电话
 */
@property (nonatomic, copy) NSString *recieverPhone;

@property (nonatomic, strong) NSMutableArray *statusArray;

@end
