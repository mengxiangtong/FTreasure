//
//  UIViewController+Swizzling.m
//  Dependence
//
//  Created by Apple on 16/5/17.
//  Copyright © 2016年 Linitial. All rights reserved.
//

#import "UIViewController+Swizzling.h"
#import <objc/runtime.h>


@implementation UIViewController (Swizzling)


+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self changeSel:@selector(viewDidAppear:) withSel:@selector(swizzledViewDidAppear:)];
        [self changeSel:@selector(viewDidDisappear:) withSel:@selector(swizzledViewDidDisappear:)];
        [self changeSel:@selector(viewWillAppear:) withSel:@selector(swizzledViewWillAppear:)];
    });
}

+ (void)changeSel:(SEL)selector1 withSel:(SEL)selector2 {
    Class class = [self class];
    SEL originalDidAppearSelector = selector1;
    SEL swizzledDidAppearSelector = selector2;
    Method originalMethod = class_getInstanceMethod(class, originalDidAppearSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledDidAppearSelector);
    BOOL didAddedMethod = class_addMethod(class, originalDidAppearSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (didAddedMethod) {
        class_replaceMethod(class, originalDidAppearSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

- (void)swizzledViewDidDisappear:(BOOL)animated {
    [self swizzledViewDidDisappear:animated];

}

- (void)swizzledViewWillAppear:(BOOL)animated {
    [self swizzledViewWillAppear:animated];
}

- (void)swizzledViewDidAppear:(BOOL)animated {
    [self swizzledViewDidAppear:animated];
}

@end
