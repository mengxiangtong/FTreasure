//
//  TreasureRecordModel.h
//  WinTreasure
//
//  Created by Apple on 16/6/2.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TreasureRecordModel : NSObject

@property (nonatomic, copy) NSString *productImgUrl;

@property (nonatomic, copy) NSString *productName;

/**期号
 */
@property (nonatomic, copy) NSString *periodNumber;

/**已参与人次
 */
@property (nonatomic, copy) NSString *partInTimes;

@property (nonatomic, copy) NSString *totalAmount;

@property (nonatomic, copy) NSString *leftAmount;

/**参与进度
 */
@property (nonatomic, copy) NSNumber *progress;

@property (nonatomic, copy) NSString *winner;

/**总参与人次
 */
@property (nonatomic, copy) NSString *winnerParticiTimes;

/**类型 0.全部 1.进行中 2.已揭晓
 */
@property (nonatomic, assign) NSInteger type;

@end
