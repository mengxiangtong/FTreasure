//
//  QuestionSection.m
//  WinTreasure
//
//  Created by Apple on 16/6/13.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import "QuestionSection.h"

const CGFloat kDefaultSectionHeight = 50.0;
const CGFloat kDefaultSectionPadding = 10.0;

@interface QuestionSection ()

@property (nonatomic, strong) UIButton *sectionButton;

@property (nonatomic, strong) CAShapeLayer *bottomLayer;

@end

@implementation QuestionSection

+ (QuestionSection *)section {
    QuestionSection *section = [[QuestionSection alloc]initWithFrame:({
        CGRect rect = {0, 0, kScreenWidth, kDefaultSectionHeight};
        rect;
    })];
    return section;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setup];
    }
    return self;
}

- (void)setup {
    _sectionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _sectionButton.origin = CGPointMake(kDefaultSectionPadding, 0);
    _sectionButton.size = CGSizeMake(kScreenWidth-kDefaultSectionPadding*2, kDefaultSectionHeight);
    _sectionButton.titleLabel.font = SYSTEM_FONT(16);
    _sectionButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _sectionButton.titleLabel.numberOfLines = 0;
    [_sectionButton setTitleColor:UIColorHex(333333) forState:UIControlStateNormal];
    [_sectionButton addTarget:self action:@selector(clickQuestion) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_sectionButton];
    
    _bottomLayer = [CAShapeLayer layer];
    _bottomLayer.backgroundColor = UIColorHex(0xe5e5e5).CGColor;
    [self.layer addSublayer:_bottomLayer];
}

- (void)clickQuestion {
    if (_clickBlock) {
        _clickBlock(_section);
    }
}

- (void)setQuestion:(NSString *)question {
    _question = question;
    [_sectionButton setTitle:_question forState:UIControlStateNormal];
    _sectionButton.height = [QuestionSection height:_question];
    _bottomLayer.origin = CGPointMake(0, [QuestionSection height:_question]-CGFloatFromPixel(0.5));
    _bottomLayer.size = CGSizeMake(kScreenWidth, CGFloatFromPixel(0.5));
}

+ (CGFloat)height:(NSString *)question {
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc]initWithString:question attributes:@{NSFontAttributeName:SYSTEM_FONT(16),NSForegroundColorAttributeName:UIColorHex(333333)}];
    CGSize size = [attString boundingRectWithSize:CGSizeMake(kScreenWidth-kDefaultSectionPadding*2, HUGE) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    return size.height+kDefaultSectionPadding*2;
}

@end
