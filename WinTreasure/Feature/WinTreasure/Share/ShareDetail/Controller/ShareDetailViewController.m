//
//  ShareDetailViewController.m
//  WinTreasure
//
//  Created by Apple on 16/6/13.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import "ShareDetailViewController.h"
#import "ShareDetailView.h"

@interface ShareDetailViewController ()

@property (nonatomic, strong) UIWebView *webView;

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation ShareDetailViewController

- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://1.163.com/user/shareDetail.do?cid=50350611&gid=896&period=303246807&pageNum=1"]]];
    }
    return _webView;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:({
            CGRect rect = {0,0,kScreenWidth,kScreenHeight};
            rect;
        })];
    }
    return _scrollView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    ShareModel *model = [[ShareModel alloc]init];
    ShareDetailLayout *layout = [[ShareDetailLayout alloc]initWithModel:model];
    
    self.navigationItem.title = @"晒单分享";
    [self setRightImageNamed:@"detail_nav_share" action:@selector(share)];
//    [self.view addSubview:self.webView];
    [self.view addSubview:self.scrollView];
    ShareDetailView *detailView = [ShareDetailView new];
    [detailView setLayout:layout];
    [_scrollView addSubview:detailView];
    _scrollView.contentSize = CGSizeMake(kScreenWidth, detailView.height+kNavigationBarHeight);
    
}

- (void)share {
    
}

@end
