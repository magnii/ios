//
//  StuProfileLoginViewController2.m
//  yz-student
//
//  Created by 仲光磊 on 15/10/14.
//  Copyright © 2015年 cdq. All rights reserved.
//

#import "StuProfileLoginViewController2.h"
#import "StuProfileLoginView.h"
#import "StuConfig.h"
#import "MBProgressHUD+MJ.h"
#import "Account.h"
#import "AccountTool.h"
#import "StuProfileRegisterViewController2.h"
#import "StuProfileResetPwdViewController2.h"

#define loginViewH 275

NSString *globalSessionId;
NSString *globalComplete;
NSString *globalUserName;
NSString *globalAlipayNum;

@interface StuProfileLoginViewController2 ()

@property(nonatomic, strong) StuProfileLoginView *loginView;

@end

@implementation StuProfileLoginViewController2

- (StuProfileLoginView *)loginView
{
    if (_loginView == nil) {
        _loginView = [StuProfileLoginView viewFromNib];
    }
    return _loginView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登陆";
    globalSessionId = @"-1";
    
    self.loginView.frame = CGRectMake(0, 64, screenFrame.size.width, loginViewH);
    [self.view addSubview:self.loginView];
    
    [self.loginView.loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    Account *account = [AccountTool account:StuArchive];
    self.loginView.userNameL.text = account.name;
    self.loginView.passwordL.text = account.passwd;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.loginView.registAccountBtn addTarget:self action:@selector(registerBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.loginView.forgetPasswdBtn addTarget:self action:@selector(forgetnPwdBtnClick) forControlEvents:UIControlEventTouchUpInside];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

-(void)loginBtnClick
{
    NSString *patternTel = @"^1[3,5,8][0-9]{9}$";
    NSError *err = nil;
    NSRegularExpression *TelExp = [NSRegularExpression regularExpressionWithPattern:patternTel options:NSRegularExpressionCaseInsensitive error:&err];
    NSTextCheckingResult * isMatchTel = [TelExp firstMatchInString:self.loginView.userNameL.text options:0 range:NSMakeRange(0, [self.loginView.userNameL.text length])];
    if (!isMatchTel) {
        [MBProgressHUD showError:@"您输入的手机号有误，请重新输入"];
        return;
    }
    
    NSString *loginAddr = [NSString stringWithFormat:@"%@/weChat/member/loginForAndroid?mobile=%@&password=%@", serverIp, self.loginView.userNameL.text, self.loginView.passwordL.text];
    NSData *data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:loginAddr]] returningResponse:nil error:nil];
    
    if (data == nil || data.length == 0) {
        [MBProgressHUD showError:@"密码或用户名错误"];
    }
    else
    {
        globalUserName = self.loginView.userNameL.text;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        globalSessionId = dict[@"id"];
        if (globalSessionId == nil || globalSessionId.length == 0) {
            [MBProgressHUD showSuccess:@"登陆失败"];
            return;
        }
        else
        {
            [MBProgressHUD showSuccess:@"登陆成功"];
        }
        
        globalComplete = dict[@"complete"];
        globalAlipayNum = dict[@"alipayNum"];
        Account *account = [Account accountWithUid:dict[@"id"] Phone:self.loginView.userNameL.text Passwd:self.loginView.passwordL.text];
        [AccountTool saveAccount:account Path:StuArchive];
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)registerBtnClick
{
    StuProfileRegisterViewController2 *vc = [[StuProfileRegisterViewController2 alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)forgetnPwdBtnClick
{
    StuProfileResetPwdViewController2 *vc = [[StuProfileResetPwdViewController2 alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
