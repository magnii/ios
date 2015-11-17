//
//  HomeFourBtnView.m
//  yz-student
//
//  Created by 仲光磊 on 15/9/2.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import "StuHomeFourBtnView.h"
#import "StuHomeFourBtnOne.h"
#import "StuConfig.h"

#define imgWH 40
#define labelH 15
#define labelW 40
#define UBpadding 2
#define LRPadding 15

@implementation HomeFourBtnView

- (UIView *)highSalaryView
{
    if (_highSalaryView == nil) {
        _highSalaryView = [StuHomeFourBtnOne btnOneWithImg:@"aaa1" bottomL:@"高薪日结"];
    }
    return _highSalaryView;
}

- (UIView *)jobBBView
{
    if (_jobBBView == nil) {
        _jobBBView = [StuHomeFourBtnOne btnOneWithImg:@"aaa2" bottomL:@"全民包办"];
    }
    return _jobBBView;
}

- (UIView *)trainView
{
    if (_trainView == nil) {
        _trainView = [StuHomeFourBtnOne btnOneWithImg:@"aaa3" bottomL:@"培训活动"];
    }
    return _trainView;
}

- (UIView *)preSalaryView
{
    if (_preSalaryView == nil) {
        _preSalaryView = [StuHomeFourBtnOne btnOneWithImg:@"aaa4" bottomL:@"预支工资"];
    }
    return _preSalaryView;
}





+ (instancetype)fourBtnInstance
{
    HomeFourBtnView *fourBtn = [[HomeFourBtnView alloc]init];
    [fourBtn addSubview: fourBtn.highSalaryView];
    [fourBtn addSubview:fourBtn.jobBBView];
    [fourBtn addSubview:fourBtn.trainView];
    [fourBtn addSubview:fourBtn.preSalaryView];
    [fourBtn setAllFrames];
    
    return fourBtn;
}

- (void)setAllFrames
{
    CGFloat btnPadding = (screenFrame.size.width - 2*LRPadding - 4*imgWH)/3.0;
    
    self.highSalaryView.frame = CGRectMake(LRPadding, UBpadding, imgWH, imgWH+labelH);
    self.jobBBView.frame = CGRectMake(CGRectGetMaxX(self.highSalaryView.frame)+btnPadding, UBpadding, imgWH, imgWH+labelH);
    self.trainView.frame = CGRectMake(CGRectGetMaxX(self.jobBBView.frame)+btnPadding, UBpadding, imgWH, imgWH+labelH);
    self.preSalaryView.frame = CGRectMake(CGRectGetMaxX(self.trainView.frame)+btnPadding, UBpadding, imgWH, imgWH+labelH);
}

@end
