//
//  ShoppingListCell.m
//  WinTreasure
//
//  Created by Apple on 16/6/6.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import "ShoppingListCell.h"
#import "ListCountView.h"

@interface ShoppingListCell () <UITextFieldDelegate>

/**商品图片
 */
@property (nonatomic, strong) UIImageView *productImgView;

/**商品名称
 */
@property (nonatomic, strong) YYLabel *productNameLabel;

/**商品总量
 */
@property (nonatomic, strong) YYLabel *productCountLabel;



@end



@implementation ShoppingListCell

+ (instancetype)cellWithTableView:(UITableView *)tableview {
    static NSString *cellID = @"ShoppingListCell";
    ShoppingListCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[ShoppingListCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
            [self setLayoutMargins:UIEdgeInsetsZero];
        }
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _productImgView = [UIImageView new];
        _productImgView.origin = CGPointMake(kProductImagePadding, 15);
        _productImgView.size = CGSizeMake(kProductImageDefaultHeight, kProductImageDefaultHeight);
        _productImgView.backgroundColor = UIColorHex(0xeeeeee);
        [self.contentView addSubview:_productImgView];
        
        _productNameLabel = [YYLabel new];
        _productNameLabel.origin = CGPointMake(_productImgView.right+kProductImagePadding, 15);
        _productNameLabel.size = CGSizeMake(kProductNameWidth, 39);
        [self.contentView addSubview:_productNameLabel];

        _productCountLabel = [YYLabel new];
        _productCountLabel.origin = CGPointMake(_productImgView.right+12, _productNameLabel.bottom+10);
        _productCountLabel.size = CGSizeMake(kProductNameWidth, 16);
        [self.contentView addSubview:_productCountLabel];

        _listView = [[ListCountView alloc]initWithFrame:({
            CGRect rect = {_productImgView.right+12,_productCountLabel.bottom+10,kChangeListViewWidth,kCountViewDefaultHeight};
            rect;
        })];
        [self.contentView addSubview:_listView];
        
        @weakify(self);
        _listView.latestCount = ^(NSNumber *listCount) {
            @strongify(self);
            if (self.delegate && [self.delegate respondsToSelector:@selector(listCount:atIndexPath:)]) {
                [self.delegate listCount:listCount atIndexPath:self.indexPath];
            }
        };
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


- (void)setLayout:(ShoppingListLayout *)layout {
    _layout = layout;
    self.height = _layout.height;
    self.contentView.height = _layout.height;
    CGFloat top = 0;
    if (layout.nameHeight>0) {
        top += kProductImageDefaultMargin;
    }
    _productImgView.top = top;
    [_productImgView setImageWithURL:[NSURL URLWithString:layout.model.imgUrl] options:YYWebImageOptionProgressiveBlur];
    _productNameLabel.top = top;
    _productNameLabel.height = _layout.nameHeight;
    _productNameLabel.width = self.editing ? kProductNameWidth-47 : kProductNameWidth;
    _productNameLabel.textLayout = _layout.nameLayout;

    top += _layout.nameHeight;
    _productCountLabel.top = top;
    _productCountLabel.textLayout = _layout.paticipateLayout;
    _productCountLabel.height = _layout.partInAmountHeight;
    
    top += _layout.partInAmountHeight;
    _listView.top = top;
    _listView.selectedCount = _layout.model.selectCount.integerValue;
    [_listView setSelectedCount:_layout.model.selectCount.integerValue totalCount:99];
    _listView.userInteractionEnabled = self.editing ? NO : YES;
}

@end



