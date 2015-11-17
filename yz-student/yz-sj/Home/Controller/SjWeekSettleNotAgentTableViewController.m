//
//  SjWeekSettleNotAgentTableViewController.m
//  yz-student
//
//  Created by 仲光磊 on 15/11/9.
//  Copyright © 2015年 cdq. All rights reserved.
//

#import "SjWeekSettleNotAgentTableViewController.h"
#import "SjWeekSettle.h"
#import "SjJobInfo.h"
#import "SjOneWeekSettleNotAgentViewController.h"

@interface SjWeekSettleNotAgentTableViewController ()

@property(nonatomic, strong)NSArray *dateInfoArry;

@end

@implementation SjWeekSettleNotAgentTableViewController

- (NSArray *)dateInfoArry
{
    if (_dateInfoArry == nil) {
        _dateInfoArry = [NSArray array];
    }
    return _dateInfoArry;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"结算周期列表";
    
    self.dateInfoArry = [SjWeekSettle weekDateListWithJobId:self.oneJobInfo.jobId];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dateInfoArry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SjWeekSettle *weekSettle = self.dateInfoArry[indexPath.row];
    static NSString *ID = @"weekSettleNotAgentTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    cell.textLabel.text = weekSettle.rangeDate;
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.detailTextLabel.text = @"点击查看详情";
    cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    SjWeekSettle *weekSettle = self.dateInfoArry[indexPath.row];
    SjOneWeekSettleNotAgentViewController *vc = [[SjOneWeekSettleNotAgentViewController alloc]init];
    vc.dateIds = weekSettle.dateIds;
    vc.jobId = self.oneJobInfo.jobId;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
