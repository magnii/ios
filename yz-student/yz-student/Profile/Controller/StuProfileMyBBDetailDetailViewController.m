//
//  StuProfileMyBBDetailDetailTableViewController.m
//  yz-student
//
//  Created by 仲光磊 on 15/9/20.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import "StuProfileMyBBDetailDetailViewController.h"
#import "StuProfileBBInfo.h"
#import "StuConfig.h"
#import "StuHomeLocalJob.h"
#import "StuProfileBBOnePeople.h"

#import "StuProfileMyBBAllDates.h"
#import "StuProfileMyBBDetailDetailDetailViewController.h"

#define myGrayColor [UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1.0]
#define commandH 30
#define labelH 25

#define cellTagStart 5001

#define StuProfileMyBBAllDatesH 120

extern NSString *globalSessionId;

@interface StuProfileMyBBDetailDetailViewController ()<UIAlertViewDelegate>

@property(nonatomic, strong)StuProfileBBInfo *bbInfo;
@property(nonatomic, strong)NSArray *jobPeoplesArray;
@property(nonatomic, strong)UIScrollView *scrollView;
@property(nonatomic, strong)UILabel *commandL;
@property(nonatomic, assign)int cellTag;

@end

@implementation StuProfileMyBBDetailDetailViewController

- (UILabel *)commandL
{
    if (_commandL == nil) {
        _commandL = [[UILabel alloc]init];
    }
    return _commandL;
}

- (UIScrollView *)scrollView
{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc]init];
    }
    return _scrollView;
}

- (StuProfileBBInfo *)bbInfo
{
    if (_bbInfo == nil) {
        _bbInfo = [[StuProfileBBInfo alloc]init];
    }
    return _bbInfo;
    
}

- (NSArray *)jobsArray
{
    if (_jobPeoplesArray == nil) {
        _jobPeoplesArray = [NSArray array];
    }
    return _jobPeoplesArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的包办";
    
    [self.view addSubview:self.scrollView];
    self.scrollView.frame = CGRectMake(0, commandH, screenFrame.size.width, screenFrame.size.height);
    
    self.bbInfo = [StuProfileBBInfo bbJobsWithSessionId:globalSessionId JobId:self.oneJob.jobId];
    self.jobPeoplesArray = self.bbInfo.recordDatesArry;
    
    self.commandL.text = [NSString stringWithFormat:@"我的口令:%@", self.bbInfo.command];
    [self.commandL setTextColor:[UIColor colorWithRed:240/255.0 green:143/255.0 blue:2/255.0 alpha:1.0]];
    [self.commandL setTextAlignment:NSTextAlignmentCenter];
    self.commandL.frame = CGRectMake(0, 64, screenFrame.size.width, commandH);
    [self.commandL setFont:[UIFont boldSystemFontOfSize:16]];
    self.commandL.backgroundColor = [UIColor colorWithRed:239/255.0 green:249/255.0 blue:255/255.0 alpha:1.0];
    [self.view addSubview:self.commandL];
    
    CGFloat lastCellY = 0;
    self.cellTag = cellTagStart;
    for (StuProfileBBOnePeople *onePeople in self.jobPeoplesArray)
    {
        StuProfileMyBBAllDates *view = [StuProfileMyBBAllDates loadView];
        
        [self.scrollView addSubview:view];
        view.dateL.text = [onePeople.date substringFromIndex:5];
        view.endTime = [onePeople.endTime intValue];
        [view.detailBtn addTarget:self action:@selector(detailBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        view.detailBtn.tag = self.cellTag++;
        
        CGFloat viewH = StuProfileMyBBAllDatesH;
        if ([onePeople.status isEqualToString:@"0"]) {
            view.stateL.text = @"可用";
        }
        else if ([onePeople.status isEqualToString:@"1"]) {
            view.stateL.text = @"倒计时中";
        }
        else if ([onePeople.status isEqualToString:@"2"]) {
            view.stateL.text = @"成功";
            viewH -= labelH;
        }
        else if ([onePeople.status isEqualToString:@"3"]) {
            view.stateL.text = @"失败";
            viewH -= labelH;
        }
        else if ([onePeople.status isEqualToString:@"4"]) {
            view.stateL.text = @"完工";
            viewH -= labelH;
        }
        else
        {
            view.stateL.text = @"已结算";
            viewH -= labelH;
        }
        
        view.frame = CGRectMake(0, lastCellY, screenFrame.size.width, viewH);
        
        [view restAllFrames];
        view.backgroundColor = myGrayColor;
        
        [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerCal2:) userInfo:view repeats:YES];
        lastCellY = CGRectGetMaxY(view.frame)+20;
    }
    
    self.scrollView.contentSize = CGSizeMake(screenFrame.size.width, lastCellY+commandH*2);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.bbInfo = [StuProfileBBInfo bbJobsWithSessionId:globalSessionId JobId:self.oneJob.jobId];
    self.jobPeoplesArray = self.bbInfo.recordDatesArry;

    for (int i = 0; i<self.scrollView.subviews.count; i++) {
        if (![self.scrollView.subviews[i] isKindOfClass:[StuProfileMyBBAllDates class]]) {
            continue;
        }
        StuProfileMyBBAllDates *view = (StuProfileMyBBAllDates*)self.scrollView.subviews[i];
        StuProfileBBOnePeople *onePeople = self.jobPeoplesArray[i];
        
        if ([onePeople.status isEqualToString:@"0"]) {
            view.stateL.text = @"可用";
        }
        else if ([onePeople.status isEqualToString:@"1"]) {
            view.stateL.text = @"倒计时中";
        }
        else if ([onePeople.status isEqualToString:@"2"]) {
            view.stateL.text = @"成功";
        }
        else if ([onePeople.status isEqualToString:@"3"]) {
            view.stateL.text = @"失败";
        }
        else if ([onePeople.status isEqualToString:@"4"]) {
            view.stateL.text = @"完工";
        }
        else
        {
            view.stateL.text = @"已结算";
        }
        [view restAllFrames];
    }
}

- (void)detailBtnClick:(UIButton*)btn
{
    StuProfileMyBBDetailDetailDetailViewController *vc = [[StuProfileMyBBDetailDetailDetailViewController alloc]init];
    vc.recruitNum = self.oneJob.recruitNum;
    vc.jobId = self.oneJob.jobId;
    int tagIndex = 0;
    for (StuProfileBBOnePeople *onePeople in self.jobPeoplesArray)
    {
        if (btn.tag == tagIndex+cellTagStart) {
            vc.relationId = onePeople.relationId;
            vc.status = onePeople.status;
            break;
        }
        tagIndex++;
    }
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)timerCal2:(NSTimer*)timer
{
    StuProfileMyBBAllDates *view = [timer userInfo];
    
    int timeAg = view.endTime-1;
    view.endTime = timeAg;
    if (timeAg <= 0) {
        view.hourL.text = @"00时";
        view.minuteL.text = @"00分";
        view.secondL.text = @"00";
        [timer invalidate];
    }
    else
    {
        view.hourL.text = [NSString stringWithFormat:@"%02d时", timeAg/60/60];
        view.minuteL.text = [NSString stringWithFormat:@"%02d分", (timeAg-timeAg/60/60*60*60)/60];
        view.secondL.text = [NSString stringWithFormat:@"%02d", timeAg-timeAg/60/60*60*60 - (timeAg-timeAg/60/60*60*60)/60*60];
    }
}
@end
