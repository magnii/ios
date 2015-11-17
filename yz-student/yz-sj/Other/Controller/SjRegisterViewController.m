//
//  SjRegisterViewController.m
//  yz-student
//
//  Created by 仲光磊 on 15/10/29.
//  Copyright © 2015年 cdq. All rights reserved.
//

#import "SjRegisterViewController.h"
#import "StuProfileRegisterView.h"
#import "StuConfig.h"
#import "MBProgressHUD+MJ.h"

#define registerViewH 280

@interface SjRegisterViewController ()

@property(nonatomic, assign)int timeAg;

@end

@implementation SjRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.obtainIdentifyBtn addTarget:self action:@selector(registBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.commitBtn addTarget:self action:@selector(commitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:singleFingerTap];
}
- (void)dismissKeyboard
{
    [self.view endEditing:YES];
}

- (BOOL)checkPwd
{
    return [self.passwdOnceTextField.text isEqualToString:self.passwdSecondTextField.text];
}

- (void)commitBtnClick
{
    //[self dismissViewControllerAnimated:YES completion:nil];
    //注册完毕需要自动登录，获取globalSessionId
    
    if ([self.sjUserNameTextFiled.text isEqualToString:@""] || [self.sjUserNameTextFiled.text isEqualToString:@" "]) {
        [MBProgressHUD showError:@"请输入用户名"];
        return;
    }
    
    NSString *patternTel = @"^1[3,5,8][0-9]{9}$";
    NSError *err = nil;
    NSRegularExpression *TelExp = [NSRegularExpression regularExpressionWithPattern:patternTel options:NSRegularExpressionCaseInsensitive error:&err];
    NSTextCheckingResult * isMatchTel = [TelExp firstMatchInString:self.telephoneTextFiled.text options:0 range:NSMakeRange(0, [self.telephoneTextFiled.text length])];
    if (!isMatchTel) {
        [MBProgressHUD showError:@"您输入的手机号有误，请重新输入"];
        return;
    }
    
    if (![self checkPwd]) {
        [MBProgressHUD showError:@"两次密码输入不一致"];
        return;
    }
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/web/enterprise/register4App", sjIp];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    request.timeoutInterval = 5.0;
    request.HTTPMethod = @"POST";
    NSString *param=[NSString stringWithFormat:@"loginName=%@&password=%@&contactNumber=%@&msgCode=%@", self.sjUserNameTextFiled.text,self.passwdSecondTextField.text,self.telephoneTextFiled.text, self.identifyTextField.text];
    request.HTTPBody=[param dataUsingEncoding:NSUTF8StringEncoding];
    NSURLResponse *response = [[NSURLResponse alloc]init];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    if ([str isEqualToString:@"\"1\""]) {
        [MBProgressHUD showError:@"用户名为空"];
    }
    else if([str isEqualToString:@"\"2\""])
    {
        [MBProgressHUD showError:@"手机号为空"];
    }
    else if([str isEqualToString:@"\"3\""])
    {
        [MBProgressHUD showError:@"手机验证码错误"];
    }
    else if([str isEqualToString:@"\"4\""])
    {
        [MBProgressHUD showError:@"密码为空"];
    }
    else if([str isEqualToString:@"\"5\""])
    {
        [MBProgressHUD showError:@"用户名已存在"];
    }
    else if([str isEqualToString:@"\"success\""])
    {
        [MBProgressHUD showSuccess:@"注册成功"];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {
        [MBProgressHUD showError:@"注册失败"];
    }
}

- (void)registBtnClick
{
    if (self.telephoneTextFiled.text.length != 11) {
        [MBProgressHUD showError:@"请输入正确的手机号"];
    }
    else
    {
        if (![self getIdentifyCode:self.telephoneTextFiled.text]) {
            [MBProgressHUD showError:@"验证码发送失败"];
            return;
        }
        self.timeAg = 60;
        self.timeL.text = [NSString stringWithFormat:@"%d", self.timeAg];
        self.obtainIdentifyBtn.hidden = YES;
        self.identifyView.hidden = NO;
        
        [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerCal:) userInfo:nil repeats:YES];
    }
}

- (void)timerCal:(NSTimer*)timer
{
    self.timeAg--;
    self.timeL.text = [NSString stringWithFormat:@"%d", self.timeAg];
    if (self.timeAg == 0) {
        self.obtainIdentifyBtn.hidden = NO;
        self.identifyView.hidden = YES;
        [timer invalidate];
    }
}

- (BOOL)getIdentifyCode:(NSString*)mobile
{
    NSString *strUrl = [NSString stringWithFormat:@"%@/web/captcha/sendCaptcha?mobile=%@", sjIp, mobile];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:strUrl]] returningResponse:nil error:nil];
    
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    if (str.length == 8) {
        return YES;
    }
    else
    {
        return NO;
    }
}

- (IBAction)backBtnClick:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
