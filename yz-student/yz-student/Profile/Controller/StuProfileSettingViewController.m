//
//  StuProfileSettingViewController.m
//  yz-student
//
//  Created by 仲光磊 on 15/10/2.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import "StuProfileSettingViewController.h"
#import "StuConfig.h"
#import "Account.h"
#import "AccountTool.h"
#import "StuProfileUserInfo.h"
#import "StuProfileMyBasicInfoViewController.h"
#import "StuProfileWalletController.h"
#import "StuProfileResetPwdViewController2.h"

#define firstLabelH 35
#define firstLabelW 100
#define myGrayColor [UIColor colorWithRed:80/255.0 green:80/255.0 blue:80/255.0 alpha:0.2]

@interface StuProfileSettingViewController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) UILabel *accountL;
@property(nonatomic, strong) UILabel *accountNumL;

@property(nonatomic, strong) NSArray *tableListArray;

@property(nonatomic, strong) UITableView *settingTableView;
@property(nonatomic, strong) StuProfileUserInfo *userInfo;

@end

@implementation StuProfileSettingViewController

-(UILabel *)accountL
{
    if (_accountL == nil) {
        _accountL = [[UILabel alloc]init];
    }
    return _accountL;
}

-(UILabel *)accountNumL
{
    if (_accountNumL == nil) {
        _accountNumL = [[UILabel alloc]init];
    }
    return _accountNumL;
}

- (UITableView *)settingTableView
{
    if (_settingTableView == nil) {
        _settingTableView = [[UITableView alloc]init];
    }
    return _settingTableView;
}

- (StuProfileUserInfo *)userInfo
{
    if (_userInfo == nil) {
        _userInfo = [[StuProfileUserInfo alloc]init];
    }
    return _userInfo;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"设置";
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableListArray = @[@"基本资料", @"支付宝设置", @"修改密码"];
    
    self.accountL.text = @"账号";
    [self.accountL setFont:[UIFont systemFontOfSize:14]];
    self.accountL.frame = CGRectMake(15, 64, firstLabelW, firstLabelH);
    self.accountL.textAlignment = NSTextAlignmentLeft;
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(15, 64+firstLabelH, screenFrame.size.width, 1)];
    lineView.backgroundColor = myGrayColor;
    [self.view addSubview:lineView];
    
    [self getUserInfo];
    
    self.accountNumL.text = self.userInfo.mobile;
    [self.accountNumL setFont:[UIFont systemFontOfSize:14]];
    self.accountNumL.frame = CGRectMake(screenFrame.size.width-firstLabelW-20, 64, firstLabelW, firstLabelH);
    self.accountNumL.textAlignment = NSTextAlignmentRight;
    [self.accountNumL setTextColor:[UIColor lightGrayColor]];
    
    [self.view addSubview:self.accountL];
    [self.view addSubview:self.accountNumL];
    
    self.settingTableView.frame = CGRectMake(0, CGRectGetMaxY(self.accountL.frame)+1, screenFrame.size.width, screenFrame.size.height-CGRectGetMaxY(self.accountL.frame));
    [self.view addSubview:self.settingTableView];
    
    self.settingTableView.delegate = self;
    self.settingTableView.dataSource = self;
    
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [self.settingTableView setTableFooterView:view];
    self.settingTableView.scrollEnabled = NO;
    //self.settingTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)getUserInfo
{
    Account *account = [AccountTool account:StuArchive];
    
    NSString *loginAddr = [NSString stringWithFormat:@"%@/weChat/member/loginForAndroid?mobile=%@&password=%@", serverIp, account.name, account.passwd];
    NSData *data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:loginAddr]] returningResponse:nil error:nil];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    
    self.userInfo.name = dict[@"name"];
    self.userInfo.mobile = dict[@"mobile"];
    NSString *sex = dict[@"gender"];
    if ([sex isEqualToString:@"m"] || [sex isEqualToString:@"男"]) {
        self.userInfo.gender = @"男";
    }
    else{
        self.userInfo.gender = @"女";
    }
    self.userInfo.height = dict[@"height"];
}

#pragma tableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableListArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"StuProfileSettingCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [cell.textLabel setText:self.tableListArray[indexPath.row]];
    [cell.textLabel setFont:[UIFont systemFontOfSize:14]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return firstLabelH;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        StuProfileMyBasicInfoViewController *vc = [[StuProfileMyBasicInfoViewController alloc]init];
        vc.userInfo = self.userInfo;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if(indexPath.row == 1)
    {
        StuProfileWalletController *vc = [[StuProfileWalletController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else
    {
        StuProfileResetPwdViewController2 *vc = [[StuProfileResetPwdViewController2 alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
@end
