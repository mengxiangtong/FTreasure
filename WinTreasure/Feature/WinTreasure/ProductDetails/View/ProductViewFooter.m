//
//  ProductViewFooter.m
//  WinTreasure
//
//  Created by Apple on 16/7/4.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import "ProductViewFooter.h"

@implementation ProductViewFooter

+ (id)loadViewFromXibNamed:(NSString*)xibName withFileOwner:(id)fileOwner
{
    NSArray *array = [[NSBundle mainBundle] loadNibNamed:xibName owner:fileOwner options:nil];
    if (array && [array count]) {
        return array[0];
    }else {
        return nil;
    }
}

+ (id)loadViewFromXibNamed:(NSString*)xibName
{
    return [self loadViewFromXibNamed:xibName withFileOwner:self];
}

+ (id)loadFromXib
{
    return [self loadViewFromXibNamed:NSStringFromClass([self class])];
}

@end
