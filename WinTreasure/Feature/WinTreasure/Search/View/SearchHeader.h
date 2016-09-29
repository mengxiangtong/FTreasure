//
//  SearchHeader.h
//  WinTreasure
//
//  Created by Apple on 16/6/24.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SearchHeaderBlock)(UIButton *sender);

@interface SearchHeader : UIScrollView

@property (nonatomic, copy) NSArray *data;

@property (nonatomic, copy) SearchHeaderBlock clickHotProduct;

- (instancetype)initWithData:(NSArray *)data;

+ (CGFloat)height;

@end


