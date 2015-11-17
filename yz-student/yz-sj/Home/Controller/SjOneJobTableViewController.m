//
//  SjOneJobTableViewController.m
//  yz-student
//
//  Created by 仲光磊 on 15/10/28.
//  Copyright © 2015年 cdq. All rights reserved.
//

#import "SjOneJobTableViewController.h"
#import "StuProfileHomeTableViewCell.h"
#import "SjOneJobDetailViewController.h"
#import "SjJobInfo.h"
#import "SjComposeJobViewController.h"
#import "SjCheckRegStaffTableViewController.h"
#import "SjDaySettleViewController.h"
#import "SjWeekSettleNotAgentTableViewController.h"

@interface SjOneJobTableViewController ()

@property(nonatomic, strong)SjJobInfo *oneJobInfo;

@end

@implementation SjOneJobTableViewController

- (SjJobInfo *)oneJobInfo
{
    if (_oneJobInfo == nil) {
        _oneJobInfo = [[SjJobInfo alloc]init];
    }
    return _oneJobInfo;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"兼职详情";
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [self.tableView setTableFooterView:view];
    
    self.oneJobInfo = [SjJobInfo sjJobDetailWithJobId:self.jobId];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    StuProfileHomeTableViewCell *cell = [StuProfileHomeTableViewCell cellWithNibWithTableView:tableView];
    if (indexPath.row == 0) {
        cell.cellImageView.image = [UIImage imageNamed:@"wx_14"];
        cell.cellLabel.text = @"兼职详情";
    }
    else if(indexPath.row == 1)
    {
        cell.cellImageView.image = [UIImage imageNamed:@"wx_16"];
        cell.cellLabel.text = @"修改兼职";
    }
    else if(indexPath.row == 2)
    {
        cell.cellImageView.image = [UIImage imageNamed:@"wx_15"];
        if ([self.oneJobInfo.isAgent isEqualToString:@"包办"]) {
            cell.cellLabel.text = @"查看包办";
        }
        else
        {
            cell.cellLabel.text = @"查看报名";
        }
        
    }
    else if(indexPath.row == 3)
    {
        cell.cellImageView.image = [UIImage imageNamed:@"wx_16"];
        cell.cellLabel.text = @"结算";
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0)
    {
        SjOneJobDetailViewController *vc = [[SjOneJobDetailViewController alloc]init];
        vc.oneJobInfo = self.oneJobInfo;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.row == 1)
    {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"SjComposeJob" bundle:[NSBundle mainBundle]];
        SjComposeJobViewController *vc = [sb instantiateViewControllerWithIdentifier:@"SjComposeJob"];
        vc.oneJobInfo = self.oneJobInfo;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.row == 2)
    {
        SjCheckRegStaffTableViewController *vc = [[SjCheckRegStaffTableViewController alloc]init];
        vc.oneJobInfo = self.oneJobInfo;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else
    {
        if ([self.oneJobInfo.settlementPeriod isEqualToString:@"日结"] && [self.oneJobInfo.isAgent isEqualToString:@"非包办"]) {
            SjDaySettleViewController *vc = [[SjDaySettleViewController alloc]init];
            vc.oneJobInfo = self.oneJobInfo;
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if([self.oneJobInfo.settlementPeriod isEqualToString:@"周结"] && [self.oneJobInfo.isAgent isEqualToString:@"非包办"])
        {
            SjWeekSettleNotAgentTableViewController *vc = [[SjWeekSettleNotAgentTableViewController alloc]init];
            vc.oneJobInfo = self.oneJobInfo;
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if([self.oneJobInfo.settlementPeriod isEqualToString:@"月结"] && [self.oneJobInfo.isAgent isEqualToString:@"非包办"])
        {
            SjWeekSettleNotAgentTableViewController *vc = [[SjWeekSettleNotAgentTableViewController alloc]init];
            vc.oneJobInfo = self.oneJobInfo;
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if([self.oneJobInfo.settlementPeriod isEqualToString:@"完工结"])
        {
            
        }
    }
}

@end
