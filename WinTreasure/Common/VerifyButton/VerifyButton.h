//
//  VerifyButton.h
//  DJW
//
//  Created by Haitao.Li on 15/2/3.
//  Copyright (c) 2015年 Pactera. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VerifyButton;
@protocol VerifyButtonDelegate <NSObject>

@optional
//please remember invalidate timer when push
- (void)verifyButton:(VerifyButton *)wBtn WillBeginTimer:(BOOL)isTimeOn;
- (void)verifyButton:(VerifyButton *)wBtn WillEndTimer:(BOOL)isTimeOn;

@end

@interface VerifyButton : UIButton


@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, assign) BOOL timeStart;
@property (nonatomic, assign) id<VerifyButtonDelegate>delegate;

@property (nonatomic, copy) NSString *normalTitle;
@property (nonatomic, copy) NSString *verifyTitle;

- (void)beginTimer;
- (void)stoptimer;
- (void)refreshTimer;


@end
