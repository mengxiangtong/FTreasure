//
//  ProductDetailCell.h
//  WinTreasure
//
//  Created by Apple on 16/7/4.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductDetailLayout.h"

@interface ProductDetailCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *productImgView;

@property (strong, nonatomic) ProductDetailLayout *layout;

+ (instancetype)cellWithTableView:(UITableView *)tableview;

@end
