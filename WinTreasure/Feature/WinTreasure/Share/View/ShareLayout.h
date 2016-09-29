//
//  ShareLayout.h
//  WinTreasure
//
//  Created by Apple on 16/6/8.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShareModel.h"

#define kShareCellMarginBottom 10.0 //cell底部留白
#define kHeadImageViewMargin 8.0    //头像上部/左侧留白
#define kHeadImageViewWidth 60.0    //头像直径
#define kUserNameLabelTopMargin 16.0 //昵称上部留白
#define kUserNameLabelWidth kScreenWidth - kHeadImageViewMargin * 2 - kHeadImageViewMargin-kHeadImageViewWidth-kTimeLabelWidth //昵称最宽
#define kTimeLabelWidth 100.0 //时间最宽限制
#define kTimeLabelRightMargin 10.0 //时间右侧留白
#define kHeadLabelLeftMargin 16.0 //标题左侧/上部留白
#define kContentViewWidth  kScreenWidth-(kHeadImageViewMargin+kHeadImageViewWidth+kHeadImageViewMargin) //内容视图宽度
#define kContentLabelWidth  kScreenWidth-kHeadLabelLeftMargin-kHeadImageViewMargin-kHeadImageViewWidth-kTimeLabelRightMargin //内容宽度
#define kContentImageWidth  70.0 //晒单图片宽度
#define kContentImagePadding  5.0 //多张图片留白
#define kContentViewMargin  10.0 //内容视图留白


@interface ShareLayout : NSObject

@property (nonatomic, strong) ShareModel *model;

@property (nonatomic, assign) CGFloat marginTop; //顶部灰色留白

@property (nonatomic, assign) CGFloat marginBottom; //下边留白

@property (nonatomic, assign) CGFloat profileHeight; //个人资料高度(包括留白)

@property (nonatomic, strong) YYTextLayout *nameTextLayout;

@property (nonatomic, strong) YYTextLayout *timeTextLayout;

// 文本
@property (nonatomic, assign) CGFloat titleHeight;

@property (nonatomic, strong) YYTextLayout *titleTextLayout; // 标题栏

@property (nonatomic, assign) CGFloat periodHeight;

@property (nonatomic, strong) YYTextLayout *periodTextLayout; // 期号

@property (nonatomic, assign) CGFloat productNameHeight;

@property (nonatomic, strong) YYTextLayout *productNameTextLayout; // 产品名称

@property (nonatomic, assign) CGFloat contentHeight; //文本高度(包括下方留白)

@property (nonatomic, strong) YYTextLayout *contentTextLayout; //文本

@property (nonatomic, assign) CGFloat picHeight; //图片高度，0为没图片

@property (nonatomic, assign) CGSize picSize; //图片宽高

// 总高度
@property (nonatomic, assign) CGFloat height;

- (instancetype)initWithModel:(ShareModel *)model;

@end

@interface ShareContentLinePositionModifier : NSObject <YYTextLinePositionModifier>

@property (nonatomic, strong) UIFont *font; // 基准字体 (例如 Heiti SC/PingFang SC)
@property (nonatomic, assign) CGFloat paddingTop; //文本顶部留白
@property (nonatomic, assign) CGFloat paddingBottom; //文本底部留白
@property (nonatomic, assign) CGFloat lineHeightMultiple; //行距倍数
- (CGFloat)heightForLineCount:(NSUInteger)lineCount;

@end
