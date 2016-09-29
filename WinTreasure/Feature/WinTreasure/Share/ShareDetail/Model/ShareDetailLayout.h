//
//  ShareDetailLayout.h
//  WinTreasure
//
//  Created by Apple on 16/7/5.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShareModel.h"

#define kShareDetailPadding 12.0 //左右 上部留白
#define kShareDetailContentWidth kScreenWidth-kShareDetailPadding*2 //内容最大宽度
#define kProductInfoMargin 3 //产品信息标签上下留白

@interface ShareDetailLayout : NSObject

@property (nonatomic, assign) CGFloat marginTop;

@property (nonatomic, assign) CGFloat marginBottom;

@property (nonatomic, assign) CGFloat titleHeight;

@property (nonatomic, strong) YYTextLayout *titleTextLayout; // 标题栏

@property (nonatomic, assign) CGFloat nameHeight;

@property (nonatomic, strong) YYTextLayout *nameTextLayout;

@property (nonatomic, strong) YYTextLayout *timeTextLayout;

@property (nonatomic, assign) CGFloat productNameHeight;

@property (nonatomic, strong) YYTextLayout *productNameTextLayout; // 产品名称

@property (nonatomic, assign) CGFloat periodHeight;

@property (nonatomic, strong) YYTextLayout *periodTextLayout; // 期号

@property (nonatomic, assign) CGFloat paticipateHeight;

@property (nonatomic, strong) YYTextLayout *paticipateLayout;

@property (nonatomic, assign) CGFloat luckyNumberHeight;

@property (nonatomic, strong) YYTextLayout *luckyNumberLayout;

@property (nonatomic, assign) CGFloat publishTimeHeight;

@property (nonatomic, strong) YYTextLayout *publishTimeLayout;

@property (nonatomic, assign) CGFloat contentHeight;

@property (nonatomic, strong) YYTextLayout *contentTextLayout; //文本

@property (nonatomic, assign) CGFloat infoHeight;

@property (nonatomic, assign) CGFloat picHeight;

@property (nonatomic, assign) CGSize picSize; //图片宽高

@property (nonatomic, strong) ShareModel *model;

@property (nonatomic, assign) CGFloat height;

- (instancetype)initWithModel:(ShareModel *)model;

@end
