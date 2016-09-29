//
//  EditingCell.m
//  GentlyLove
//
//  Created by Apple on 16/3/9.
//  Copyright © 2016年 com.linitial. All rights reserved.
//

#import "EditingCell.h"

@implementation EditingCell

- (void)setCheckImageViewCenter:(CGPoint)pt alpha:(CGFloat)alpha animated:(BOOL)animated {
    if (animated) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.3];
        
        m_checkImageView.center = pt;
        m_checkImageView.alpha = alpha;
        
        [UIView commitAnimations];
    } else {
        m_checkImageView.center = pt;
        m_checkImageView.alpha = alpha;
    }
}

- (void)setEditing:(BOOL)editting animated:(BOOL)animated {
    if (self.editing == editting){
        return;
    }
    [super setEditing:editting animated:animated];
    if (editting) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundView = [[UIView alloc]init];
        self.backgroundView.backgroundColor = [UIColor whiteColor];
        self.textLabel.backgroundColor = [UIColor clearColor];
        self.detailTextLabel.backgroundColor = [UIColor clearColor];
        
        if (m_checkImageView == nil) {
            m_checkImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"未选中"]];
            [self addSubview:m_checkImageView];
        }
        
        [self setChecked:m_checked];
        m_checkImageView.center = CGPointMake(-CGRectGetWidth(m_checkImageView.frame) * 0.5,
                                              CGRectGetHeight(self.bounds) * 0.5);
        m_checkImageView.alpha = 0.0;
        [self setCheckImageViewCenter:CGPointMake(24.5, CGRectGetHeight(self.bounds) * 0.5)
                                alpha:1.0 animated:animated];
    } else {
        m_checked = NO;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundView = nil;
        
        if (m_checkImageView) {
            [self setCheckImageViewCenter:CGPointMake(-CGRectGetWidth(m_checkImageView.frame) * 0.5,
                                                      CGRectGetHeight(self.bounds) * 0.5)
                                    alpha:0.0
                                 animated:animated];
        }
    }
}

- (void)setChecked:(BOOL)checked {
    if (checked) {
        m_checkImageView.image = [UIImage imageNamed:@"选中"];
        self.backgroundView.backgroundColor = [UIColor whiteColor];
    } else {
        m_checkImageView.image = [UIImage imageNamed:@"未选中"];
        self.backgroundView.backgroundColor = [UIColor whiteColor];
    }
    m_checked = checked;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    m_checkImageView = nil;
}

@end
