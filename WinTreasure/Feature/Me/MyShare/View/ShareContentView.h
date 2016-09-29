//
//  ShareContentView.h
//  WinTreasure
//
//  Created by Apple on 16/6/24.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ShareContentViewBlock)(void);

@interface ShareContentView : UIScrollView

@property (copy, nonatomic) ShareContentViewBlock addSharingImage;

@property (nonatomic, strong) UIImageView *picImageView;

@end
