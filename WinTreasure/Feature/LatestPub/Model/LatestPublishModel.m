//
//  LatestPublishModel.m
//  WinTreasure
//
//  Created by Apple on 16/6/16.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import "LatestPublishModel.h"

@interface LatestPublishModel ()

@property (nonatomic, assign) unsigned long value;

@property (nonatomic, assign) unsigned long resetValue;

@property (nonatomic, assign) double startTime;

@property (strong, nonatomic) NSTimer *timer;

@property (nonatomic, assign) BOOL running;

@end

@implementation LatestPublishModel

- (instancetype)init {
    self = [super init];
    if (self) {
        self.imgUrl = @"https://tse4-mm.cn.bing.net/th?id=OIP.M9271c634f71d813901afbc9e69602dcfo2&pid=15.1";
        self.productName = @"斯嘉丽·约翰逊(Scarlett Johansson),1984年11月22日生于纽约，美国女演员。";
        self.periodNumber = @"期号：32432445";
        self.startValue = 36000;
        self.winner = @"起什么名能中奖";
        self.partInTimes = @"20次";
        self.luckyNumber = @"1000043";
        self.publishTime = @"今天12:12";
        self.startTime = CFAbsoluteTimeGetCurrent();
    }
    return self;
}

#pragma mark - Setters

- (void)setValue:(unsigned long)value {
    _value = value;
    self.currentValue = _value;

    [self updateDisplay];
}

- (void)setStartValue:(NSInteger)startValue {
    _startValue = startValue;
    [self setValue:startValue];
}

- (void)updateDisplay {

    if ( _value < 100) {
        [self stop];
        self.valueString = @"00:00:00";
    } else {
        self.valueString = [self timeFormattedStringForValue:_value];
    }
}

- (void)start {
    if (self.running) return;
    
    self.startTime = CFAbsoluteTimeGetCurrent();
    
    self.running = YES;
    self.isRunning = self.running;
    
    self.timer = [NSTimer timerWithTimeInterval:0.02
                                         target:self
                                       selector:@selector(clockDidTick)
                                       userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)clockDidTick {
    double currentTime = CFAbsoluteTimeGetCurrent();
    double elapsedTime = currentTime - self.startTime;
    unsigned long milliSecs = (unsigned long)(elapsedTime * 1000);
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_TIME_CELL object:nil];
    [self setValue:(_startValue - milliSecs)];
}

- (void)stop {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
        
        _startValue = self.value;
    }
    
    self.running = NO;
    self.isRunning = self.running;
}

- (void)reset {
    [self stop];
    
    self.startValue = self.resetValue;
    [self setValue:self.resetValue];
}

- (void)updateApperance {
    [self setValue:_currentValue];
}

- (NSString *)timeFormattedStringForValue:(unsigned long)value {
    int msperhour = 3600000;
    int mspermin = 60000;
    
    int hrs = (int)value / msperhour;
    int mins = (value % msperhour) / mspermin;
    int secs = ((value % msperhour) % mspermin) / 1000;
    int frac = value % 1000 / 10;
    
    NSString *formattedString = @"";
    
    if (hrs == 0) {
        if (mins == 0) {
            formattedString = [NSString stringWithFormat:@"%02d:%02d:%02d",hrs, secs, frac];
        } else {
            formattedString = [NSString stringWithFormat:@"%02d:%02d:%02d", mins, secs, frac];
        }
    } else {
        formattedString = [NSString stringWithFormat:@"%02d:%02d:%02d:%02d", hrs, mins, secs, frac];
    }
    
    return formattedString;
}


@end
