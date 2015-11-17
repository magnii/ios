//
//  SjLoginViewController.m
//  yz-student
//
//  Created by 仲光磊 on 15/10/28.
//  Copyright © 2015年 cdq. All rights reserved.
//

#import "SjLoginViewController.h"
#import "StuConfig.h"
#import "MBProgressHUD+MJ.h"
#import "Account.h"
#import "AccountTool.h"
#import "SjTabBarViewController.h"
#import "SjRegisterViewController.h"

NSString *sjGlobalSessionId;

@interface SjLoginViewController ()

@end

@implementation SjLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.sjLoginBtn addTarget:self action:@selector(sjLoginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.sjRegisterBtn addTarget:self action:@selector(sjRegisterBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    Account *account = [AccountTool account:SjArchive];
    self.sjUserNameL.text = account.name;
    self.sjPasswdL.text = account.passwd;
}

- (void)sjRegisterBtnClick
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"SjRegister" bundle:[NSBundle mainBundle]];
    SjRegisterViewController *vc = [sb instantiateViewControllerWithIdentifier:@"SjRegister"];
    [self presentViewController:vc animated:YES completion:nil];
//    [self.navigationController pushViewController:vc animated:YES];
}

- (void)sjLoginBtnClick
{
//    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/web/enterprise/login4App", sjIp]];
//    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:URL];
//    request.timeoutInterval=5.0;//设置请求超时为5秒
//    request.HTTPMethod=@"POST";//设置请求方法
//    
//    //设置请求体
//    NSString *param=[NSString stringWithFormat:@"loginName=%@&password=%@",self.sjUserNameL.text, self.sjPasswdL.text];
//    //把拼接后的字符串转换为data，设置请求体
//    request.HTTPBody=[param dataUsingEncoding:NSUTF8StringEncoding];
//    
//    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
//    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//    if ([str isEqual:@"\"error\""]) {
//        return NO;
//    }
//    else
//    {
//        return YES;
//    }
    
    sjGlobalSessionId = nil;
    
    NSString *strUrl = [NSString stringWithFormat:@"%@/web/enterprise/login4App?loginName=%@&password=%@", sjIp, self.sjUserNameL.text, self.sjPasswdL.text];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:strUrl]] returningResponse:nil error:nil];
    NSArray *array = [NSArray array];
    if (data.length != 0) {
        array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    }
    NSDictionary *dict = [array firstObject];
    NSString *str = dict[@"state"];
    
    if ([str isEqualToString:@"success"]) {
        Account *account = [Account accountWithUid:@"" Phone:self.sjUserNameL.text Passwd:self.sjPasswdL.text];
        [AccountTool saveAccount:account Path:SjArchive];
        sjGlobalSessionId = dict[@"id"];
//        sjGlobalSessionId = [[idStr substringFromIndex:0]substringToIndex:idStr.length-1];
        [MBProgressHUD showSuccess:@"登陆成功"];
        
        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        SjTabBarViewController *tabVc = [[SjTabBarViewController alloc]init];
        window.rootViewController = tabVc;
    }
    else if ([str isEqual:@"\"1\""])
    {
        [MBProgressHUD showError:@"用户名或密码错误"];
    }
    else if ([str isEqual:@"\"2\""])
    {
        [MBProgressHUD showError:@"用户不存在"];
    }
    else if ([str isEqual:@"\"3\""])
    {
        [MBProgressHUD showError:@"密码错误"];
    }
    else
    {
        [MBProgressHUD showError:@"登陆失败"];
    }
}

@end
