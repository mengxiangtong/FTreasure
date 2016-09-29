//
//  QuestionViewController.m
//  WinTreasure
//
//  Created by Apple on 16/6/13.
//  Copyright © 2016年 linitial. All rights reserved.
//

#import "QuestionViewController.h"
#import "QuestionSection.h"
#import "QuestionCell.h"

@interface QuestionViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) BaseTableView *tableview;

@property (nonatomic, strong) NSMutableArray *questionData;

@property (nonatomic, strong) NSMutableArray *answerData;

@property (nonatomic, strong) NSMutableArray *stateArray;

@end

@implementation QuestionViewController

- (NSMutableArray *)questionData {
    if (!_questionData) {
        NSArray *questions = @[@"1.怎样参加一元夺宝？",@"2.1元夺宝怎么计算幸运号码的？",@"3.幸运号码的结果可信吗？",@"4.怎样查看是否成为幸运用户？如何领取幸运商品？",@"5.商品是正品吗？如何保证？",@"6.收到的商品可以退换货吗？",@"7.什么是夺宝币？",@"8.所有活动及商品均与苹果公司无关"];
        _questionData = [NSMutableArray arrayWithArray:questions];
    }
    return _questionData;
}

- (NSMutableArray *)answerData {
    
    if (!_answerData) {
        NSArray *answers = @[@[@"使用网易免费邮箱登陆，就可以参加1元夺宝了"],@[@"商品最后一个号码分配完毕后，将公示分配时间点前本站全部商品的最后50个参与时间"],@[@"由于使用了“老时时彩”揭晓结果作为参数，因此幸运号码肯定是未知的，确保绝对公正公平。"],@[@"个人中心有您的夺宝记录，点击对应的记录，即可知道该期夺宝的获得者。"],@[@"夺宝奇兵所有商品均从正规渠道采购，100%正品。"],@[@"非质量问题，不在三包范围内，不给予退换货。"],@[@"夺宝币是夺宝奇兵的代币，1个夺宝币可以直接购买1个夺宝号码。"],@[@"通过本产品所从事的任何活动及其获得的任何奖励均与苹果公司无关。"]];
        _answerData = [NSMutableArray arrayWithArray:answers];
    }
    return _answerData;
}

- (UITableView *)tableview {
    if (!_tableview) {
        _tableview = [[BaseTableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableview.dataSource = self;
        _tableview.delegate = self;
        _tableview.backgroundColor = UIColorHex(0xe8e8e8);
    }
    return _tableview;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"常见问题";
    [self.view addSubview:self.tableview];
    [self setState];
}


- (void)setState {
    _stateArray = [NSMutableArray array];
    for (int i=0; i<self.answerData.count; i++) {
        [_stateArray addObject:@NO];
    }
}

#pragma mark - UITableViewDataSource, UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.answerData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([_stateArray[section] boolValue]) {
        NSArray *array = self.answerData[section];
        return array.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QuestionCell *cell = [QuestionCell cellWithTableView:tableView];
    cell.answer = self.answerData[indexPath.section][indexPath.row];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    QuestionSection *questionSection = [QuestionSection section];
    questionSection.section = section;
    questionSection.question = self.questionData[section];
    questionSection.clickBlock = ^(NSInteger indexSection){
        if ([_stateArray[indexSection] boolValue]) {
            [_stateArray replaceObjectAtIndex:indexSection withObject:@NO];
        } else {
            [_stateArray replaceObjectAtIndex:indexSection withObject:@YES];
        }
        [_tableview reloadSections:[NSIndexSet indexSetWithIndex:indexSection] withRowAnimation:UITableViewRowAnimationAutomatic];
    };
    return questionSection;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [QuestionCell height:self.answerData[indexPath.section][indexPath.row]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [QuestionSection height:self.questionData[section]];
}

@end
