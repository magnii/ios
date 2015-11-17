//
//  StuProfileMyBasicInfoViewController.m
//  yz-student
//
//  Created by 仲光磊 on 15/10/3.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import "StuProfileMyBasicInfoViewController.h"
#import "StuProfileUserInfo.h"
#import "StuProfileMyBasicView.h"
#import "StuConfig.h"
#import "MBProgressHUD+MJ.h"
#import "StuProfileUserInfo.h"

extern NSString *globalSessionId;
extern NSString *globalComplete;

@interface StuProfileMyBasicInfoViewController ()<UIAlertViewDelegate>

@property(nonatomic, strong)StuProfileMyBasicView *basicInfoView;

@end

@implementation StuProfileMyBasicInfoViewController

- (StuProfileMyBasicView *)basicInfoView
{
    if (_basicInfoView == nil) {
        _basicInfoView = [StuProfileMyBasicView basicInfoViewFromNib];
    }
    return _basicInfoView;
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
    self.title = @"基本信息";
    
    self.basicInfoView.nameL.text = self.userInfo.name;
    if ([self.userInfo.gender isEqualToString:@"男"]) {
        self.basicInfoView.genderL.text = self.userInfo.gender;
    }
    else
    {
        self.basicInfoView.genderL.text = @"女";
    }
    
    [self.basicInfoView.genderL addTarget:self action:@selector(genderClick) forControlEvents:UIControlEventTouchDown];
    self.basicInfoView.heightL.text = self.userInfo.height;
    
    [self.basicInfoView.basicInfoCommitBtn addTarget:self action:@selector(basicInfoCommitClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.basicInfoView.frame = CGRectMake(0, 64, screenFrame.size.width, 500);
    [self.view addSubview:self.basicInfoView];
}

- (void)genderClick
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"性别选择" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"男",@"女", nil];
    [alertView show];
}

- (void)basicInfoCommitClick
{
    NSString *url = @"/weChat/member/updateBasicInfo";
    
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", serverIp, url]];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:URL];
    request.timeoutInterval=5.0;//设置请求超时为5秒
    request.HTTPMethod=@"POST";//设置请求方法
    
    //设置请求体
    NSString *param=[NSString stringWithFormat:@"name=%@&gender=%@&height=%@&id=%@",self.basicInfoView.nameL.text, self.basicInfoView.genderL.text, self.basicInfoView.heightL.text, globalSessionId];
    //把拼接后的字符串转换为data，设置请求体
    request.HTTPBody=[param dataUsingEncoding:NSUTF8StringEncoding];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    if ([str isEqual:@"\"success\""]) {
        [MBProgressHUD showSuccess:@"信息修改成功"];
        globalComplete = @"1";
        self.userInfo.name = self.basicInfoView.nameL.text;
        self.userInfo.gender = self.basicInfoView.genderL.text;
        self.userInfo.height = self.basicInfoView.heightL.text;
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        [MBProgressHUD showError:@"信息修改失败"];
    }
}

#pragma alertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self.basicInfoView.genderL resignFirstResponder];
    if (buttonIndex == 0) {
        self.basicInfoView.genderL.text = @"男";
        self.userInfo.gender = @"男";
    }
    else
    {
        self.basicInfoView.genderL.text = @"女";
        self.userInfo.gender = @"女";
    }
}

- (void)touchesBegan:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
