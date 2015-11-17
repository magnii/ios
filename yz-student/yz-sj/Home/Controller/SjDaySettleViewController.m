//
//  SjDaySettleViewController.m
//  yz-student
//
//  Created by 仲光磊 on 15/11/5.
//  Copyright © 2015年 cdq. All rights reserved.
//

#import "SjDaySettleViewController.h"
#import "SjRegStaffTableViewCell.h"
#import "SjOneRegisMember.h"
#import "SjOnePersonInfoView.h"
#import "SjDaySettle.h"
#import "StuConfig.h"
#import "SjJobInfo.h"
#import "SjOneRegStaffViewController.h"

#define cellHeadH 80
#define oneRegisMemberH 50
#define SettleBtnH 30

#define BtnBackgroundBlueColor [UIColor colorWithRed:28/255.0 green:141/255.0 blue:213/255.0 alpha:1.0]

@interface SjDaySettleViewController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong)UITableView *daySettleTableView;
@property(nonatomic, strong)NSArray *daySettleArry;
@property(nonatomic, strong)UIView *headView;
@property(nonatomic, strong)UIButton *unSettledBtn;
@property(nonatomic, strong)UIButton *settledBtn;

@end

@implementation SjDaySettleViewController

- (UIButton *)unSettledBtn
{
    if (_unSettledBtn == nil) {
        _unSettledBtn = [[UIButton alloc]init];
        [_unSettledBtn setTitle:@"待结算" forState:UIControlStateNormal];
        [_unSettledBtn setTitleColor:BtnBackgroundBlueColor forState:UIControlStateNormal];
        [_unSettledBtn setBackgroundColor:[UIColor whiteColor]];
        [_unSettledBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
        [_unSettledBtn addTarget:self action:@selector(unSettledBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _unSettledBtn;
}

- (UIButton *)settledBtn
{
    if (_settledBtn == nil) {
        _settledBtn = [[UIButton alloc]init];
        [_settledBtn setTitle:@"已结算" forState:UIControlStateNormal];
        [_settledBtn setTitleColor:BtnBackgroundBlueColor forState:UIControlStateNormal];
        [_settledBtn setBackgroundColor:[UIColor whiteColor]];
        [_settledBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
        [_settledBtn addTarget:self action:@selector(settledBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _settledBtn;
}

- (UIView *)headView
{
    if (_headView == nil) {
        _headView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, screenFrame.size.width, SettleBtnH)];
        self.unSettledBtn.frame = CGRectMake(0, 0, screenFrame.size.width*0.5, SettleBtnH);
        self.settledBtn.frame = CGRectMake(CGRectGetMaxX(self.unSettledBtn.frame), 0, screenFrame.size.width*0.5, SettleBtnH);
        [_headView addSubview:self.unSettledBtn];
        [_headView addSubview:self.settledBtn];
    }
    return _headView;
}

- (NSArray *)daySettleArry
{
    if (_daySettleArry == nil) {
        _daySettleArry = [NSArray array];
    }
    return _daySettleArry;
}

- (UITableView *)daySettleTableView
{
    if (_daySettleTableView == nil) {
        _daySettleTableView = [[UITableView alloc]init];
    }
    return _daySettleTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.daySettleArry = [SjDaySettle daySettleListWithJobId:self.oneJobInfo.jobId SettleType:Settled];
//    self.daySettleTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.daySettleTableView.delegate = self;
    self.daySettleTableView.dataSource = self;
    
    self.daySettleTableView.frame = CGRectMake(0, SettleBtnH, screenFrame.size.width, screenFrame.size.height-SettleBtnH);
    [self.view addSubview:self.daySettleTableView];
    
    [self.view addSubview:self.headView];
    
    [self unSettledBtnClick: self.unSettledBtn];
}



- (void)unSettledBtnClick:(UIButton*)btn
{
    if (btn.selected) {
        return;
    }
    else
    {
        self.daySettleArry = [SjDaySettle daySettleListWithJobId:self.oneJobInfo.jobId SettleType:Unsettled];
        [self.daySettleTableView reloadData];
        
        btn.selected = YES;
        self.settledBtn.selected = NO;
        [self.settledBtn setBackgroundColor:[UIColor whiteColor]];
        [self.settledBtn setTitleColor:BtnBackgroundBlueColor forState:UIControlStateNormal];
        
        [self.unSettledBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.unSettledBtn setBackgroundColor:BtnBackgroundBlueColor];
    }
}

- (void)settledBtnClick:(UIButton*)btn
{
    if (btn.selected) {
        return;
    }
    else
    {
        self.daySettleArry = [SjDaySettle daySettleListWithJobId:self.oneJobInfo.jobId SettleType:Settled];
        [self.daySettleTableView reloadData];
        btn.selected = !btn.selected;
        self.unSettledBtn.selected = NO;
        [self.unSettledBtn setBackgroundColor:[UIColor whiteColor]];
        [self.unSettledBtn setTitleColor:BtnBackgroundBlueColor forState:UIControlStateNormal];
        
        [self.settledBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.settledBtn setBackgroundColor:BtnBackgroundBlueColor];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.daySettleArry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SjDaySettle *daySettle = self.daySettleArry[indexPath.row];

    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"SjDaySettleCell"];
    cell.textLabel.text = daySettle.dayDateStr;
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.detailTextLabel.text = @"点击查看详情";
    cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.unSettledBtn.selected)
    {
        SjOneRegStaffViewController *vc = [[SjOneRegStaffViewController alloc]init];
        vc.oneDaySettle = self.daySettleArry[indexPath.row];
        vc.settleType = Unsettled;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else
    {
        SjOneRegStaffViewController *vc = [[SjOneRegStaffViewController alloc]init];
        vc.oneDaySettle = self.daySettleArry[indexPath.row];
        vc.settleType = Settled;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
