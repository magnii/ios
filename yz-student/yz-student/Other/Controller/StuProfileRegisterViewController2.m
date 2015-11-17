//
//  StuProfileRegisterViewController2.m
//  yz-student
//
//  Created by 仲光磊 on 15/10/14.
//  Copyright © 2015年 cdq. All rights reserved.
//

#import "StuProfileRegisterViewController2.h"
#import "StuProfileRegisterView.h"
#import "StuConfig.h"
#import "MBProgressHUD+MJ.h"
#import "Account.h"
#import "AccountTool.h"

#define registerViewH 280

@interface StuProfileRegisterViewController2 ()

@property(nonatomic, strong)StuProfileRegisterView *registerView;
@property(nonatomic, assign)int timeAg;

@end

@implementation StuProfileRegisterViewController2

- (StuProfileRegisterView *)registerView
{
    if (_registerView == nil) {
        _registerView = [StuProfileRegisterView viewFromNib];
    }
    return _registerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.registerView.frame = CGRectMake(0, 64, screenFrame.size.width, registerViewH);
    [self.view addSubview:self.registerView];
    
    [self.registerView.obtainIdentifyBtn addTarget:self action:@selector(registBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.registerView.commitBtn addTarget:self action:@selector(commitBtnClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)registBtnClick
{
    if (self.registerView.telephoneTextFiled.text.length != 11) {
        [MBProgressHUD showError:@"请输入正确的手机号"];
    }
    else
    {
        if (![self getIdentifyCode:self.registerView.telephoneTextFiled.text]) {
            [MBProgressHUD showError:@"验证码发送失败"];
            return;
        }
        self.timeAg = 60;
        self.registerView.timeL.text = [NSString stringWithFormat:@"%d", self.timeAg];
        self.registerView.obtainIdentifyBtn.hidden = YES;
        self.registerView.identifyView.hidden = NO;
        
        [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerCal:) userInfo:nil repeats:YES];
    }
}

- (void)timerCal:(NSTimer*)timer
{
    self.timeAg--;
    self.registerView.timeL.text = [NSString stringWithFormat:@"%d", self.timeAg];
    if (self.timeAg == 0) {
        self.registerView.obtainIdentifyBtn.hidden = NO;
        self.registerView.identifyView.hidden = YES;
        [timer invalidate];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (BOOL)checkPwd
{
    return [self.registerView.passwdOnceTextField.text isEqualToString:self.registerView.passwdSecondTextField.text];
}

- (void)commitBtnClick
{
    //[self dismissViewControllerAnimated:YES completion:nil];
    //注册完毕需要自动登录，获取globalSessionId
    
    NSString *patternTel = @"^1[3,5,8][0-9]{9}$";
    NSError *err = nil;
    NSRegularExpression *TelExp = [NSRegularExpression regularExpressionWithPattern:patternTel options:NSRegularExpressionCaseInsensitive error:&err];
    NSTextCheckingResult * isMatchTel = [TelExp firstMatchInString:self.registerView.telephoneTextFiled.text options:0 range:NSMakeRange(0, [self.registerView.telephoneTextFiled.text length])];
    if (!isMatchTel) {
        [MBProgressHUD showError:@"您输入的手机号有误，请重新输入"];
        return;
    }
    
    if (![self checkPwd]) {
        [MBProgressHUD showError:@"两次密码输入不一致"];
        return;
    }
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/weChat/member/registerForAndorid", serverIp];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    request.timeoutInterval = 5.0;
    request.HTTPMethod = @"POST";
    NSString *param=[NSString stringWithFormat:@"mobile=%@&password=%@&msg=%@&invitationCode=%@",self.registerView.telephoneTextFiled.text,self.registerView.passwdSecondTextField.text, self.registerView.identifyTextField.text, self.registerView.InvitationTextField.text];
    request.HTTPBody=[param dataUsingEncoding:NSUTF8StringEncoding];
    NSURLResponse *response = [[NSURLResponse alloc]init];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    if ([str isEqualToString:@"\"1\""]) {
        [MBProgressHUD showError:@"手机号码已存在"];
    }
    else if([str isEqualToString:@"\"2\""])
    {
        [MBProgressHUD showError:@"验证码错误"];
    }
    else if([str isEqualToString:@"\"3\""])
    {
        [MBProgressHUD showError:@"邀请码错误"];
    }
    else if([str isEqualToString:@"\"4\""])
    {
        [MBProgressHUD showSuccess:@"注册成功"];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        [MBProgressHUD showError:@"注册失败"];
    }
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
@end
