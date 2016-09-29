//
//  UIButton+Block.m
//  WA
//
//  Created by Haitao.Li on 15/2/2.
//  Copyright (c) 2015年 Pactera. All rights reserved.
//

#import "UIButton+Block.h"

@implementation UIButton (Block)

static char overviewKey;
static char buttonType;
@dynamic event;
@dynamic Type;


- (void)setType:(NSString *)Type {
    objc_setAssociatedObject(self, &buttonType, Type, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (NSString *)Type {
    NSString *Type = objc_getAssociatedObject(self, &buttonType);
    return Type;
}


- (void)handleControlEvent:(UIControlEvents)event withBlock:(ActionBlock)block {
    if (block) {
        objc_removeAssociatedObjects(self);
        objc_setAssociatedObject(self, &overviewKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
        [self addTarget:self action:@selector(callActionBlock:) forControlEvents:event];
    }
}


- (void)callActionBlock:(id)sender {
    ActionBlock block = (ActionBlock)objc_getAssociatedObject(self, &overviewKey);
    if (block) {
        block();
    }
}

@end
