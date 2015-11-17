//
//  SjProfileResetPwdViewController.m
//  yz-student
//
//  Created by 仲光磊 on 15/10/29.
//  Copyright © 2015年 cdq. All rights reserved.
//

#import "SjProfileResetPwdViewController.h"
#import "SjLoginViewController.h"
#import "StuConfig.h"
#import "MBProgressHUD+MJ.h"
#import "Account.h"
#import "AccountTool.h"

extern NSString *sjGlobalSessionId;

@interface SjProfileResetPwdViewController ()

@end

@implementation SjProfileResetPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"修改密码";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)resetPwdBtnClick:(id)sender
{
    if (![self checkIsValid]) {
        return;
    }
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/web/enterprise/changePwd4App", sjIp];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    request.timeoutInterval = 5.0;
    request.HTTPMethod = @"POST";
    NSString *param=[NSString stringWithFormat:@"id=%@&oldPwd=%@&newPwd=%@", sjGlobalSessionId, self.oldPwdTextField.text, self.oncePwdTextField.text];
    request.HTTPBody=[param dataUsingEncoding:NSUTF8StringEncoding];
    NSURLResponse *response = [[NSURLResponse alloc]init];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    if ([str isEqualToString:@"\"success\""])
    {
        [MBProgressHUD showSuccess:@"密码修改成功"];
        
        Account *account = [Account accountWithUid:@"" Phone:@"" Passwd:self.oncePwdTextField.text];
        [AccountTool saveAccount:account Path:SjArchive];
        
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"SjLogin" bundle:[NSBundle mainBundle]];
        SjLoginViewController *vc = [sb instantiateViewControllerWithIdentifier:@"SjLogin"];

//        [self.navigationController pushViewController:vc animated:YES];
        [self presentViewController:vc animated:YES completion:nil];

    }
    else if ([str isEqualToString:@"\"1\""])
    {
        [MBProgressHUD showError:@"参数为空"];
    }
    else if ([str isEqualToString:@"\"2\""])
    {
        [MBProgressHUD showError:@"用户id有误"];
    }
    else if ([str isEqualToString:@"\"3\""])
    {
        [MBProgressHUD showError:@"原密码错误"];
    }
}

- (BOOL)checkIsValid
{
    if (self.oldPwdTextField.text.length < 6) {
        [MBProgressHUD showError:@"原密码输入不正确"];
        return NO;
    }
    if (self.oncePwdTextField.text.length < 6)
    {
        [MBProgressHUD showError:@"新密码至少需要六位"];
        return NO;
    }
    if (![self.oncePwdTextField.text isEqualToString:self.secondPwdTextField.text]) {
        [MBProgressHUD showError:@"输入的两次新密码不一样"];
        return NO;
    }
    if ([self.oldPwdTextField.text isEqualToString:self.oncePwdTextField.text]) {
        [MBProgressHUD showError:@"新旧密码一样"];
        return NO;
    }
    return YES;
}

@end
