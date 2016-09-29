//
//  DiscoveryDetailViewController.m
//  WinTreasure
//
//  Created by Apple on 16/6/24.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import "DiscoveryDetailViewController.h"

@interface DiscoveryDetailViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation DiscoveryDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self commonConfig];
}

- (void)commonConfig {
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://1.163.com/hd/oneact/hdframe.do?id=84"]]];
}

- (void)setNavTitle:(NSString *)navTitle {
    _navTitle = navTitle;
    self.navigationItem.title = _navTitle;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
