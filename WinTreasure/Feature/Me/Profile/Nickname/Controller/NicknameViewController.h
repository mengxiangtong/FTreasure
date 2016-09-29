//
//  NicknameViewController.h
//  WinTreasure
//
//  Created by Apple on 16/6/22.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^NicknameModifyBlock)(NSString *name);

@interface NicknameViewController : BaseViewController

@property (copy, nonatomic) NicknameModifyBlock nicknameBlock;

@end
