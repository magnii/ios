//
//  StuProfileMyBBDetailTableViewController.m
//  yz-student
//
//  Created by 仲光磊 on 15/9/20.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import "StuProfileMyBBDetailTableViewController.h"
#import "StuProfileHomeTableViewCell.h"
#import "StuProfileMyBBDetailDetailViewController.h"
#import "StuProfileMyJobsCommentsViewController.h"

@interface StuProfileMyBBDetailTableViewController ()

@end

@implementation StuProfileMyBBDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"包办详情";
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
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    StuProfileHomeTableViewCell *cell = [StuProfileHomeTableViewCell cellWithNibWithTableView:tableView];
    if (indexPath.row == 0) {
        cell.cellImageView.image = [UIImage imageNamed:@"wx_14"];
        cell.cellLabel.text = @"包办详情";
    }
    else if(indexPath.row == 1)
    {
        cell.cellImageView.image = [UIImage imageNamed:@"wx_15"];
        cell.cellLabel.text = @"职位交流区";
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        StuProfileMyBBDetailDetailViewController *vc = [[StuProfileMyBBDetailDetailViewController alloc]init];
        vc.oneJob = self.oneJob;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else
    {
        StuProfileMyJobsCommentsViewController *vc = [[StuProfileMyJobsCommentsViewController alloc]init];
        vc.oneJob = self.oneJob;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
