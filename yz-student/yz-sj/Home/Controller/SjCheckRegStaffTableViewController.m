//
//  SjCheckRegStaffTableViewController.m
//  yz-student
//
//  Created by 仲光磊 on 15/11/5.
//  Copyright © 2015年 cdq. All rights reserved.
//

#import "SjCheckRegStaffTableViewController.h"
#import "SjRegStaffTableViewCell.h"
#import "SjOnePersonInfoView.h"
#import "SjDaySettle.h"
#import "SjJobInfo.h"
#import "SjOneRegisMember.h"
#import "StuConfig.h"

#define cellHeadH 80
#define oneRegisMemberH 50

@interface SjCheckRegStaffTableViewController ()

@property(nonatomic, strong)NSArray *dateInfoArry;

@end

@implementation SjCheckRegStaffTableViewController

- (NSArray *)dateInfoArry
{
    if (_dateInfoArry == nil) {
        _dateInfoArry = [NSArray array];
    }
    return _dateInfoArry;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dateInfoArry = [SjDaySettle daySettleListWithJobId:self.oneJobInfo.jobId SettleType:Settled];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
    SjDaySettle *daySettle = self.dateInfoArry[indexPath.row];
    SjRegStaffTableViewCell *cell = [SjRegStaffTableViewCell cellWithTableView:tableView];
    cell.dateL.text = daySettle.dayDateStr;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    CGFloat lastPersonY = CGRectGetMaxY(cell.nameView.frame);
    for (SjOneRegisMember *oneRegMember in daySettle.daySettleArry) {
        SjOnePersonInfoView *onePersonView = [SjOnePersonInfoView onePersonFromNib];
        onePersonView.nameL.text = oneRegMember.name;
        onePersonView.phoneL.text = oneRegMember.mobile;
//        onePersonView.frame = CGRectMake(0, lastPersonY+5, screenFrame.size.width, oneRegisMemberH);
//        lastPersonY = CGRectGetMaxY(onePersonView.frame);
        [cell.contentView addSubview:onePersonView];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SjDaySettle *daySettle = self.dateInfoArry[indexPath.row];
    return cellHeadH+oneRegisMemberH*daySettle.daySettleArry.count;
}


@end
