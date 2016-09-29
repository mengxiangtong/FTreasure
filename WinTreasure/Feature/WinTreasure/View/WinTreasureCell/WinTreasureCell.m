//
//  WinTreasureCell.m
//  WinTreasure
//
//  Created by Apple on 16/5/31.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import "WinTreasureCell.h"
#import "TSProgressView.h"

#define kWinTreasureCellImagePadding 12.0

@interface WinTreasureCell ()

@property (weak, nonatomic) IBOutlet TSProgressView *progressView;

@end

@implementation WinTreasureCell

- (void)awakeFromNib {
    [super awakeFromNib];

    _addListButton.layer.cornerRadius = 4.0;
    _addListButton.layer.borderWidth = CGFloatFromPixel(0.6);
    _addListButton.layer.borderColor = kDefaultColor.CGColor;
    _addListButton.layer.masksToBounds = YES;
    _addListButton.layer.shouldRasterize = YES;
    _addListButton.layer.rasterizationScale = kScreenScale;
}

- (IBAction)addList:(UIButton *)sender {
    if (_delegate&&[_delegate respondsToSelector:@selector(addShoppingList:indexPath:)]) {
        [_delegate addShoppingList:self indexPath:_indexPath];
    }
}

- (void)setModel:(WinTreasureModel *)model {
    _model = model;
    _nameLabel.text = _model.productName;
    [_productImgView setImageWithURL:[NSURL URLWithString:_model.productImgUrl] options:YYWebImageOptionProgressiveBlur];
    NSMutableAttributedString *attrProgress = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"揭晓进度 %@%%",_model.publishProgress]];
    [attrProgress setColor:UIColorHex(0x007AFF) range:NSMakeRange(5, _model.publishProgress.length+1)];
    _progressLabel.attributedText = attrProgress;

    _progressView.progress = [_model.publishProgress integerValue];
}

+ (CGSize)size {
    CGFloat imgHeight = ((kScreenWidth-0.5)/2.0-kWinTreasureCellImagePadding)*0.8;
    CGFloat nameHeight = 30;
    CGFloat progressHeight = 15;
    CGFloat tsViewHeight = 8.0;
    CGFloat height =  kImageMargin*4.0+imgHeight+nameHeight+progressHeight+2+tsViewHeight;
    return CGSizeMake((kScreenWidth-0.5)/2.0, height);
}

@end
