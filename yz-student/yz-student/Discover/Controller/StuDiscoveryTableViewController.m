//
//  DiscoveryTableViewController.m
//  yz-student
//
//  Created by 仲光磊 on 15/9/1.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import "StuDiscoveryTableViewController.h"
#import "StuNearByJobsViewController.h"
#import "StuHomeLeftBtn.h"
#import "StuSystemInfoTableViewController.h"

@interface DiscoveryTableViewController ()

@end

@implementation DiscoveryTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:244/255.0];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    static NSString *ID = @"DiscoverTableCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    if (indexPath.section == 0) {
        cell.textLabel.text = @"附近兼职";
        //uiimage
        cell.imageView.image = [UIImage imageNamed:@"aaa3_2"];
    }
    if (indexPath.section == 1) {
        cell.textLabel.text = @"系统消息";
        cell.imageView.image = [UIImage imageNamed:@"wx_15"];
    }

    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        StuNearByJobsViewController *vc = [[StuNearByJobsViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.section == 1)
    {
        StuSystemInfoTableViewController *vc = [[StuSystemInfoTableViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
