//
//  ShoppingListCell.h
//  WinTreasure
//
//  Created by Apple on 16/6/6.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditingCell.h"
#import "ShoppingListLayout.h"

extern CGFloat kChangeListViewWidth;
extern CGFloat kHandleButtonWidth;

@class ListCountView;
@protocol ShoppingListCellDelegate;

@interface ShoppingListCell : EditingCell

/**清单数量
 */
@property (nonatomic, strong) ListCountView *listView;

+ (instancetype)cellWithTableView:(UITableView *)tableview;

@property (nonatomic, strong) ShoppingListLayout *layout;

@property (nonatomic, weak) id<ShoppingListCellDelegate>delegate;

@property (nonatomic, copy) NSIndexPath *indexPath;

@end

@protocol ShoppingListCellDelegate <NSObject>

- (void)listCount:(NSNumber *)listCount atIndexPath:(NSIndexPath *)indexPath;

@end
