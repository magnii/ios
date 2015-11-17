//
//  StuProfileResetPwdViewController2.m
//  yz-student
//
//  Created by 仲光磊 on 15/10/14.
//  Copyright © 2015年 cdq. All rights reserved.
//

#import "StuProfileResetPwdViewController2.h"
#import "StuProfileForgetView.h"
#import "StuConfig.h"
#import "MBProgressHUD+MJ.h"

#define forgetViewH 230

@interface StuProfileResetPwdViewController2 ()

@property(nonatomic, strong)StuProfileForgetView *forgetView;
@property(nonatomic, assign)int timeAg;

@end

@implementation StuProfileResetPwdViewController2

- (StuProfileForgetView *)forgetView
{
    if (_forgetView == nil) {
        _forgetView = [StuProfileForgetView viewFromNib];
    }
    return _forgetView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"密码重置";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.forgetView.frame = CGRectMake(0, 64, screenFrame.size.width, forgetViewH);
    [self.view addSubview:self.forgetView];
    
    [self.forgetView.obtainIdentifyBtn addTarget:self action:@selector(registBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.forgetView.resetBtn addTarget:self action:@selector(resetBtnClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)registBtnClick
{
    if (self.forgetView.telephoneTextField.text.length != 11) {
        [MBProgressHUD showError:@"请输入正确的手机号"];
    }
    else
    {
        if (![self getIdentifyCode:self.forgetView.telephoneTextField.text]) {
            [MBProgressHUD showError:@"验证码发送失败"];
            return;
        }
        self.timeAg = 60;
        self.forgetView.timeL.text = [NSString stringWithFormat:@"%d", self.timeAg];
        self.forgetView.obtainIdentifyBtn.hidden = YES;
        self.forgetView.identifyView.hidden = NO;
        
        [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerCal:) userInfo:nil repeats:YES];
    }
}

- (void)timerCal:(NSTimer*)timer
{
    self.timeAg--;
    self.forgetView.timeL.text = [NSString stringWithFormat:@"%d", self.timeAg];
    if (self.timeAg == 0) {
        self.forgetView.obtainIdentifyBtn.hidden = NO;
        self.forgetView.identifyView.hidden = YES;
        [timer invalidate];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (BOOL)checkPwd
{
    return [self.forgetView.passwdOnceTextField.text isEqualToString:self.forgetView.passwdSecondTextField.text];
}

- (BOOL)getIdentifyCode:(NSString*)mobile
{
    NSString *strUrl = [NSString stringWithFormat:@"%@/weChat/captcha/sendCaptcha?mobile=%@", serverIp, mobile];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:strUrl]] returningResponse:nil error:nil];
    
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    if ([str isEqualToString:@"\"success\""]) {
        return YES;
    }
    else
    {
        return NO;
    }
}

- (void)resetBtnClick
{
    //[self dismissViewControllerAnimated:YES completion:nil];
    //注册完毕需要自动登录，获取globalSessionId
    
    NSString *patternTel = @"^1[3,5,8][0-9]{9}$";
    NSError *err = nil;
    NSRegularExpression *TelExp = [NSRegularExpression regularExpressionWithPattern:patternTel options:NSRegularExpressionCaseInsensitive error:&err];
    NSTextCheckingResult * isMatchTel = [TelExp firstMatchInString:self.forgetView.telephoneTextField.text options:0 range:NSMakeRange(0, [self.forgetView.telephoneTextField.text length])];
    if (!isMatchTel) {
        [MBProgressHUD showError:@"您输入的手机号有误，请重新输入"];
        return;
    }
    
    if (![self checkPwd]) {
        [MBProgressHUD showError:@"两次密码输入不一致"];
        return;
    }
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/weChat/member/changePassword", serverIp];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    request.timeoutInterval = 5.0;
    request.HTTPMethod = @"POST";
    NSString *param=[NSString stringWithFormat:@"mobile=%@&password=%@&msg=%@&isApp=%@",self.forgetView.telephoneTextField.text,self.forgetView.passwdOnceTextField.text, self.forgetView.identifyTextField.text, @"1"];
    request.HTTPBody=[param dataUsingEncoding:NSUTF8StringEncoding];
    NSURLResponse *response = [[NSURLResponse alloc]init];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    if ([str isEqualToString:@"\"success\""]) {
        [MBProgressHUD showSuccess:@"密码修改成功"];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if([str isEqualToString:@"\"error\""])
    {
        [MBProgressHUD showError:@"密码修改失败"];
    }
    else if([str isEqualToString:@"\"captcha_error\""])
    {
        [MBProgressHUD showError:@"验证码错误"];
    }
    else
    {
        [MBProgressHUD showError:@"密码修改失败"];
    }
}

@end
