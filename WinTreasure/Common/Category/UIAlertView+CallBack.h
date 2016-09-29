//
//  UIAlertView+CallBack.h
//  Linitial
//
//  Created by Haitao.Li on 15/2/2.
//  Copyright (c) 2015年 Linitial. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CompleteBlock) (NSInteger buttonIndex);

@interface UIAlertView (Block)

// 用Block的方式回调，这时候会默认用self作为Delegate
- (void)showAlertViewWithCompleteBlock:(CompleteBlock) block;

@end
