//
//  StuProfileMyJobsDetailDetailViewController.m
//  yz-student
//
//  Created by 仲光磊 on 15/9/19.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import "StuProfileMyJobsDetailDetailViewController.h"
#import "StuConfig.h"
#import "StuProfileMyJobDetailDetailView.h"
#import "StuHomeLocalJob.h"
#import "StuProfileMyJobDetailDateBtn.h"
#import "StuJobDateObj.h"
#import "AFNetworking.h"
#import "MBProgressHUD+MJ.h"
#import "StuProfileMyJobsInfo.h"

extern NSString *globalSessionId;

@interface StuProfileMyJobsDetailDetailViewController ()

@property(nonatomic, strong)UIScrollView *jobDetalScrollView;
@property(nonatomic, strong)StuProfileMyJobDetailDetailView *detailView;
@property(nonatomic, strong)NSArray *myJobInfoArray;

@end

@implementation StuProfileMyJobsDetailDetailViewController

- (NSArray *)myJobInfoArray
{
    if (_myJobInfoArray == nil) {
        _myJobInfoArray = [NSArray array];
    }
    return _myJobInfoArray;
}

- (UIScrollView *)jobDetalScrollView
{
    if (_jobDetalScrollView == nil) {
        _jobDetalScrollView = [[UIScrollView alloc]init];
    }
    return _jobDetalScrollView;
}

- (StuProfileMyJobDetailDetailView *)detailView
{
    if (_detailView == nil) {
        _detailView = [StuProfileMyJobDetailDetailView viewFromNib];
    }
    return _detailView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"兼职信息";
    
    self.jobDetalScrollView.frame = CGRectMake(0, 0, screenFrame.size.width, screenFrame.size.height);
    self.jobDetalScrollView.contentSize = CGSizeMake(screenFrame.size.width, 1000);
    [self.view addSubview:self.jobDetalScrollView];
    
    [self loadDetailContent];
    self.detailView.frame = CGRectMake(0, 0, screenFrame.size.width, 470);
    [self.jobDetalScrollView addSubview:self.detailView];
    
    [self loadJobDetailBtns];
}

- (void)loadDetailContent
{
    self.detailView.numbersL.text = [NSString stringWithFormat:@"%d", self.oneJob.recruitNum];
    self.detailView.salaryL.text = [NSString stringWithFormat:@"%d%@", self.oneJob.salary, self.oneJob.unit];
    NSString *tmpStr = self.oneJob.settlementPeriod;
    if ([tmpStr isEqualToString:@"day"]) {
        self.detailView.balanceL.text = @"日结";
    }
    else if ([tmpStr isEqualToString:@"weak"]) {
        self.detailView.balanceL.text = @"周结";
    }
    else if ([tmpStr isEqualToString:@"month"]) {
        self.detailView.balanceL.text = @"月结";
    }
    else if ([tmpStr isEqualToString:@"end"]) {
        self.detailView.balanceL.text = @"完工结";
    }
    self.detailView.startDateL.text = [self.oneJob.workingStartDate substringToIndex:10];
    self.detailView.endDateL.text = [self.oneJob.workingEndDate substringToIndex:10];
    self.detailView.workHL.text = self.oneJob.workingHours;
    self.detailView.addressL.text = self.oneJob.jobAddress;
    self.detailView.contentL.text = self.oneJob.workContent;
    self.detailView.gentderL.text = self.oneJob.genderLimit;
    self.detailView.heightL.text = self.oneJob.heightLimit;
    self.detailView.specialL.text = self.oneJob.specialRequired;
}

- (void)loadJobDetailBtns
{
    self.myJobInfoArray = [StuProfileMyJobsInfo myJobsInfoWithSessionId:globalSessionId JobId:self.oneJob.jobId];

    CGFloat btnX=45;
    CGFloat btnY=CGRectGetMaxY(self.detailView.frame);
    int i = 0;
    CGFloat btnMaxH = 0;
    int tag = 0;
    for (StuProfileMyJobsInfo *info in self.myJobInfoArray) {
        StuProfileMyJobDetailDateBtn *btn = [StuProfileMyJobDetailDateBtn dateBtnFromNib];
        btn.dateL.text = info.date;
        btn.jobId = info.date_id;
        if (i%2==0) {
            btn.frame = CGRectMake(btnX, btnY, 110, 20);
        }
        else
        {
            btn.frame = CGRectMake(screenFrame.size.width-45-110, btnY, 110, 20);
            btnY = btnY+20+20;
        }
        i++;
        
        [self.jobDetalScrollView addSubview:btn];
        
        btnMaxH = CGRectGetMaxY(btn.frame);
        tag++;
        [btn.dateBtn setTag:tag];
        [btn.dateBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        if ([info.status isEqualToString:@"3"]) {
            btn.dateBtn.userInteractionEnabled = NO;
            [btn.dateBtn setTitle:@"完成" forState:UIControlStateNormal];
        }else if ([info.status isEqualToString:@"1"])
        {
            btn.dateBtn.hidden = YES;
            UIImageView *imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"lu"]];
            imgView.frame = CGRectMake(CGRectGetMaxX(btn.dateL.frame), btn.dateL.frame.origin.y, 20, 20);
            [btn addSubview:imgView];
        }
    }
    
    self.jobDetalScrollView.contentSize = CGSizeMake(screenFrame.size.width, btnMaxH+100);
}

- (void)btnClick:(UIButton*)btn
{

    NSURL *URL = [NSURL URLWithString:[NSString string]];
    if (self.oneJob.isAgent!=nil && [self.oneJob.isAgent isEqualToString:@"1"]) {
        URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/weChat/arrangedRecrod/cancelJob4App", serverIp]];
    }
    else
    {
        URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/weChat/signUp/cancelJob4App", serverIp]];
    }
    
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:URL];//默认为get请求
    request.timeoutInterval=5.0;//设置请求超时为5秒
    request.HTTPMethod=@"POST";//设置请求方法
    
    StuProfileMyJobsInfo *info = self.myJobInfoArray[btn.tag-1];
    //设置请求体
    NSString *param=[NSString stringWithFormat:@"dateId=%@&memberId=%@&jobId=%@",info.date_id, globalSessionId, self.oneJob.jobId];
    //把拼接后的字符串转换为data，设置请求体
    request.HTTPBody=[param dataUsingEncoding:NSUTF8StringEncoding];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *responseStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    if ([responseStr isEqualToString:@"\"success\"" ]) {
        [MBProgressHUD showSuccess:@"职位取消成功"];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if([responseStr isEqualToString:@"\"arranged is finish\""])
    {
        [MBProgressHUD showError:@"包办已经结束"];
    }
    else
    {
        [MBProgressHUD showError:@"职位取消失败"];
    }
}

@end
