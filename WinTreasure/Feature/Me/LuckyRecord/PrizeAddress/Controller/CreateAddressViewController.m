//
//  CreateAddressViewController.m
//  WinTreasure
//
//  Created by Apple on 16/6/28.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import "CreateAddressViewController.h"
#import "ExpressDescription.h"
#import "RecieverInformation.h"
#import "AddressModel.h"

@interface CreateAddressViewController ()

@property (nonatomic, strong) UIScrollView *contentScroll;
@property (nonatomic, strong) ExpressDescription *expressDescription;
@property (nonatomic, strong) RecieverInformation *recieverInformation;
@end

@implementation CreateAddressViewController

- (UIScrollView *)contentScroll {
    if (!_contentScroll) {
        _contentScroll = [[UIScrollView alloc]initWithFrame:({
            CGRect rect = {0,0,kScreenWidth,kScreenHeight};
            rect;
        })];
    }
    return _contentScroll;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"登记领奖";
    [self setRightItemTitle:@"保存并使用" action:@selector(save)];
    [self commonInit];
}

- (void)commonInit {
    [self.view addSubview:self.contentScroll];
    if (_isSigned) {
        _expressDescription = [ExpressDescription new];
        _expressDescription.origin = CGPointMake(0, 0);
        _expressDescription.size = CGSizeMake(kScreenWidth, 1);
        _expressDescription.descript = @"奖品商家会在3个工作日内发出，快递为顺丰到付，登机后请留意物流动态。";
        [_contentScroll addSubview:_expressDescription];
    }

    [self setupInfoView];
}

- (void)setupInfoView {
    _recieverInformation = [RecieverInformation new];
    _recieverInformation.origin = CGPointMake(0, _expressDescription.bottom);
    _recieverInformation.size = CGSizeMake(kScreenWidth, 1);
    _recieverInformation.model = _model;
    [_contentScroll addSubview:_recieverInformation];
    _contentScroll.contentSize = CGSizeMake(kScreenWidth, _recieverInformation.bottom);
    
    
    _recieverInformation.locationBlock = ^(NSString *location) {
        NSLog(@"%@",location);

    };
}

- (void)save {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dealloc {
    NSLog(@"%s",__func__);
}

@end
