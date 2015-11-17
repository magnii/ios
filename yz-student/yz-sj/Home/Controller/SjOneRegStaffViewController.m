//
//  SjOneRegStaffViewController.m
//  yz-student
//
//  Created by 仲光磊 on 15/11/6.
//  Copyright © 2015年 cdq. All rights reserved.
//

#import "SjOneRegStaffViewController.h"
#import "SjOneRegStaffTableHeadView.h"
#import "StuConfig.h"
#import "SjDaySettle.h"
#import "SjOneRegisMember.h"
#import "SjOneSettleTableViewCell.h"
#import "SjCheckSignViewController.h"
#import "SjSignInfo.h"

#define headViewH 30
#define nameBtnTag 10010
#define signBtnTag 20020
#define BtnBackgroundBlueColor [UIColor colorWithRed:28/255.0 green:141/255.0 blue:213/255.0 alpha:1.0]

@interface SjOneRegStaffViewController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong)SjOneRegStaffTableHeadView *headView;
@property(nonatomic, strong)NSArray *onedayPeoplesArry;
@property(nonatomic, strong)UITableView *onedayTableView;
@property(nonatomic, strong)UIView *footerView;

@property(nonatomic, assign)int btnTag;
@property(nonatomic, assign)int signTag;

@end

@implementation SjOneRegStaffViewController

- (NSArray *)onedayPeoplesArry
{
    if (_onedayPeoplesArry == nil) {
        _onedayPeoplesArry = [NSArray array];
    }
    return _onedayPeoplesArry;
}

- (UITableView *)onedayTableView
{
    if (_onedayTableView == nil) {
        _onedayTableView = [[UITableView alloc]init];
    }
    return _onedayTableView;
}

- (SjOneRegStaffTableHeadView *)headView
{
    if (_headView == nil) {
        _headView = [SjOneRegStaffTableHeadView viewFromNib];
    }
    return _headView;
}

- (UIView *)footerView
{
    if (_footerView == nil) {
        _footerView = [[UIView alloc]init];
        _footerView.backgroundColor = [UIColor whiteColor];
        _footerView.frame = CGRectMake(0, 20, screenFrame.size.width, 30);
        
        UIButton *footerBtn = [[UIButton alloc]init];
        footerBtn = [[UIButton alloc]init];
        [footerBtn setTitle:@"结算" forState:UIControlStateNormal];
        footerBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        footerBtn.titleLabel.textColor = [UIColor whiteColor];
        footerBtn.backgroundColor = BtnBackgroundBlueColor;
        footerBtn.frame = CGRectMake(50, 0, screenFrame.size.width-50*2, 30);
        
        [footerBtn addTarget:self action:@selector(footerBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_footerView addSubview:footerBtn];
    }

    return _footerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.btnTag = nameBtnTag;
    self.signTag = signBtnTag;
    
    self.onedayPeoplesArry = self.oneDaySettle.daySettleArry;
    
    self.onedayTableView.delegate = self;
    self.onedayTableView.dataSource = self;
    
    self.headView.frame = CGRectMake(0, 64, screenFrame.size.width, headViewH);
    [self.view addSubview:self.headView];
    
    self.onedayTableView.frame = CGRectMake(0, headViewH+64, screenFrame.size.width, screenFrame.size.height-headViewH);
    if (self.onedayPeoplesArry.count > 0 && self.settleType == Unsettled) {
        self.onedayTableView.tableFooterView = self.footerView;
    }
    else
    {
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = [UIColor clearColor];
        self.onedayTableView.tableFooterView = view;
    }

    [self.view addSubview:self.onedayTableView];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.onedayPeoplesArry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SjOneRegisMember *oneMember = self.onedayPeoplesArry[indexPath.row];
        SjOneSettleTableViewCell *cell = [SjOneSettleTableViewCell cellWithTableView:tableView];
    [cell.nameBtn setTitle:oneMember.name forState:UIControlStateNormal];
    cell.telephoneL.text = oneMember.mobile;
    cell.salaryL.text = [NSString stringWithFormat:@"%d", oneMember.salary];
    cell.nameBtn.tag = self.btnTag++;
    [cell.nameBtn addTarget:self action:@selector(nameBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    cell.checkSignBtn.tag = self.signTag++;
    [cell.checkSignBtn addTarget:self action:@selector(checkSignBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    if (self.settleType == Settled) {
        cell.nameBtn.selected = YES;
        cell.nameBtn.userInteractionEnabled = NO;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    SjDaySettle *daySettle = onedayPeoplesArry[indexPath.row];
    //    return cellHeadH+oneRegisMemberH*daySettle.daySettleArry.count+10;
    return 40;
}

- (void)nameBtnClick:(UIButton*)btn
{
    btn.selected = !btn.selected;
    NSLog(@"nameBtnTag=%ld", btn.tag);
}

- (void)checkSignBtnClick:(UIButton*)btn
{
    SjCheckSignViewController *vc = [[SjCheckSignViewController alloc]init];
    SjSignInfo *signInfo = [[SjSignInfo alloc]init];
    signInfo.dateNow = self.oneDaySettle.dayDateStr;
    SjOneRegisMember *oneRegMem = self.oneDaySettle.daySettleArry[btn.tag-signBtnTag];
    signInfo.signInDate = oneRegMem.signInTime;
    signInfo.signInAddr = oneRegMem.signInAddress;
    signInfo.signOutDate = oneRegMem.signOutTime;
    signInfo.signOutAddr = oneRegMem.signOutAddress;

    vc.signInfo = signInfo;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)footerBtnClick
{
    
}

@end
