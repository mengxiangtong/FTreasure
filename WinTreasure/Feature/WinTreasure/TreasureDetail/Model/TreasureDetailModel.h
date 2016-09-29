//
//  TreasureDetailModel.h
//  WinTreasure
//
//  Created by Apple on 16/6/23.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TreasureDetailModel : NSObject

/**图片路径
 */
@property (copy, nonatomic) NSString *imgUrl;

/**用户名
 */
@property (copy, nonatomic) NSString *nickname;

/**用户IP
 */
@property (copy, nonatomic) NSString *ipAddress;

/**参与次数
 */
@property (copy, nonatomic) NSNumber *partInTimes;

/**时间
 */
@property (copy, nonatomic) NSString *time;

@end
