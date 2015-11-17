//
//  SjProfileViewController.m
//  yz-student
//
//  Created by 仲光磊 on 15/10/22.
//  Copyright © 2015年 cdq. All rights reserved.
//

#import "SjProfileViewController.h"
#import "SjProfileHomeHeadView.h"
#import "StuConfig.h"
#import "StuProfileHomeTableViewCell.h"
#import "SjUserInfo.h"
#import "SjLoginViewController.h"
#import "SjProfileResetPwdViewController.h"
#import "SjProfileMyDocViewController.h"
#import "SjProfileModifyMyDocViewController.h"
#import "SjAuthenticationViewController.h"

#define SjHomeHeadViewH 140
#define cellH 44

extern NSString *sjGlobalSessionId;

@interface SjProfileViewController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong)UITableView *sjHomeTableView;
@property(nonatomic, strong)SjProfileHomeHeadView *headView;
@property(nonatomic, strong)NSArray *profileList;
@property(nonatomic, strong)NSArray *profileImgList;

@end

@implementation SjProfileViewController

- (NSArray *)profileList
{
    if (_profileList == nil) {
        _profileList = @[@"我的资料", @"完善资料", @"商家认证", @"修改密码", @"退出账号"];
    }
    return _profileList;
}

- (NSArray *)profileImgList
{
    if (_profileImgList==nil) {
        _profileImgList = @[@"as101", @"as102", @"as105", @"as104", @"aaa1"];
    }
    return _profileImgList;
}

- (SjProfileHomeHeadView *)headView
{
    if (_headView == nil) {
        _headView = [SjProfileHomeHeadView viewFromNib];
    }
    return _headView;
}

- (UITableView *)sjHomeTableView
{
    if (_sjHomeTableView == nil) {
        _sjHomeTableView = [[UITableView alloc]init];
    }
    return _sjHomeTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.headView.frame = CGRectMake(0, 0, screenFrame.size.width, SjHomeHeadViewH);
    self.sjHomeTableView.tableHeaderView = self.headView;
    
    self.sjHomeTableView.frame = CGRectMake(0, 0, screenFrame.size.width, screenFrame.size.height);
    [self.view addSubview:self.sjHomeTableView];
    self.sjHomeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.sjHomeTableView.delegate = self;
    self.sjHomeTableView.dataSource = self;
    
    SjUserInfo *info = [SjUserInfo sjUserInfoWithSessionId:sjGlobalSessionId];
    self.headView.userNameL.text = info.userName;
    self.headView.userPointL.text = [NSString stringWithFormat:@"%d", info.points];
    self.headView.companyNameL.text = info.companyName;
    
    UIView *footerView = [[UIView alloc]init];
    footerView.backgroundColor = [UIColor clearColor];
    self.sjHomeTableView.tableFooterView = footerView;
}

#pragma tableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.profileList.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StuProfileHomeTableViewCell *cell = [StuProfileHomeTableViewCell cellWithNibWithTableView:tableView];
    cell.cellImageView.image = [UIImage imageNamed:self.profileImgList[indexPath.row]];
    cell.cellLabel.text = self.profileList[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return cellH;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0)
    {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"SjProfileMyDoc" bundle:[NSBundle mainBundle]];
        SjProfileMyDocViewController *vc = [sb instantiateViewControllerWithIdentifier:@"SjProfileMyDoc"];
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    else if (indexPath.row == 1)
    {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"SjProfileModifyMyDoc" bundle:[NSBundle mainBundle]];
        SjProfileModifyMyDocViewController *vc = [sb instantiateViewControllerWithIdentifier:@"SjProfileModifyMyDoc"];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.row == 2)
    {
        SjAuthenticationViewController *vc = [[SjAuthenticationViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.row == 3)
    {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"SjProfileResetPwd" bundle:[NSBundle mainBundle]];
        SjProfileResetPwdViewController *vc = [sb instantiateViewControllerWithIdentifier:@"SjProfileResetPwd"];
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    else if (indexPath.row == 4)
    {
        sjGlobalSessionId = nil;
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"SjLogin" bundle:[NSBundle mainBundle]];
        SjLoginViewController *vc = [sb instantiateViewControllerWithIdentifier:@"SjLogin"];
//        [self.navigationController pushViewController:vc animated:YES];
        [self presentViewController:vc animated:YES completion:nil];
    }
}

@end
