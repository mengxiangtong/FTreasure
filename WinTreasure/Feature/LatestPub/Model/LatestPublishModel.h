//
//  LatestPublishModel.h
//  WinTreasure
//
//  Created by Apple on 16/6/16.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import <Foundation/Foundation.h>
#define NOTIFICATION_TIME_CELL  @"NotificationTimeCell"

@interface LatestPublishModel : NSObject

@property (nonatomic, copy) NSString *imgUrl;

@property (nonatomic, copy) NSString *productName;

@property (nonatomic, copy) NSString *periodNumber;

@property (nonatomic, copy) NSNumber *countTime;

/**获奖者
 */
@property (nonatomic, copy) NSString *winner;

/**参与次数
 */
@property (nonatomic, copy) NSString *partInTimes;

/**幸运号码
 */
@property (nonatomic, copy) NSString *luckyNumber;

/**揭晓时间
 */
@property (nonatomic, copy) NSString *publishTime;


@property (nonatomic, assign) BOOL isRunning;

@property (nonatomic, assign) NSInteger startValue;

@property (nonatomic, assign) NSInteger currentValue;

@property (strong, nonatomic) NSString *valueString;

- (void)start;

@end
