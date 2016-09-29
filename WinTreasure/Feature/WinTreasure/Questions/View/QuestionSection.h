//
//  QuestionSection.h
//  WinTreasure
//
//  Created by Apple on 16/6/13.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^QuestionSectionBlock)(NSInteger section);

@interface QuestionSection : UIView

@property (nonatomic, copy) NSString *question;

@property (nonatomic, copy) QuestionSectionBlock clickBlock;

@property (nonatomic, assign) NSInteger section;

+ (QuestionSection *)section;

+ (CGFloat)height:(NSString *)question;

@end
