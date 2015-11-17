//
//  StuProfileMyJobsDetailTableViewController.m
//  yz-student
//
//  Created by 仲光磊 on 15/9/19.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import "StuProfileMyJobsDetailTableViewController.h"
#import "StuProfileHomeTableViewCell.h"
#import "StuProfileMyJobsDetailDetailViewController.h"
#import "StuProfileMyJobsCommentsViewController.h"
#import "StuProfileMyJobsSignViewController.h"
#import "StuProfileMyJobsInfo.h"
#import "StuHomeLocalJob.h"
#import "StuProfileMyJobsEstimateViewController2.h"

extern NSString *globalSessionId;

@interface StuProfileMyJobsDetailTableViewController ()

@end

@implementation StuProfileMyJobsDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"兼职详情";
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [self.tableView setTableFooterView:view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if([StuProfileMyJobsInfo canEstimageWithSessionId:globalSessionId JobId:self.oneJob.jobId IsAgent:self.oneJob.isAgent])
    {
        return 4;
    }
    else
    {
        return 3;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    StuProfileHomeTableViewCell *cell = [StuProfileHomeTableViewCell cellWithNibWithTableView:tableView];
    if (indexPath.row == 0) {
        cell.cellImageView.image = [UIImage imageNamed:@"wx_14"];
        cell.cellLabel.text = @"兼职基本信息";
    }
    else if(indexPath.row == 1)
    {
        cell.cellImageView.image = [UIImage imageNamed:@"wx_16"];
        cell.cellLabel.text = @"签到";
    }
    else if(indexPath.row == 2)
    {
        cell.cellImageView.image = [UIImage imageNamed:@"wx_15"];
        cell.cellLabel.text = @"职位交流区";
    }
    else if(indexPath.row == 3)
    {
        cell.cellImageView.image = [UIImage imageNamed:@"wx_16"];
        cell.cellLabel.text = @"职位评价";
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        StuProfileMyJobsDetailDetailViewController *vc = [[StuProfileMyJobsDetailDetailViewController alloc]init];
        vc.oneJob = self.oneJob;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.row == 1)
    {
        StuProfileMyJobsSignViewController *vc = [[StuProfileMyJobsSignViewController alloc]init];
        vc.oneJob = self.oneJob;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.row == 2)
    {
        StuProfileMyJobsCommentsViewController *vc = [[StuProfileMyJobsCommentsViewController alloc]init];
        vc.oneJob = self.oneJob;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else
    {
        StuProfileMyJobsEstimateViewController2 *vc = [[StuProfileMyJobsEstimateViewController2 alloc]init];
        vc.oneJob = self.oneJob;
        [self.navigationController pushViewController:vc animated:YES];
    }
}
@end
