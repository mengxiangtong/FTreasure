//
//  NoticeDetailViewController.m
//  WinTreasure
//
//  Created by Apple on 16/7/8.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import "NoticeDetailViewController.h"
#import "RedBook.h"

@interface NoticeDetailViewController ()
{
    BOOL isAnimated;
}
@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@end

@implementation NoticeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"通知详情";
    RedBook *redBook = [[RedBook alloc]initWithArray:@[@1,@1]];
    redBook.origin = CGPointMake(30, 60);
    [_imgView addSubview:redBook];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
        if (!isAnimated) {
            [redBook strokeStart];
            isAnimated = YES;
            return;
        }
        [redBook strokeEnd];
        isAnimated = NO;
    }];
    [_imgView addGestureRecognizer:tap];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
