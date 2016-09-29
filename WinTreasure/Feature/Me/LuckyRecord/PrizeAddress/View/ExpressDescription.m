//
//  ExpressDescription.m
//  WinTreasure
//
//  Created by Apple on 16/6/28.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import "ExpressDescription.h"

@interface ExpressDescription ()

@property (nonatomic, strong) YYLabel *descriptLabel;

@end

@implementation ExpressDescription

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColorHex(0xeeeeee);
        YYLabel *label = [YYLabel new];
        label.origin = CGPointMake(20, 20);
        label.size = CGSizeMake(kScreenWidth-20*2, 16);
        label.font = SYSTEM_FONT(15);
        label.textColor = UIColorHex(333333);
        label.text = @"快递说明:";
        [self addSubview:label];
        
        _descriptLabel = [YYLabel new];
        _descriptLabel.origin = CGPointMake(label.left, label.bottom+10);
        _descriptLabel.size = CGSizeMake(kScreenWidth-20*2, 18);
        [self addSubview:_descriptLabel];
    }
    return self;
}

- (void)setDescript:(NSString *)descript {
    _descript = descript;
    if (!_descript) {
        _descript = @"奖品商家会在3个工作日内发出，快递为顺丰到付，登机后请留意物流动态。";
    }
    ExpressDescriptionPositionModifier *modifier = [ExpressDescriptionPositionModifier new];
    modifier.font = SYSTEM_FONT(15);
    modifier.paddingTop = 0;
    modifier.paddingBottom = 0;
    NSMutableAttributedString *attrDescript = [[NSMutableAttributedString alloc]initWithString:_descript];
    attrDescript.font = SYSTEM_FONT(15);
    attrDescript.color = UIColorHex(666666);
    YYTextContainer *textContainer = [YYTextContainer containerWithSize:CGSizeMake(kScreenWidth-20*2, HUGE)];
    textContainer.size = CGSizeMake(kScreenWidth-20*2, HUGE);
    textContainer.linePositionModifier = modifier;
    textContainer.maximumNumberOfRows = 0;
    YYTextLayout *textLayout = [YYTextLayout layoutWithContainer:textContainer text:attrDescript];
    _descriptLabel.textLayout = textLayout;
    _descriptLabel.height = [modifier heightForLineCount:textLayout.rowCount];
    self.height = _descriptLabel.bottom+20;
}

@end

@implementation ExpressDescriptionPositionModifier

- (instancetype)init {
    self = [super init];
    
    if (kiOS9Later) {
        _lineHeightMultiple = 1.34;   // for PingFang SC
    } else {
        _lineHeightMultiple = 1.3125; // for Heiti SC
    }
    
    return self;
}

- (void)modifyLines:(NSArray *)lines fromText:(NSAttributedString *)text inContainer:(YYTextContainer *)container {
    //CGFloat ascent = _font.ascender;
    CGFloat ascent = _font.pointSize * 0.86;
    
    CGFloat lineHeight = _font.pointSize * _lineHeightMultiple;
    for (YYTextLine *line in lines) {
        CGPoint position = line.position;
        position.y = _paddingTop + ascent + line.row  * lineHeight;
        line.position = position;
    }
}

- (id)copyWithZone:(NSZone *)zone {
    ExpressDescriptionPositionModifier *one = [self.class new];
    one->_font = _font;
    one->_paddingTop = _paddingTop;
    one->_paddingBottom = _paddingBottom;
    one->_lineHeightMultiple = _lineHeightMultiple;
    return one;
}

- (CGFloat)heightForLineCount:(NSUInteger)lineCount {
    if (lineCount == 0) return 0;
    //    CGFloat ascent = _font.ascender;
    //    CGFloat descent = -_font.descender;
    CGFloat ascent = _font.pointSize * 0.86;
    CGFloat descent = _font.pointSize * 0.14;
    CGFloat lineHeight = _font.pointSize * _lineHeightMultiple;
    return _paddingTop + _paddingBottom + ascent + descent + (lineCount - 1) * lineHeight;
}



@end
