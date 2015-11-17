//
//  ProfileTableViewController.m
//  yz
//
//  Created by 仲光磊 on 15/8/26.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import "StuProfileViewController.h"
#import "StuProfileHomeTableViewCell.h"
#import "StuConfig.h"
#import "StuProfileHomeHeadView.h"
#import "StuProfileInfo.h"
#import "Account.h"
#import "AccountTool.h"
#import "StuProfileWalletController.h"
#import "StuProfileMyInfoTableViewController.h"
#import "StuProfileMyJobsTableViewController.h"
#import "StuProfileMyBBTableViewController.h"
#import "StuProfileMySavedTableViewController.h"
#import "StuProfileMyAttentionTableViewController.h"
#import "StuTrainingViewController.h"
#import "StuProfileAboutViewController.h"
#import "StuProfileSettingViewController.h"
#import "MBProgressHUD+MJ.h"
#import "StuProfileHomeHead2View.h"
#import "StuProfileSharedViewController.h"
#import "StuProfileMyPreSalaryViewController.h"
#import "StuProfileLoginViewController2.h"
#import "StuProfileRegisterViewController2.h"

#define cellH 44
#define headViewH 125

extern NSString *globalSessionId;

@interface StuProfileViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong)UITableView *profileHomeTableView;
@property(nonatomic, strong)NSArray *profileItemImgArray;
@property(nonatomic, strong)NSArray *profileItemWordArray;
@property(nonatomic, strong)StuProfileHomeHeadView *profileHomeHeadView;
@property(nonatomic, strong)StuProfileHomeHead2View *profileHomeHead2View;

@end

@implementation StuProfileViewController

- (NSArray *)profileItemArray
{
    if (_profileItemImgArray == nil) {
        _profileItemImgArray = [NSArray array];
    }
    return _profileItemImgArray;
}

- (NSArray *)profileItemWordArray
{
    if (_profileItemWordArray == nil) {
        _profileItemWordArray = [NSArray array];
    }
    return _profileItemWordArray;
}

- (UITableView *)profileHomeTableView
{
    if (_profileHomeTableView == nil) {
        _profileHomeTableView = [[UITableView alloc]init];
    }
    return _profileHomeTableView;
}

- (StuProfileHomeHeadView *)profileHomeHeadView
{
    if (_profileHomeHeadView == nil) {
        _profileHomeHeadView = [StuProfileHomeHeadView viewFromNib];
    }
    return _profileHomeHeadView;
}

- (StuProfileHomeHead2View *)profileHomeHead2View
{
    if (_profileHomeHead2View == nil) {
        _profileHomeHead2View = [StuProfileHomeHead2View headViewFromNib];
    }
    return _profileHomeHead2View;
}

- (void)viewDidLoad {

    [super viewDidLoad];
    
    self.navigationController.view.backgroundColor = [UIColor whiteColor];
    self.profileHomeTableView.contentSize = CGSizeMake(screenFrame.size.width, screenFrame.size.height);
    
    self.profileHomeTableView.delegate = self;
    self.profileHomeTableView.dataSource = self;
    self.profileItemImgArray = @[@"as101", @"as102", @"as105", @"as104", @"aaa1", @"as106", @"as103", @"as107", @"a111", @"as108", @"as109", @"as110"];
    self.profileItemWordArray = @[@"我的钱包", @"我的消息", @"我的兼职", @"我的包办", @"我的预支", @"我的收藏", @"我的关注", @"我的培训", @"分享", @"关于", @"设置",@"退出账号"];
    
    self.profileHomeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
//    [self.view addSubview:self.profileHomeHeadView];
//    self.profileHomeHeadView.frame = CGRectMake(0, 64, screenFrame.size.width, headViewH);
    //    [self.view addSubview:self.profileHomeHead2View];
    //    self.profileHomeHead2View.frame = CGRectMake(0, 64, screenFrame.size.width, headViewH);
    //    self.profileHomeTableView.frame = CGRectMake(0, CGRectGetMaxY(self.profileHomeHeadView.frame), screenFrame.size.width, screenFrame.size.height-CGRectGetMaxY(self.profileHomeHeadView.frame)-44);
    
    self.profileHomeHeadView.frame = CGRectMake(0, 0, screenFrame.size.width, headViewH);
    self.profileHomeHead2View.frame = CGRectMake(0, 0, screenFrame.size.width, headViewH);
    self.profileHomeTableView.frame = CGRectMake(0, 0, screenFrame.size.width, screenFrame.size.height-44);
    self.profileHomeTableView.tableHeaderView = self.profileHomeHead2View;
    
    [self.view addSubview:self.profileHomeTableView];
    [self.profileHomeHead2View.loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.profileHomeHead2View.registerBtn addTarget:self action:@selector(registerBtnClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //在这里填充我的数据
    if (globalSessionId != nil && globalSessionId.length > 0 && ![globalSessionId isEqualToString:@"-1"])
    {
        Account *account = [AccountTool account:StuArchive];
        NSString *username;
        NSString *passwd;
        if (account != nil) {
            username = account.name;
            passwd = account.passwd;
        }
        
        StuProfileInfo *profileInfo = [StuProfileInfo profileInfoWithUserMobile:username Passwd:passwd];
        
        if (profileInfo.maxPoints < 30) {
            self.profileHomeHeadView.headLevelImg.image = [UIImage imageNamed:@"vip_icon1"];
        }
        if (profileInfo.maxPoints > 30 && profileInfo.maxPoints <= 80) {
            self.profileHomeHeadView.headLevelImg.image = [UIImage imageNamed:@"vip_icon2"];
        }
        if (profileInfo.maxPoints > 80 && profileInfo.maxPoints <= 170) {
            self.profileHomeHeadView.headLevelImg.image = [UIImage imageNamed:@"vip_icon3"];
        }
        if (profileInfo.maxPoints > 170 && profileInfo.maxPoints <= 320) {
            self.profileHomeHeadView.headLevelImg.image = [UIImage imageNamed:@"vip_icon4"];
        }
        if (profileInfo.maxPoints > 320 && profileInfo.maxPoints <= 400) {
            self.profileHomeHeadView.headLevelImg.image = [UIImage imageNamed:@"vip_icon5"];
        }
        if (profileInfo.maxPoints > 400) {
            self.profileHomeHeadView.headLevelImg.image = [UIImage imageNamed:@"vip_icon6"];
        }
        
        self.profileHomeHeadView.headInvites.text = [NSString stringWithFormat:@"%ld", profileInfo.invites];
        self.profileHomeHeadView.headName.text = profileInfo.mobile;
        self.profileHomeHeadView.headScore.text = [NSString stringWithFormat:@"%ld", profileInfo.points];
        self.profileHomeHeadView.headSignDays.text = [NSString stringWithFormat:@"%ld", profileInfo.signInDays];
        
        if (profileInfo.isTodaySignIn) {
            self.profileHomeHeadView.headSignBtn.backgroundColor = [UIColor grayColor];
            [self.profileHomeHeadView.headSignBtn setTitle:@"已签到" forState:UIControlStateNormal];
            self.profileHomeHeadView.headSignBtn.userInteractionEnabled = NO;
        }
        else
        {
            [self.profileHomeHeadView.headSignBtn setTitle:@"签到" forState:UIControlStateNormal];
        }
        self.profileHomeTableView.tableHeaderView = self.profileHomeHeadView;
    }
    
    if (globalSessionId == nil || [globalSessionId isEqualToString:@""]) {
        //跳转到登陆页面
        StuProfileLoginViewController2 *vc = [[StuProfileLoginViewController2 alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    if (globalSessionId != nil && ![globalSessionId isEqualToString:@""] && [globalSessionId isEqualToString:@"-1"]) {
        self.profileHomeTableView.tableHeaderView = self.profileHomeHead2View;
    }
}

- (void)loginBtnClick
{
    StuProfileLoginViewController2 *vc = [[StuProfileLoginViewController2 alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)registerBtnClick
{
    StuProfileRegisterViewController2 *vc = [[StuProfileRegisterViewController2 alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma tableViewDelegate&Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.profileItemWordArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return cellH;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StuProfileHomeTableViewCell *cell = [StuProfileHomeTableViewCell cellWithNibWithTableView:tableView];
    cell.cellImageView.image = [UIImage imageNamed:self.profileItemImgArray[indexPath.row]];
    cell.cellLabel.text = self.profileItemWordArray[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
    NSString *MyName = self.profileItemWordArray[indexPath.row];
    
    if ([MyName isEqualToString:@"我的钱包"])
    {
        StuProfileWalletController *vc = [[StuProfileWalletController alloc]init];
        [self.navigationController pushViewController:vc
                                             animated:YES];
    }
    else if ([MyName isEqualToString:@"我的消息"]) {
        StuProfileMyInfoTableViewController *vc = [[StuProfileMyInfoTableViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    else if ([MyName isEqualToString:@"我的兼职"]) {
        StuProfileMyJobsTableViewController *vc = [[StuProfileMyJobsTableViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([MyName isEqualToString:@"我的包办"])
    {
        StuProfileMyBBTableViewController *vc = [[StuProfileMyBBTableViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([MyName isEqualToString:@"我的预支"])
    {
        StuProfileMyPreSalaryViewController *vc = [[StuProfileMyPreSalaryViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([MyName isEqualToString:@"我的收藏"])
    {
        StuProfileMySavedTableViewController *vc = [[StuProfileMySavedTableViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([MyName isEqualToString:@"我的关注"])
    {
        StuProfileMyAttentionTableViewController *vc = [[StuProfileMyAttentionTableViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([MyName isEqualToString:@"我的培训"])
    {
        StuTrainingViewController *vc = [[StuTrainingViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([MyName isEqualToString:@"关于"])
    {
        StuProfileAboutViewController *vc = [[StuProfileAboutViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([MyName isEqualToString:@"设置"])
    {
        StuProfileSettingViewController *vc = [[StuProfileSettingViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([MyName isEqualToString:@"退出账号"])
    {
        globalSessionId = nil;
        [MBProgressHUD showSuccess:@"退出登录成功"];
        self.profileHomeHeadView.headLevelImg.image = nil;
        self.profileHomeHeadView.headInvites.text = @"";
        self.profileHomeHeadView.headName.text = @"";
        self.profileHomeHeadView.headScore.text = @"";
        self.profileHomeHeadView.headSignDays.text = @"";
        
        self.profileHomeTableView.tableHeaderView = self.profileHomeHead2View;
    }
    else if ([MyName isEqualToString:@"分享"])
    {
        StuProfileSharedViewController *vc = [[StuProfileSharedViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }

}

@end
