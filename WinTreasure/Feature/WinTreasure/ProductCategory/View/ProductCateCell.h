//
//  ProductCateCell.h
//  WinTreasure
//
//  Created by Apple on 16/6/3.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductCateCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;

@property (weak, nonatomic) IBOutlet UIImageView *imgView;

+ (instancetype)cellWithTableView:(UITableView *)tableview;

+ (CGFloat)height;

@end

@interface ProductAllCateCell : UITableViewCell

@property (nonatomic, strong) UIImageView *imgView;

@property (nonatomic, strong) YYLabel *allProductLabel;

+ (instancetype)cellWithTableView:(UITableView *)tableview;

+ (CGFloat)height;

@end

@interface CategoryCell : UITableViewCell

@property (nonatomic, strong) UIImageView *imgView;

@property (nonatomic, strong) YYLabel *categoryLabel;

+ (instancetype)cellWithTableView:(UITableView *)tableview;

+ (CGFloat)height;

@end;
