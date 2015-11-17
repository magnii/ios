//
//  StuPreSalaryJobDetailViewController.m
//  yz-student
//
//  Created by 仲光磊 on 15/10/5.
//  Copyright © 2015年 cdq. All rights reserved.
//

#import "StuPreSalaryJobDetailViewController.h"
#import "StuJobDetailHead.h"
#import "StuHomeLocalJob.h"
#import "StuJobDateObj.h"
#import "StuArrangeApplyCommandView.h"
#import "StuCompanInfo.h"
#import "StuCompanyInfoModel.h"
#import "StuHomeJobTableViewCell.h"
#import "StuHomeLocalJob.h"
#import "StuArrangeDateBtn.h"
#import "StuConfig.h"
#import "MBProgressHUD+MJ.h"
#import "StuArrangeRecords.h"
#import "StuArrangeRecoredsDetail.h"
#import "StuHomeLocalJob.h"
#import "StuJobDetailViewController.h"

#define titleFontSize 16
#define textFontSize 12
#define grayLineColor [UIColor colorWithRed:147/255.0 green:147/255.0 blue:147/255.0 alpha:0.2]
#define textColor [UIColor colorWithRed:147/255.0 green:147/255.0 blue:147/255.0 alpha:1.0]
#define titleColor [UIColor colorWithRed:28/255.0 green:151/255.0 blue:220/255.0 alpha:0.7]
#define orangeColor [UIColor colorWithRed:239/255.0 green:142/255.0 blue:2/255.0 alpha:1.0]
#define blueColor [UIColor colorWithRed:28/255.0 green:141/255.0 blue:213/255.0 alpha:1.0]
#define paddingW 20
#define paddingH 10
#define titleImgWH 15
#define imgTitlePadding 5
#define labelContentW (screenFrame.size.width-paddingW*2)
#define selectJobDateBtnH 15
#define selectJobDateBtnW 110
#define selectJobDateBtnPadding ((screenFrame.size.width-selectJobDateBtnW*2)/3.0)
#define cellH 56

extern NSString *globalSessionId;
extern NSString *globalComplete;
extern NSMutableArray *preDateIdArray;
extern int preAllSalary;

@interface StuPreSalaryJobDetailViewController ()<UITableViewDataSource, UITableViewDelegate>

//**********添加企业信息中所发布的兼职**************
@property(nonatomic, strong)NSArray *companyInfoJobArry;

@property(nonatomic, strong) UIView *jobDetaiView;
@property(nonatomic, strong) UIView *jobCompanyView;

//********包办和非包办中都会用到的控件*********
@property(nonatomic, strong) UIView *jobSaveView;
@property(nonatomic, strong) UIButton *jobDetailBtn;
@property(nonatomic, strong) UIButton *companyInfoBtn;

@property(nonatomic, strong) UIView *lineView1;

@property(nonatomic, strong) UILabel *adviseL;
@property(nonatomic, strong) UIImageView *jobDescImg;
@property(nonatomic, strong) UILabel *jobDescL;
@property(nonatomic, strong) UILabel *recruitNumL;
@property(nonatomic, strong) UILabel *salaryL;
@property(nonatomic, strong) UILabel *settlementPeriodL;
@property(nonatomic, strong) UILabel *isProvideStayL;
@property(nonatomic, strong) UILabel *isProvideMealL;
@property(nonatomic, strong) UILabel *workDateL;
@property(nonatomic, strong) UILabel *workHourL;
@property(nonatomic, strong) UILabel *workAddrL;
@property(nonatomic, strong) UILabel *workContentL;

@property(nonatomic, strong) UIView *lineView2;

@property(nonatomic, strong) UIImageView *jobRequreImg;
@property(nonatomic, strong) UILabel *jobRequreL;

@property(nonatomic, strong) UILabel *genderLimitL;
@property(nonatomic, strong) UILabel *heightLimitL;
@property(nonatomic, strong) UILabel *specialLimit;

@property(nonatomic, strong) UIView *lineView3;
//**********************************************

//**注意事项在包办非包办中都会用到，但是位置不同********
@property(nonatomic, strong) UIImageView *attentionImg;
@property(nonatomic, strong) UILabel *attentionL;
@property(nonatomic, strong) UILabel *attentionContentL1;
@property(nonatomic, strong) UILabel *attentionContentL2;
@property(nonatomic, strong) UILabel *attentionContentL3;

//**********只有在非包办中用到的控件*************
@property(nonatomic, strong) UIButton *applyBtn;

//**********只有在包办中用到的控件**************
@property(nonatomic, strong) UIImageView *arrangeImg;
@property(nonatomic, strong) UILabel *arrangeL;
@property(nonatomic, strong) UILabel *arrangeInstruL;
@property(nonatomic, strong) UILabel *arrangeInstruL1;
@property(nonatomic, strong) UILabel *arrangeInstruL2;
@property(nonatomic, strong) UILabel *arrangeInstruL3;
@property(nonatomic, strong) UILabel *arrangeInstruL4;
@property(nonatomic, strong) UILabel *arrangeInstruL5;
@property(nonatomic, strong) UILabel *arrangeInstruL6;
@property(nonatomic, strong) UILabel *arrangeInstruL7;
@property(nonatomic, strong) UIView *lineView4;
@property(nonatomic, strong) UIButton *arrangeWantBtn;
@property(nonatomic, strong) UIButton *arrangeApplyBtn;

@property(nonatomic, strong) UIView *arrangeWantView;
@property(nonatomic, strong) UIView *arrangeApplyView;
//********************************************

@property(nonatomic, strong) UIScrollView *jobDetailscrollView;
//****************companyInfoModel************
@property(nonatomic, strong) StuCompanyInfoModel *companyInfoModel;
@property(nonatomic, strong) StuCompanInfo *companyInfoView;

//****************arrangeDate******************
@property(nonatomic, strong) NSMutableArray *arrangeDateArray;
@property(nonatomic, strong) NSMutableArray *nonArrangeDateArray;
@property(nonatomic, strong) NSMutableArray *applyDateArray;
//****************包办申请创建的所有包办人***********
@property(nonatomic, strong) NSMutableArray *applyViewArray;
//****************所有包办口令*********************
@property(nonatomic, strong) NSMutableArray *applyCommandArray;
//****************所有arrangedRelationIds*********************
@property(nonatomic, strong) NSMutableArray *applyRelationIdArray;
//****************所有包办的日期和所有包办的日期id**********************
@property(nonatomic, strong) NSMutableArray *arrangeAllDateArry;
@property(nonatomic, strong) NSMutableArray *arrangeAllDateIdArray;


@end

@implementation StuPreSalaryJobDetailViewController

- (NSMutableArray *)arrangeAllDateArry
{
    if (_arrangeAllDateArry == nil) {
        _arrangeAllDateArry = [NSMutableArray array];
    }
    return _arrangeAllDateArry;
}

- (NSMutableArray *)arrangeAllDateIdArray
{
    if (_arrangeAllDateIdArray == nil) {
        _arrangeAllDateIdArray = [NSMutableArray array];
    }
    return _arrangeAllDateIdArray;
}

- (NSMutableArray *)applyDateArray
{
    if (_applyDateArray == nil) {
        _applyDateArray = [NSMutableArray array];
    }
    return _applyDateArray;
}

- (NSMutableArray *)applyRelationIdArray
{
    if (_applyRelationIdArray == nil) {
        _applyRelationIdArray = [NSMutableArray array];
    }
    return _applyRelationIdArray;
}

- (NSMutableArray *)applyCommandArray
{
    if (_applyCommandArray == nil) {
        _applyCommandArray = [NSMutableArray array];
    }
    return _applyCommandArray;
}

- (NSMutableArray *)applyViewArray
{
    if (_applyViewArray == nil) {
        _applyViewArray = [NSMutableArray array];
    }
    return _applyViewArray;
}

- (NSMutableArray *)arrangeDateArray
{
    if (_arrangeDateArray == nil) {
        _arrangeDateArray = [NSMutableArray array];
    }
    return _arrangeDateArray;
}

- (NSMutableArray *)nonArrangeDateArray
{
    if (_nonArrangeDateArray == nil) {
        _nonArrangeDateArray = [NSMutableArray array];
    }
    return _nonArrangeDateArray;
}

- (StuHomeLocalJob *)oneJob
{
    if (_oneJob == nil) {
        _oneJob = [[StuHomeLocalJob alloc]init];
    }
    return _oneJob;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    //self.view.backgroundColor = [UIColor grayColor];
    self.jobDetailscrollView.contentSize = CGSizeMake(screenFrame.size.width, screenFrame.size.height+500);
    self.jobDetailscrollView.frame = self.view.bounds;
    self.jobDetailscrollView.scrollEnabled = YES;
    self.jobDetailscrollView.bounces = YES;
    [self.view addSubview:self.jobDetailscrollView];
    self.jobDetailscrollView.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"兼职详情";
    
    [self setUpJobDetailHeadWith:self.oneJob];
    [self setJobDetailHeadFrame];
    [self jobDetailBtnClick:self.jobDetailBtn];
    
    self.companyInfoView.companyInfoJobsTableView.delegate = self;
    self.companyInfoView.companyInfoJobsTableView.dataSource = self;
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    self.companyInfoView.companyInfoJobsTableView.tableFooterView = view;
}

- (UIScrollView *)jobDetailscrollView
{
    if (_jobDetailscrollView == nil) {
        _jobDetailscrollView = [[UIScrollView alloc]init];
    }
    return _jobDetailscrollView;
}

- (UIView *)jobSaveView
{
    if (_jobSaveView == nil) {
        _jobSaveView = [[UIView alloc]init];
    }
    UIButton *saveBtn = [[UIButton alloc]init];
    [saveBtn setImage:[UIImage imageNamed:@"wx_29"] forState:UIControlStateNormal];
    [saveBtn setImage:[UIImage imageNamed:@"wx_28"] forState:UIControlStateSelected];
    
    if (globalSessionId !=nil && ![globalSessionId isEqual:@""]) {
        [saveBtn setSelected:[StuHomeLocalJob isSavedJobWithSessionId:globalSessionId JobId:self.oneJob.jobId]];
    }
    
    saveBtn.frame = CGRectMake(65, 20, 15, 25);
    [saveBtn addTarget:self action:@selector(saveBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *saveL = [[UILabel alloc]init];
    saveL.text = @"收藏";
    saveL.font = [UIFont systemFontOfSize:textFontSize];
    [saveL setTextColor:textColor];
    saveL.frame = CGRectMake(CGRectGetMaxX(saveBtn.frame)+3, 20, 50, 25);
    
    [_jobSaveView addSubview:saveBtn];
    [_jobSaveView addSubview:saveL];
    return _jobSaveView;
}

- (void)saveBtnClick:(UIButton*)btn
{
    if (globalSessionId !=nil && ![globalSessionId isEqual:@""]) {
        BOOL result = [StuHomeLocalJob saveJobWithSessionId:globalSessionId JobId:self.oneJob.jobId];
        [btn setSelected:result];
        if (btn.selected) {
            [MBProgressHUD showSuccess:@"收藏成功"];
        }
        else
        {
            [MBProgressHUD showSuccess:@"取消收藏"];
        }
    }
    else
    {
        [MBProgressHUD showError:@"请先登录再进行操作"];
    }
    
}

- (UIButton *)jobDetailBtn
{
    if (_jobDetailBtn == nil) {
        _jobDetailBtn = [[UIButton alloc]init];
    }
    
    [_jobDetailBtn setTitle:@"职位详情" forState:UIControlStateNormal];
    [_jobDetailBtn setBackgroundImage:[UIImage imageNamed:@"line002"] forState:UIControlStateSelected];
    [_jobDetailBtn setTitleColor:titleColor forState:UIControlStateSelected];
    [_jobDetailBtn setTitleColor:textColor forState:UIControlStateNormal];
    _jobDetailBtn.titleLabel.font = [UIFont systemFontOfSize:textFontSize];
    [_jobDetailBtn addTarget:self action:@selector(jobDetailBtnClick:) forControlEvents:UIControlEventTouchDown];
    return _jobDetailBtn;
}

- (void)jobDetailBtnClick:(UIButton*)btn
{
    [btn setSelected:YES ];
    self.companyInfoBtn.selected = !btn.selected;
    [self.jobDetailscrollView addSubview:self.jobDetaiView];
    [self.jobCompanyView removeFromSuperview];
    
    [self setUpJobDetailWithJob:self.oneJob];
    [self setAllFrames];
}

- (UIButton *)companyInfoBtn
{
    if (_companyInfoBtn == nil) {
        _companyInfoBtn = [[UIButton alloc]init];
    }
    
    [_companyInfoBtn setTitle:@"职位详情" forState:UIControlStateNormal];
    [_companyInfoBtn setBackgroundImage:[UIImage imageNamed:@"line002"] forState:UIControlStateSelected];
    [_companyInfoBtn setTitleColor:titleColor forState:UIControlStateSelected];
    [_companyInfoBtn setTitleColor:textColor forState:UIControlStateNormal];
    [_companyInfoBtn addTarget:self action:@selector(companyInfoBtnClick:) forControlEvents:UIControlEventTouchDown];
    _companyInfoBtn.titleLabel.font = [UIFont systemFontOfSize:textFontSize];
    
    return _companyInfoBtn;
}

- (void)companyInfoBtnClick:(UIButton*)btn
{
    [btn setSelected: YES ];
    self.jobDetailBtn.selected = !btn.selected;
    [self.jobDetailscrollView addSubview:self.jobCompanyView];
    [self.jobDetaiView removeFromSuperview];
    
    self.jobCompanyView.frame = CGRectMake(0, CGRectGetMaxY(self.companyInfoBtn.frame), screenFrame.size.width, CGRectGetMaxY(self.jobDetailscrollView.frame));
    
    [self setUpCompanyContentWithCompanyId:self.oneJob.companyId];
}

- (UIView *)lineView1
{
    if (_lineView1 == nil) {
        _lineView1 = [[UIView alloc]init];
    }
    _lineView1.backgroundColor = grayLineColor;
    return _lineView1;
}

- (UILabel *)adviseL
{
    if (_adviseL == nil) {
        _adviseL = [[UILabel alloc]init];
    }
    [_adviseL setTextColor:orangeColor];
    _adviseL.font = [UIFont systemFontOfSize:titleFontSize-1];
    _adviseL.textAlignment = NSTextAlignmentCenter;
    
    return _adviseL;
}

- (UIImageView *)jobDescImg
{
    if (_jobDescImg == nil) {
        _jobDescImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"wx_32"]];
    }
    return _jobDescImg;
}

- (UILabel *)jobDescL
{
    if (_jobDescL == nil) {
        _jobDescL = [[UILabel alloc]init];
    }
    _jobDescL.text = @"职位描述";
    _jobDescL.font = [UIFont systemFontOfSize:titleFontSize];
    [_jobDescL setTextColor:titleColor];
    return _jobDescL;
}

- (UILabel *)recruitNumL
{
    if (_recruitNumL == nil) {
        _recruitNumL = [[UILabel alloc]init];
    }
    _recruitNumL.font = [UIFont systemFontOfSize:textFontSize];
    [_recruitNumL setTextColor:textColor];
    return _recruitNumL;
}

- (UILabel *)salaryL
{
    if (_salaryL == nil) {
        _salaryL = [[UILabel alloc]init];
    }
    _salaryL.font = [UIFont systemFontOfSize:textFontSize];
    [_salaryL setTextColor:textColor];
    return _salaryL;
}

- (UILabel *)settlementPeriodL
{
    if (_settlementPeriodL == nil) {
        _settlementPeriodL = [[UILabel alloc]init];
    }
    _settlementPeriodL.font = [UIFont systemFontOfSize:textFontSize];
    [_settlementPeriodL setTextColor:textColor];
    return _settlementPeriodL;
}

- (UILabel *)isProvideStayL
{
    if (_isProvideStayL == nil) {
        _isProvideStayL = [[UILabel alloc]init];
    }
    _isProvideStayL.font = [UIFont systemFontOfSize:textFontSize];
    [_isProvideStayL setTextColor:textColor];
    return _isProvideStayL;
}

- (UILabel *)isProvideMealL
{
    if (_isProvideMealL == nil) {
        _isProvideMealL = [[UILabel alloc]init];
    }
    _isProvideMealL.font = [UIFont systemFontOfSize:textFontSize];
    [_isProvideMealL setTextColor:textColor];
    return _isProvideMealL;
}

- (UILabel *)workDateL
{
    if (_workDateL == nil) {
        _workDateL = [[UILabel alloc]init];
    }
    _workDateL.font = [UIFont systemFontOfSize:textFontSize];
    [_workDateL setTextColor:textColor];
    return _workDateL;
}

- (UILabel *)workHourL
{
    if (_workHourL == nil) {
        _workHourL = [[UILabel alloc]init];
    }
    _workHourL.font = [UIFont systemFontOfSize:textFontSize];
    [_workHourL setTextColor:textColor];
    return _workHourL;
}

- (UILabel *)workAddrL
{
    if (_workAddrL == nil) {
        _workAddrL = [[UILabel alloc]init];
    }
    _workAddrL.font = [UIFont systemFontOfSize:textFontSize];
    [_workAddrL setTextColor:textColor];
    _workAddrL.numberOfLines = 0;
    _workAddrL.adjustsFontSizeToFitWidth = YES;
    return _workAddrL;
}

- (UILabel *)workContentL
{
    if (_workContentL == nil) {
        _workContentL = [[UILabel alloc]init];
    }
    _workContentL.font = [UIFont systemFontOfSize:textFontSize];
    [_workContentL setTextColor:textColor];
    _workContentL.numberOfLines = 0;
    _workContentL.adjustsFontSizeToFitWidth = YES;
    return _workContentL;
}

- (UIView *)lineView2
{
    if (_lineView2 == nil) {
        _lineView2 = [[UIView alloc]init];
    }
    _lineView2.backgroundColor = grayLineColor;
    return _lineView2;
}

- (UIImageView *)jobRequreImg
{
    if (_jobRequreImg == nil) {
        _jobRequreImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"wx_32"]];
    }
    return _jobRequreImg;
}

- (UILabel *)jobRequreL
{
    if (_jobRequreL == nil) {
        _jobRequreL = [[UILabel alloc]init];
    }
    _jobRequreL.text = @"职位要求";
    _jobRequreL.font = [UIFont systemFontOfSize:titleFontSize];
    [_jobRequreL setTextColor:titleColor];
    return _jobRequreL;
}

- (UILabel *)genderLimitL
{
    if (_genderLimitL == nil) {
        _genderLimitL = [[UILabel alloc]init];
    }
    _genderLimitL.font = [UIFont systemFontOfSize:textFontSize];
    [_genderLimitL setTextColor:textColor];
    return _genderLimitL;
}

- (UILabel *)heightLimitL
{
    if (_heightLimitL == nil) {
        _heightLimitL = [[UILabel alloc]init];
    }
    _heightLimitL.font = [UIFont systemFontOfSize:textFontSize];
    [_heightLimitL setTextColor:textColor];
    return _heightLimitL;
}

- (UILabel *)specialLimit
{
    if (_specialLimit == nil) {
        _specialLimit = [[UILabel alloc]init];
    }
    _specialLimit.font = [UIFont systemFontOfSize:textFontSize];
    [_specialLimit setTextColor:textColor];
    _specialLimit.numberOfLines = 0;
    _specialLimit.adjustsFontSizeToFitWidth = YES;
    return _specialLimit;
}

- (UIView *)lineView3
{
    if (_lineView3 == nil) {
        _lineView3 = [[UIView alloc]init];
    }
    _lineView3.backgroundColor = grayLineColor;
    return _lineView3;
}

- (UIImageView *)arrangeImg
{
    if (_arrangeImg == nil) {
        _arrangeImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"wx_32"]];
    }
    return _arrangeImg;
}

- (UILabel *)arrangeL
{
    if (_arrangeL == nil) {
        _arrangeL = [[UILabel alloc]init];
    }
    _arrangeL.text = @"包办相关";
    _arrangeL.font = [UIFont systemFontOfSize:titleFontSize];
    [_arrangeL setTextColor:titleColor];
    return _arrangeL;
}

- (UILabel *)arrangeInstruL
{
    if (_arrangeInstruL == nil) {
        _arrangeInstruL = [[UILabel alloc]init];
    }
    _arrangeInstruL.text = @"包办说明：";
    _arrangeInstruL.font = [UIFont systemFontOfSize:textFontSize];
    [_arrangeInstruL setTextColor:textColor];
    _arrangeInstruL.numberOfLines = 0;
    _arrangeInstruL.adjustsFontSizeToFitWidth = YES;
    return _arrangeInstruL;
}

- (UILabel *)arrangeInstruL1
{
    if (_arrangeInstruL1 == nil) {
        _arrangeInstruL1 = [[UILabel alloc]init];
    }
    _arrangeInstruL1.text = @"1、包办人-队长 被包办人-队员";
    _arrangeInstruL1.font = [UIFont systemFontOfSize:textFontSize];
    [_arrangeInstruL1 setTextColor:textColor];
    _arrangeInstruL1.numberOfLines = 0;
    _arrangeInstruL1.adjustsFontSizeToFitWidth = YES;
    return _arrangeInstruL1;
}

- (UILabel *)arrangeInstruL2
{
    if (_arrangeInstruL2 == nil) {
        _arrangeInstruL2 = [[UILabel alloc]init];
    }
    _arrangeInstruL2.text = @"2、队长需要根据自己的能力选择相应的天数和日期";
    _arrangeInstruL2.font = [UIFont systemFontOfSize:textFontSize];
    [_arrangeInstruL2 setTextColor:textColor];
    _arrangeInstruL2.numberOfLines = 0;
    _arrangeInstruL2.adjustsFontSizeToFitWidth = YES;
    return _arrangeInstruL2;
}

- (UILabel *)arrangeInstruL3
{
    if (_arrangeInstruL3 == nil) {
        _arrangeInstruL3 = [[UILabel alloc]init];
    }
    _arrangeInstruL3.text = @"3、每个包办的兼职选定后会给队长2个小时完成包办任务，规定时间内不能完成视为包办失败。需要队长自己点击录用，队长可参与也可不参与兼职工作。";
    _arrangeInstruL3.font = [UIFont systemFontOfSize:textFontSize];
    [_arrangeInstruL3 setTextColor:textColor];
    _arrangeInstruL3.numberOfLines = 0;
    _arrangeInstruL3.adjustsFontSizeToFitWidth = YES;
    return _arrangeInstruL3;
}

- (UILabel *)arrangeInstruL4
{
    if (_arrangeInstruL4 == nil) {
        _arrangeInstruL4 = [[UILabel alloc]init];
    }
    _arrangeInstruL4.text = @"4、所有队员必须在平台上完成报名，队员需要输入验证码才能进入包办兼职报名。";
    _arrangeInstruL4.font = [UIFont systemFontOfSize:textFontSize];
    [_arrangeInstruL4 setTextColor:textColor];
    _arrangeInstruL4.numberOfLines = 0;
    _arrangeInstruL4.adjustsFontSizeToFitWidth = YES;
    return _arrangeInstruL4;
}

- (UILabel *)arrangeInstruL5
{
    if (_arrangeInstruL5 == nil) {
        _arrangeInstruL5 = [[UILabel alloc]init];
    }
    _arrangeInstruL5.text = @"5、队长要协调企业与学生之间的工作，在工作完成后由队长先行给队员结算。后平台会统一支付给队长。";
    _arrangeInstruL5.font = [UIFont systemFontOfSize:textFontSize];
    [_arrangeInstruL5 setTextColor:textColor];
    _arrangeInstruL5.numberOfLines = 0;
    _arrangeInstruL5.adjustsFontSizeToFitWidth = YES;
    return _arrangeInstruL5;
}

- (UILabel *)arrangeInstruL6
{
    if (_arrangeInstruL6 == nil) {
        _arrangeInstruL6 = [[UILabel alloc]init];
    }
    _arrangeInstruL6.text = @"6、包办奖励，每个队长会根据商家选定的奖励金额给予包办奖励（5、8、10元/人）。";
    _arrangeInstruL6.font = [UIFont systemFontOfSize:textFontSize];
    [_arrangeInstruL6 setTextColor:textColor];
    _arrangeInstruL6.numberOfLines = 0;
    _arrangeInstruL6.adjustsFontSizeToFitWidth = YES;
    return _arrangeInstruL6;
}

- (UILabel *)arrangeInstruL7
{
    if (_arrangeInstruL7 == nil) {
        _arrangeInstruL7 = [[UILabel alloc]init];
    }
    _arrangeInstruL7.text = @"同学们有没有很心动也想包办，那就时刻关注我们课余时间吧！";
    _arrangeInstruL7.font = [UIFont systemFontOfSize:textFontSize];
    [_arrangeInstruL7 setTextColor:textColor];
    _arrangeInstruL7.numberOfLines = 0;
    _arrangeInstruL7.adjustsFontSizeToFitWidth = YES;
    return _arrangeInstruL7;
}

- (UIView *)lineView4
{
    if (_lineView4 == nil) {
        _lineView4 = [[UIView alloc]init];
    }
    _lineView4.backgroundColor = grayLineColor;
    return _lineView4;
}

- (UIImageView *)attentionImg
{
    if (_attentionImg == nil) {
        _attentionImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"wx_32"]];
    }
    return _attentionImg;
}

- (UILabel *)attentionL
{
    if (_attentionL == nil) {
        _attentionL = [[UILabel alloc]init];
    }
    _attentionL.font = [UIFont systemFontOfSize:titleFontSize];
    _attentionL.text = @"注意事项";
    [_attentionL setTextColor:orangeColor];
    return _attentionL;
}

- (UIButton *)applyBtn
{
    if (_applyBtn == nil) {
        _applyBtn = [[UIButton alloc]init];
    }
    [_applyBtn setTitle:@"我要申请" forState:UIControlStateNormal];
    [_applyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _applyBtn.titleLabel.font = [UIFont systemFontOfSize:titleFontSize];
    [_applyBtn setBackgroundColor:orangeColor];
    [_applyBtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
    return _applyBtn;
}

- (UILabel *)attentionContentL1
{
    if (_attentionContentL1 == nil) {
        _attentionContentL1 = [[UILabel alloc]init];
    }
    [_attentionContentL1 setTextColor:textColor];
    _attentionContentL1.font = [UIFont systemFontOfSize:textFontSize];
    _attentionContentL1.text = @"1、报名前请完善自己的简历，方便商家了解自己。";
    _attentionContentL1.numberOfLines = 0;
    _attentionContentL1.adjustsFontSizeToFitWidth = YES;
    return _attentionContentL1;
}

- (UILabel *)attentionContentL2
{
    if (_attentionContentL2 == nil) {
        _attentionContentL2 = [[UILabel alloc]init];
    }
    [_attentionContentL2 setTextColor:textColor];
    _attentionContentL2.font = [UIFont systemFontOfSize:textFontSize];
    _attentionContentL2.text = @"2、报名时根据自己的时间选择合适的岗位，不要随意乱报。";
    _attentionContentL2.numberOfLines = 0;
    _attentionContentL2.adjustsFontSizeToFitWidth = YES;
    return _attentionContentL2;
}

- (UILabel *)attentionContentL3
{
    if (_attentionContentL3 == nil) {
        _attentionContentL3 = [[UILabel alloc]init];
    }
    [_attentionContentL3 setTextColor:textColor];
    _attentionContentL3.font = [UIFont systemFontOfSize:textFontSize];
    _attentionContentL3.text = @"3、报名后商家会发送签约邀请，在你确认签约后，一定要按时上岗，以保证自己的信用记录。";
    _attentionContentL3.numberOfLines = 0;
    _attentionContentL3.adjustsFontSizeToFitWidth = YES;
    return _attentionContentL3;
}

- (UIButton *)arrangeWantBtn
{
    if (_arrangeWantBtn == nil) {
        _arrangeWantBtn = [[UIButton alloc]init];
    }
    
    [_arrangeWantBtn setTitle:@"我要包办" forState:UIControlStateNormal];
    [_arrangeWantBtn setBackgroundImage:[UIImage imageNamed:@"wode_qianbao6"] forState:UIControlStateNormal];
    [_arrangeWantBtn setBackgroundImage:[UIImage imageNamed:@"wode_qianbao3"] forState:UIControlStateSelected];
    [_arrangeWantBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _arrangeWantBtn.titleLabel.font = [UIFont systemFontOfSize:titleFontSize];
    [_arrangeWantBtn addTarget:self action:@selector(arrangeWantClick:) forControlEvents:UIControlEventTouchDown];
    return _arrangeWantBtn;
}

- (UIButton *)arrangeApplyBtn
{
    if (_arrangeApplyBtn == nil) {
        _arrangeApplyBtn = [[UIButton alloc]init];
    }
    
    [_arrangeApplyBtn setTitle:@"我要申请" forState:UIControlStateNormal];
    [_arrangeApplyBtn setBackgroundImage:[UIImage imageNamed:@"wode_qianbao6"] forState:UIControlStateNormal];
    [_arrangeApplyBtn setBackgroundImage:[UIImage imageNamed:@"wode_qianbao3"] forState:UIControlStateSelected];
    [_arrangeApplyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _arrangeApplyBtn.titleLabel.font = [UIFont systemFontOfSize:titleFontSize];
    [_arrangeApplyBtn addTarget:self action:@selector(arrangeApplyClick:) forControlEvents:UIControlEventTouchDown];
    return _arrangeApplyBtn;
}

- (UIView *)arrangeWantView
{
    if (_arrangeWantView == nil) {
        _arrangeWantView = [[UIView alloc]init];
    }
    return _arrangeWantView;
}

- (UIView *)arrangeApplyView
{
    if (_arrangeApplyView == nil) {
        _arrangeApplyView = [[UIView alloc]init];
    }
    return _arrangeApplyView;
}

- (UIView *)jobDetaiView
{
    if (_jobDetaiView == nil) {
        _jobDetaiView = [[UIView alloc]init];
    }
    return _jobDetaiView;
}

- (UIView *)jobCompanyView
{
    if (_jobCompanyView == nil) {
        _jobCompanyView = [[UIView alloc]init];
    }
    return _jobCompanyView;
}

- (StuCompanInfo *)companyInfoView
{
    if (_companyInfoView == nil) {
        _companyInfoView = [StuCompanInfo companyInfoWithNib];
    }
    return _companyInfoView;
}

- (void)setUpJobDetailHeadWith:(StuHomeLocalJob*)job
{
    //jobSaveBtn
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.jobSaveView];
    //jobDetailBtn
    [self.jobDetailscrollView addSubview:self.jobDetailBtn];
    //companyInfoBtn
    [self.jobDetailscrollView addSubview:self.companyInfoBtn];
    //lineView1
    [self.jobDetailscrollView addSubview:self.lineView1];
}

- (void)setJobDetailHeadFrame
{
    //saveBtn
    self.jobSaveView.frame = CGRectMake(0, 0, 100, 50);
    
    self.jobDetailBtn.frame = CGRectMake(0, 0, screenFrame.size.width*0.5, 30);
    self.companyInfoBtn.frame = CGRectMake(CGRectGetMaxX(self.jobDetailBtn.frame), 0, screenFrame.size.width*0.5, 30);
    self.lineView1.frame = CGRectMake(0, CGRectGetMaxY(self.jobDetailBtn.frame)-2, screenFrame.size.width, 2);
}

- (void)setUpJobDetailWithJob:(StuHomeLocalJob*)job
{
    //adviseL
    self.adviseL.text = [NSString stringWithFormat:@"【本职位包办奖励为每招一人奖励%d元】", job.arrangedReward];
    
    [self.jobDetaiView addSubview:self.adviseL];
    //jobDescImg
    [self.jobDetaiView addSubview:self.jobDescImg];
    //jobDescL
    [self.jobDetaiView addSubview:self.jobDescL];
    //recruitNumL
    self.recruitNumL.text = [NSString stringWithFormat:@"招聘人数：%d人", job.recruitNum];
    [self.jobDetaiView addSubview:self.recruitNumL];
    //salaryL
    self.salaryL.text = [NSString stringWithFormat:@"薪资待遇：%d %@", job.salary, job.unit];
    [self.jobDetaiView addSubview:self.salaryL];
    //settlementPeriodL
    if ([job.settlementPeriod isEqualToString:@"day"])
    {
        self.settlementPeriodL.text = [NSString stringWithFormat:@"结算周期：日结"];
    }
    if ([job.settlementPeriod isEqualToString:@"week"])
    {
        self.settlementPeriodL.text = [NSString stringWithFormat:@"结算周期：周结"];
    }
    if ([job.settlementPeriod isEqualToString:@"end"])
    {
        self.settlementPeriodL.text = [NSString stringWithFormat:@"结算周期：完结"];
    }
    if ([job.settlementPeriod isEqualToString:@"month"])
    {
        self.settlementPeriodL.text = [NSString stringWithFormat:@"结算周期：月结"];
    }
    [self.jobDetaiView addSubview:self.settlementPeriodL];
    //isProvideStayL
    if ([job.isProvideStay isEqualToString:@"1"]) {
        self.isProvideStayL.text = @"提供住宿：是";
    }
    else
    {
        self.isProvideStayL.text = @"提供住宿：否";
    }
    [self.jobDetaiView addSubview:self.isProvideStayL];
    //isProvideMealL
    if ([job.isProvideMeal isEqualToString:@"1"]) {
        self.isProvideMealL.text = @"提供住宿：是";
    }
    else
    {
        self.isProvideMealL.text = @"提供住宿：否";
    }
    [self.jobDetaiView addSubview:self.isProvideMealL];
    //workDateL
    self.workDateL.text = [NSString stringWithFormat:@"工作日期：%@至%@", job.workingStartDate, job.workingEndDate];
    [self.jobDetaiView addSubview:self.workDateL];
    //workHourL
    self.workHourL.text = [NSString stringWithFormat:@"工作时间：%@", job.workingHours];
    [self.jobDetaiView addSubview:self.workHourL];
    //workAddrL
    self.workAddrL.text = [NSString stringWithFormat:@"工作地址：%@", job.jobAddress];
    [self.jobDetaiView addSubview:self.workAddrL];
    //workContentL
    self.workContentL.text = [NSString stringWithFormat:@"工作内容：%@", job.workContent];
    [self.jobDetaiView addSubview:self.workContentL];
    
    //lineView2
    [self.jobDetaiView addSubview:self.lineView2];
    
    
    //jobRequreImg
    [self.jobDetaiView addSubview:self.jobRequreImg];
    //jobRequreL
    [self.jobDetaiView addSubview:self.jobRequreL];
    //genderLimitL
    self.genderLimitL.text = [NSString stringWithFormat:@"性别要求：%@", job.genderLimit];
    [self.jobDetaiView addSubview:self.genderLimitL];
    //heightLimitL
    self.heightLimitL.text = [NSString stringWithFormat:@"身高要求：%@", job.heightLimit];
    [self.jobDetaiView addSubview:self.heightLimitL];
    //specialLimit
    self.specialLimit.text = [NSString stringWithFormat:@"特殊要求：%@", job.specialRequired];
    [self.jobDetaiView addSubview:self.specialLimit];
    
    //lineView3
    [self.jobDetaiView addSubview:self.lineView3];
    
    //attention
    [self.jobDetaiView addSubview:self.attentionImg];
    [self.jobDetaiView addSubview:self.attentionL];
    [self.jobDetaiView addSubview:self.attentionContentL1];
    [self.jobDetaiView addSubview:self.attentionContentL2];
    [self.jobDetaiView addSubview:self.attentionContentL3];
    
    if (job.isAgent!=nil && [job.isAgent isEqualToString:@"1"])
    {
        [self.jobDetaiView addSubview:self.specialLimit];
        //arrangeImg
        [self.jobDetaiView addSubview:self.arrangeImg];
        //arrangeL
        [self.jobDetaiView addSubview:self.arrangeL];
        
        //lineView4
        [self.jobDetaiView addSubview:self.lineView4];
        
        [self.jobDetaiView addSubview:self.arrangeInstruL];
        [self.jobDetaiView addSubview:self.arrangeInstruL1];
        [self.jobDetaiView addSubview:self.arrangeInstruL2];
        [self.jobDetaiView addSubview:self.arrangeInstruL3];
        [self.jobDetaiView addSubview:self.arrangeInstruL4];
        [self.jobDetaiView addSubview:self.arrangeInstruL5];
        [self.jobDetaiView addSubview:self.arrangeInstruL6];
        [self.jobDetaiView addSubview:self.arrangeInstruL7];
        
        [self.jobDetaiView addSubview:self.arrangeWantBtn];
        [self.jobDetaiView addSubview:self.arrangeApplyBtn];
    }
    
}

- (void)setAllFrames
{
    if (self.oneJob.isAgent == nil || ![self.oneJob.isAgent isEqualToString:@"1"]) {
        self.jobDescImg.frame = CGRectMake(paddingW, CGRectGetMaxY(self.jobDetailBtn.frame)+paddingH, titleImgWH, titleImgWH);
        self.jobDescL.frame = CGRectMake(CGRectGetMaxX(self.jobDescImg.frame)+imgTitlePadding, CGRectGetMaxY(self.jobDetailBtn.frame)+paddingH, screenFrame.size.width-CGRectGetMaxX(self.jobDescImg.frame), titleImgWH);
    }
    else
    {
        self.adviseL.frame = CGRectMake(0, CGRectGetMaxY(self.jobDetailBtn.frame)+paddingH, screenFrame.size.width, 25);
        [self.jobDetaiView addSubview:self.adviseL];
        self.jobDescImg.frame = CGRectMake(paddingW, CGRectGetMaxY(self.adviseL.frame)+paddingH, titleImgWH, titleImgWH);
        self.jobDescL.frame = CGRectMake(CGRectGetMaxX(self.jobDescImg.frame)+imgTitlePadding, CGRectGetMaxY(self.adviseL.frame)+paddingH, screenFrame.size.width-CGRectGetMaxX(self.jobDescImg.frame), titleImgWH);
    }
    
    self.recruitNumL.frame = CGRectMake(paddingW, CGRectGetMaxY(self.jobDescImg.frame)+paddingH, labelContentW, titleImgWH);
    self.salaryL.frame = CGRectMake(paddingW, CGRectGetMaxY(self.recruitNumL.frame)+paddingH, labelContentW, titleImgWH);
    self.settlementPeriodL.frame = CGRectMake(paddingW, CGRectGetMaxY(self.salaryL.frame)+paddingH, labelContentW, titleImgWH);
    self.isProvideStayL.frame = CGRectMake(paddingW, CGRectGetMaxY(self.settlementPeriodL.frame)+paddingH, labelContentW, titleImgWH);
    self.isProvideMealL.frame = CGRectMake(paddingW, CGRectGetMaxY(self.isProvideStayL.frame)+paddingH, labelContentW, titleImgWH);
    self.workDateL.frame = CGRectMake(paddingW, CGRectGetMaxY(self.isProvideMealL.frame)+paddingH, labelContentW, titleImgWH);
    self.workHourL.frame = CGRectMake(paddingW, CGRectGetMaxY(self.workDateL.frame)+paddingH, labelContentW, titleImgWH);
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"NSFontAttributeName"] = [UIFont systemFontOfSize:textFontSize];
    CGFloat workAddrH = [self.workAddrL.text boundingRectWithSize:CGSizeMake(labelContentW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size.height;
    self.workAddrL.frame = CGRectMake(paddingW, CGRectGetMaxY(self.workHourL.frame)+paddingH, labelContentW, workAddrH);
    
    [dict removeAllObjects];
    dict[@"NSFontAttributeName"] = [UIFont systemFontOfSize:textFontSize];
    CGFloat workContentH = [self.workContentL.text boundingRectWithSize:CGSizeMake(labelContentW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size.height;
    self.workContentL.frame = CGRectMake(paddingW, CGRectGetMaxY(self.workAddrL.frame)+paddingH, labelContentW, workContentH);
    
    self.lineView2.frame = CGRectMake(paddingW, CGRectGetMaxY(self.workContentL.frame)+paddingH, screenFrame.size.width-paddingW*2, 1);
    
    self.jobRequreImg.frame = CGRectMake(paddingW, CGRectGetMaxY(self.lineView2.frame)+paddingH, titleImgWH, titleImgWH);
    self.jobRequreL.frame = CGRectMake(CGRectGetMaxX(self.jobRequreImg.frame)+imgTitlePadding, CGRectGetMaxY(self.lineView2.frame)+paddingH, screenFrame.size.width-CGRectGetMaxX(self.jobRequreImg.frame), titleImgWH);
    self.genderLimitL.frame = CGRectMake(paddingW, CGRectGetMaxY(self.jobRequreImg.frame)+paddingH, labelContentW, titleImgWH);
    self.heightLimitL.frame = CGRectMake(paddingW, CGRectGetMaxY(self.genderLimitL.frame)+paddingH, labelContentW, titleImgWH);
    
    [dict removeAllObjects];
    dict[@"NSFontAttributeName"] = [UIFont systemFontOfSize:textFontSize];
    CGFloat specialLimitH = [self.specialLimit.text boundingRectWithSize:CGSizeMake(labelContentW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size.height;
    self.specialLimit.frame = CGRectMake(paddingW, CGRectGetMaxY(self.heightLimitL.frame)+paddingH, labelContentW, specialLimitH);
    
    self.lineView3.frame = CGRectMake(paddingW, CGRectGetMaxY(self.specialLimit.frame)+paddingH, labelContentW, 1);
    
    if (self.oneJob.isAgent == nil || ![self.oneJob.isAgent isEqualToString:@"1"])
    {
        self.attentionImg.frame = CGRectMake(paddingW, CGRectGetMaxY(self.lineView3.frame)+paddingH, titleImgWH, titleImgWH);
        self.attentionL.frame = CGRectMake(CGRectGetMaxX(self.attentionImg.frame) +imgTitlePadding, CGRectGetMaxY(self.lineView3.frame)+paddingH, screenFrame.size.width-CGRectGetMaxX(self.attentionImg.frame), titleImgWH);
        
        [dict removeAllObjects];
        dict[@"NSFontAttributeName"] = [UIFont systemFontOfSize:textFontSize];
        
        CGFloat attentionContentL1H = [self.attentionContentL1.text boundingRectWithSize:CGSizeMake(labelContentW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size.height;
        self.attentionContentL1.frame = CGRectMake(paddingW, CGRectGetMaxY(self.attentionImg.frame)+paddingH, labelContentW, attentionContentL1H);
        
        CGFloat attentionContentL2H = [self.attentionContentL2.text boundingRectWithSize:CGSizeMake(labelContentW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size.height;
        self.attentionContentL2.frame = CGRectMake(paddingW, CGRectGetMaxY(self.attentionContentL1.frame)+paddingH, labelContentW, attentionContentL2H);
        
        CGFloat attentionContentL3H = [self.attentionContentL3.text boundingRectWithSize:CGSizeMake(labelContentW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size.height;
        self.attentionContentL3.frame = CGRectMake(paddingW, CGRectGetMaxY(self.attentionContentL2.frame)+paddingH, labelContentW, attentionContentL3H);
        
        NSArray *dateArray = self.oneJob.jobDates;
        CGFloat lastBtnY = CGRectGetMaxY(self.attentionContentL3.frame)+20;
        int btnIndex = 0;
        int btnTag = 0;
        int recruitsIndex = 0;
        for (StuJobDateObj *jobDate in dateArray) {
            NSString *jobDateDateTmp = jobDate.jobDate;
            NSString *jobDateDate = [[jobDateDateTmp componentsSeparatedByString:@"年"]lastObject];
            
            StuArrangeDateBtn *btn = [StuArrangeDateBtn buttonWithNib];
            btnTag++;
            [btn.arrangeViewBtn setTag:btnTag];
            [btn.arrangeViewBtn setTitle:jobDateDate forState:UIControlStateNormal];
            
            if (btnIndex%2 == 0) {
                btn.frame = CGRectMake(selectJobDateBtnPadding, lastBtnY+paddingH+selectJobDateBtnH, selectJobDateBtnW, selectJobDateBtnH);
                
                lastBtnY = btn.frame.origin.y;
            }
            else
            {
                btn.frame = CGRectMake(selectJobDateBtnPadding*2+selectJobDateBtnW, lastBtnY, selectJobDateBtnW, selectJobDateBtnH);
            }
            [btn.arrangeViewBtn addTarget:self action:@selector(nonArrangeJobDateClick:) forControlEvents:UIControlEventTouchDown];
            
            if ([self.oneJob.recruits[recruitsIndex]intValue] > self.oneJob.recruitNum*1.2) {
                [btn.arrangeViewImg setImage:[UIImage imageNamed:@"man"]];
                btn.userInteractionEnabled = NO;
            }
            
            for (NSString *str in self.oneJob.signUpsArry) {
                if ([jobDate.jobDateId isEqualToString:str]) {
                    [btn.arrangeViewImg setImage:[UIImage imageNamed:@"sheng"]];
                    btn.userInteractionEnabled = NO;
                }
            }
            //[self.arrangeWantView addSubview:btn];
            recruitsIndex++;
            btnIndex++;
            [self.jobDetaiView addSubview:btn];
            
            //            UIButton *btn = [[UIButton alloc]init];
            //            [btn setImage:[UIImage imageNamed:@"wx_29"] forState:UIControlStateNormal];
            //            [btn setImage:[UIImage imageNamed:@"wx_28"] forState:UIControlStateSelected];
            //
            //            [btn setTitle:jobDateDate forState:UIControlStateNormal];
            //            [btn setTitleColor:textColor forState:UIControlStateNormal];
            //            [btn.titleLabel setFont:[UIFont systemFontOfSize:textFontSize]];
            //            btnTag++;
            //            if (btnIndex%2 == 0) {
            //                btn.frame = CGRectMake(selectJobDateBtnPadding, lastBtnY+paddingH, selectJobDateBtnW, selectJobDateBtnH);
            //            }
            //            else
            //            {
            //                btn.frame = CGRectMake(selectJobDateBtnPadding*2+selectJobDateBtnW, lastBtnY+paddingH, selectJobDateBtnW, selectJobDateBtnH);
            //                lastBtnY = CGRectGetMaxY(btn.frame);
            //            }
            //            [btn setTag:btnTag];
            //            [btn addTarget:self action:@selector(jobDateClick:) forControlEvents:UIControlEventTouchDown];
            //            [self.jobDetaiView addSubview:btn];
            //            btnIndex++;
        }
        
        CGFloat applyBtnH = 30;
        CGFloat applyBtnW = 100;
        
        [self.applyBtn addTarget:self action:@selector(nonArrangeApplyBtnClick) forControlEvents:UIControlEventTouchUpInside];
        self.applyBtn.frame = CGRectMake((screenFrame.size.width-applyBtnW)*0.5, lastBtnY+50, applyBtnW, applyBtnH);
        self.applyBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.applyBtn.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:titleFontSize]];
        [self.jobDetaiView addSubview:self.applyBtn];
        self.jobDetailscrollView.contentSize = CGSizeMake(screenFrame.size.width, CGRectGetMaxY(self.applyBtn.frame)+50);
        self.jobDetaiView.frame = CGRectMake(0, self.lineView1.frame.origin.y, screenFrame.size.width, CGRectGetMaxY(self.applyBtn.frame)+50);
    }
    else
    {
        //arrangeInstrument
        self.arrangeImg.frame = CGRectMake(paddingW, CGRectGetMaxY(self.lineView3.frame)+paddingH, titleImgWH, titleImgWH);
        self.arrangeL.frame = CGRectMake(CGRectGetMaxX(self.arrangeImg.frame) +imgTitlePadding, CGRectGetMaxY(self.lineView3.frame)+paddingH, screenFrame.size.width-CGRectGetMaxX(self.arrangeImg.frame), titleImgWH);
        
        self.arrangeInstruL.frame = CGRectMake(paddingW, CGRectGetMaxY(self.arrangeImg.frame)+paddingH, 50, titleImgWH);
        CGFloat arrangeInstruX = CGRectGetMaxX(self.arrangeInstruL.frame);
        CGFloat arrangeInstruW = screenFrame.size.width-paddingW-arrangeInstruX;
        
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[@"NSFontAttributeName"] = [UIFont systemFontOfSize:textFontSize];
        
        CGFloat arrangeInstruH = [self.arrangeInstruL1.text boundingRectWithSize:CGSizeMake(arrangeInstruW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size.height;
        self.arrangeInstruL1.frame = CGRectMake(arrangeInstruX, CGRectGetMaxY(self.arrangeL.frame)+paddingH, arrangeInstruW, arrangeInstruH);
        
        arrangeInstruH = [self.arrangeInstruL2.text boundingRectWithSize:CGSizeMake(arrangeInstruW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size.height;
        self.arrangeInstruL2.frame = CGRectMake(arrangeInstruX, CGRectGetMaxY(self.arrangeInstruL1.frame)+paddingH, arrangeInstruW, arrangeInstruH);
        
        arrangeInstruH = [self.arrangeInstruL3.text boundingRectWithSize:CGSizeMake(arrangeInstruW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size.height;
        self.arrangeInstruL3.frame = CGRectMake(arrangeInstruX, CGRectGetMaxY(self.arrangeInstruL2.frame)+paddingH, arrangeInstruW, arrangeInstruH);
        
        arrangeInstruH = [self.arrangeInstruL4.text boundingRectWithSize:CGSizeMake(arrangeInstruW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size.height;
        self.arrangeInstruL4.frame = CGRectMake(arrangeInstruX, CGRectGetMaxY(self.arrangeInstruL3.frame)+paddingH, arrangeInstruW, arrangeInstruH);
        
        arrangeInstruH = [self.arrangeInstruL5.text boundingRectWithSize:CGSizeMake(arrangeInstruW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size.height;
        self.arrangeInstruL5.frame = CGRectMake(arrangeInstruX, CGRectGetMaxY(self.arrangeInstruL4.frame)+paddingH, arrangeInstruW, arrangeInstruH);
        
        arrangeInstruH = [self.arrangeInstruL6.text boundingRectWithSize:CGSizeMake(arrangeInstruW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size.height;
        self.arrangeInstruL6.frame = CGRectMake(arrangeInstruX, CGRectGetMaxY(self.arrangeInstruL5.frame)+paddingH, arrangeInstruW, arrangeInstruH);
        
        arrangeInstruH = [self.arrangeInstruL7.text boundingRectWithSize:CGSizeMake(arrangeInstruW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size.height;
        self.arrangeInstruL7.frame = CGRectMake(arrangeInstruX, CGRectGetMaxY(self.arrangeInstruL6.frame)+paddingH, arrangeInstruW, arrangeInstruH);
        
        //lineView4
        self.lineView4.frame = CGRectMake(paddingW, CGRectGetMaxY(self.arrangeInstruL7.frame)+paddingH, labelContentW, 1);
        
        //attention
        self.attentionImg.frame = CGRectMake(paddingW, CGRectGetMaxY(self.lineView4.frame)+paddingH, titleImgWH, titleImgWH);
        self.attentionL.frame = CGRectMake(CGRectGetMaxX(self.attentionImg.frame) +imgTitlePadding, CGRectGetMaxY(self.lineView4.frame)+paddingH, screenFrame.size.width-CGRectGetMaxX(self.attentionImg.frame), titleImgWH);
        
        CGFloat attentionContentL1H = [self.attentionContentL1.text boundingRectWithSize:CGSizeMake(labelContentW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size.height;
        self.attentionContentL1.frame = CGRectMake(paddingW, CGRectGetMaxY(self.attentionImg.frame)+paddingH, labelContentW, attentionContentL1H);
        
        CGFloat attentionContentL2H = [self.attentionContentL2.text boundingRectWithSize:CGSizeMake(labelContentW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size.height;
        self.attentionContentL2.frame = CGRectMake(paddingW, CGRectGetMaxY(self.attentionContentL1.frame)+paddingH, labelContentW, attentionContentL2H);
        
        CGFloat attentionContentL3H = [self.attentionContentL3.text boundingRectWithSize:CGSizeMake(labelContentW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size.height;
        self.attentionContentL3.frame = CGRectMake(paddingW, CGRectGetMaxY(self.attentionContentL2.frame)+paddingH, labelContentW, attentionContentL3H);
        
        CGFloat arrangeBtnPadding = (screenFrame.size.width-selectJobDateBtnW*2)*0.5;
        self.arrangeWantBtn.frame = CGRectMake(arrangeBtnPadding, CGRectGetMaxY(self.attentionContentL3.frame)+paddingH, selectJobDateBtnW, selectJobDateBtnH*2);
        [self arrangeWantClick:self.arrangeWantBtn];
        
        self.arrangeApplyBtn.frame = CGRectMake(CGRectGetMaxX(self.arrangeWantBtn.frame), CGRectGetMaxY(self.attentionContentL3.frame)+paddingH, selectJobDateBtnW, selectJobDateBtnH*2);
    }
    
}

- (void)nonArrangeJobDateClick:(UIButton*)btn
{
    //NSLog(@"nonArrangeJobDateClick.tag=%ld", btn.tag);
    [btn setSelected:!btn.selected];
    if (btn.selected) {
        [self.nonArrangeDateArray addObject: [self.oneJob.jobDates objectAtIndex:(btn.tag-1)]];
    }
    else
    {
        [self.nonArrangeDateArray removeObject: [self.oneJob.jobDates objectAtIndex:(btn.tag-1)]];
    }
}

//非包办申请发送
- (void)nonArrangeApplyBtnClick
{
    //NSLog(@"nonArrangeApplyBtnClick");
    if ([globalComplete isEqualToString:@"0"]) {
        [MBProgressHUD showError:@"请先完善您的资料"];
        return;
    }
    
    NSMutableString *strM = [NSMutableString string];
    
    if (self.nonArrangeDateArray.count == 0) {
        [MBProgressHUD showError:@"请选择日期"];
        return;
    }
    else
    {
        //NSMutableArray *preDateIdArrayM = [NSMutableArray array];
        for (StuJobDateObj *jobDate in self.nonArrangeDateArray)
        {
            jobDate.jobName = self.oneJob.name;
        }
        [preDateIdArray addObjectsFromArray:self.nonArrangeDateArray];
        preAllSalary += self.oneJob.salary;
        
        //preDateIdArray = preDateIdArrayM;
        int i = 0;
        for (StuJobDateObj *jobDate in self.nonArrangeDateArray)
        {
            [strM appendString:jobDate.jobDateId];
            if (i != self.nonArrangeDateArray.count-1) {
                [strM appendString:@","];
            }
            i++;
        }
    }
    
    if (globalSessionId == nil || [globalSessionId isEqualToString:@""]) {
        [MBProgressHUD showError:@"请先登录"];
        return;
    }
    
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/weChat/signUp/saveSignUp", serverIp]];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:URL];//默认为get请求
    request.timeoutInterval=5.0;//设置请求超时为5秒
    request.HTTPMethod=@"POST";//设置请求方法
    
    //设置请求体
    NSString *param=[NSString stringWithFormat:@"memberId=%@&dateIds=%@",globalSessionId, strM];
    //把拼接后的字符串转换为data，设置请求体
    request.HTTPBody=[param dataUsingEncoding:NSUTF8StringEncoding];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *responseStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    if ([responseStr isEqualToString:@"\"success\"" ]) {
        [MBProgressHUD showSuccess:@"申请成功"];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        [MBProgressHUD showError:@"申请失败"];
    }
}

- (void)jobDateClick:(UIButton*)btn
{
    [btn setSelected:!btn.selected];
    if (btn.selected) {
        [self.arrangeDateArray addObject: [self.oneJob.jobDates objectAtIndex:(btn.tag-1)]];
    }
    else
    {
        [self.arrangeDateArray removeObject: [self.oneJob.jobDates objectAtIndex:(btn.tag-1)]];
    }
}

//我要包办
- (void)arrangeWantClick:(UIButton*)btn
{
    [btn setSelected:YES];
    [self.arrangeApplyBtn setSelected:!self.arrangeWantBtn.selected];
    [self.arrangeApplyView removeFromSuperview];
    
    NSArray *jobDateArray = self.oneJob.jobDates;
    CGFloat lastBtnY = 0;
    CGFloat arrangeWantBtnY = CGRectGetMaxY(self.arrangeWantBtn.frame);
    int btnIndex = 0;
    int btnTag = 0;
    
    for (StuJobDateObj *jobDate in jobDateArray) {
        NSString *jobDateDate = jobDate.jobDate;
        btnTag++;
        StuArrangeDateBtn *btn = [StuArrangeDateBtn buttonWithNib];
        [btn.arrangeViewBtn setTag:btnTag];
        
        
        //表示被包办,包括自己和别人
        if (jobDate.isArranged!=nil && ![jobDate.isArranged isEqual:[NSNull null]] && [jobDate.isArranged isEqualToString:@"1"]) {
            if (jobDate.isMyArranged!=nil && jobDate.isMyArranged.length!=0) {
                //别人包办的
                [btn.arrangeViewImg setImage:[UIImage imageNamed:@"bao2"]];
                [btn.arrangeViewBtn setSelected:YES];
                btn.userInteractionEnabled = NO;
            }
            else
            {
                //自己包办的
                [btn.arrangeViewImg setImage:[UIImage imageNamed:@"bao1"]];
                btn.userInteractionEnabled = NO;
            }
        }
        
        //表示被自己包办
        //        if (jobDate.isMyArranged!=nil && jobDate.isMyArranged.length!=0) {
        //            [btn.arrangeViewImg setImage:[UIImage imageNamed:@"bao2"]];
        //            [btn.arrangeViewBtn setSelected:YES];
        //            btn.userInteractionEnabled = NO;
        //        }
        
        [btn.arrangeViewBtn setTitle:jobDateDate forState:UIControlStateNormal];
        if (btnIndex%2 == 0) {
            btn.frame = CGRectMake(selectJobDateBtnPadding, lastBtnY+paddingH+selectJobDateBtnH, selectJobDateBtnW, selectJobDateBtnH);
            
            lastBtnY = btn.frame.origin.y;
        }
        else
        {
            btn.frame = CGRectMake(selectJobDateBtnPadding*2+selectJobDateBtnW, lastBtnY, selectJobDateBtnW, selectJobDateBtnH);
        }
        [btn.arrangeViewBtn addTarget:self action:@selector(jobDateClick:) forControlEvents:UIControlEventTouchDown];
        [self.arrangeWantView addSubview:btn];
        btnIndex++;
    }
    
    UIButton *arrangeWantBottomBtn = [[UIButton alloc]init];
    [arrangeWantBottomBtn setBackgroundColor:orangeColor];
    [arrangeWantBottomBtn setTintColor:[UIColor whiteColor]];
    [arrangeWantBottomBtn setTitle:@"我要包办" forState:UIControlStateNormal];
    [arrangeWantBottomBtn.titleLabel setFont:[UIFont systemFontOfSize:titleFontSize]];
    
    CGFloat arrangeWantBottomBtnPadding = (screenFrame.size.width-selectJobDateBtnW)*0.5;
    arrangeWantBottomBtn.frame = CGRectMake(arrangeWantBottomBtnPadding, lastBtnY+paddingH+selectJobDateBtnH, selectJobDateBtnW, selectJobDateBtnH*2);
    [arrangeWantBottomBtn addTarget:self action:@selector(arrangeWantBottomBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.arrangeWantView.frame = CGRectMake(0, arrangeWantBtnY, screenFrame.size.width, CGRectGetMaxY(arrangeWantBottomBtn.frame));
    [self.arrangeWantView addSubview:arrangeWantBottomBtn];
    
    [self.jobDetaiView addSubview:self.arrangeWantView];
    
    self.jobDetaiView.frame = CGRectMake(0, self.lineView1.frame.origin.y, screenFrame.size.width, CGRectGetMaxY(self.arrangeWantView.frame));
    
    self.jobDetailscrollView.contentSize = CGSizeMake(screenFrame.size.width, CGRectGetMaxY(self.arrangeWantView.frame)+50);
}

//包办请求发送
- (void)arrangeWantBottomBtnClick
{
    if ([globalComplete isEqualToString:@"0"]) {
        [MBProgressHUD showError:@"请先完善您的资料"];
        return;
    }
    
    NSMutableString *strM = [NSMutableString string];
    
    if (self.arrangeDateArray.count == 0) {
        [MBProgressHUD showError:@"请选择日期"];
        return;
    }
    else
    {
        int i = 0;
        for (StuJobDateObj *jobDate in self.arrangeDateArray)
        {
            [strM appendString:jobDate.jobDateId];
            if (i != self.arrangeDateArray.count-1) {
                [strM appendString:@","];
            }
            i++;
        }
    }
    
    if (globalSessionId == nil || [globalSessionId isEqualToString:@""]) {
        [MBProgressHUD showError:@"请先登录"];
        return;
    }
    
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/weChat/arrangedRecrod/saveRecord", serverIp]];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:URL];//默认为get请求
    request.timeoutInterval=5.0;//设置请求超时为5秒
    request.HTTPMethod=@"POST";//设置请求方法
    
    int randomX = 10;
    NSString *randCommand = [NSString stringWithFormat:@"%d%d%d%d%d%d", arc4random()%randomX, arc4random()%randomX, arc4random()%randomX, arc4random()%randomX, arc4random()%randomX, arc4random()%randomX];
    
    //设置请求体
    NSString *param=[NSString stringWithFormat:@"memberId=%@&jobId=%@&dateIds=%@&command=%@",globalSessionId, self.oneJob.jobId, strM, randCommand];
    //把拼接后的字符串转换为data，设置请求体
    request.HTTPBody=[param dataUsingEncoding:NSUTF8StringEncoding];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *responseStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    if ([responseStr isEqualToString:@"\"success\"" ]) {
        [MBProgressHUD showSuccess:@"包办成功"];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        [MBProgressHUD showError:@"包办失败"];
    }
}

//我要申请
- (void)arrangeApplyClick:(UIButton*)btn
{
    [btn setSelected:YES];
    [self.arrangeWantBtn setSelected:!self.arrangeApplyBtn.selected];
    [self.arrangeWantView removeFromSuperview];
    
    if (globalSessionId == nil || [globalSessionId isEqualToString:@""]) {
        return;
    }
    
    //    CGFloat lastBtnY = CGRectGetMaxY(self.arrangeWantBtn.frame);
    CGFloat lastApplyCommandViewY = 0;
    
    NSArray *recordArray = [StuArrangeRecords loadArrangeRecordsWithJobId:self.oneJob.jobId];
    
    int applyViewTag = 0;
    
    //**********清空所有的包办日期和包办日期id
    [self.arrangeAllDateIdArray removeAllObjects];
    [self.arrangeAllDateArry removeAllObjects];
    //多个包办人
    for (StuArrangeRecords *record in recordArray) {
        StuArrangeRecoredsDetail *arrangeRecordsDetail = [StuArrangeRecoredsDetail loadArrangeRecordsDetailWithSessionId:globalSessionId JobId:self.oneJob.jobId RecordId:record.recordId];
        if (arrangeRecordsDetail.command == nil || arrangeRecordsDetail.command.length == 0) {
            return;
        }
        [self.arrangeAllDateArry addObjectsFromArray:arrangeRecordsDetail.dateArray];
        [self.arrangeAllDateIdArray addObjectsFromArray:arrangeRecordsDetail.dateIdArray];
        
        [self.applyCommandArray addObject:arrangeRecordsDetail.command];
        [self.applyRelationIdArray addObject:record.recordId];
        
        StuArrangeApplyCommandView *applyView = [StuArrangeApplyCommandView applyCommandViewFromNib];
        applyView.contactPhoneL.text = [NSString stringWithFormat:@"有疑问请联系包办人：%@", record.mobile];
        [applyView.arrangeCommandBtn addTarget:self action:@selector(arrangeApplyBottomBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        applyViewTag++;
        applyView.arrangeCommandBtn.tag = applyViewTag;
        [self.applyViewArray addObject:applyView];
        
        int btnIndex = 0;
        CGFloat applyViewH = 0;
        CGFloat lastBtnY = paddingH;
        
        //每个包办人中包办的所有日期
        for (int i=0; i<arrangeRecordsDetail.recruitsArray.count; i++) {
            
            if (arrangeRecordsDetail.recruitsArray[i] != 0) {
                
                NSString *date = arrangeRecordsDetail.dateArray[i];
                applyViewH = (arrangeRecordsDetail.dateIdArray.count/2+arrangeRecordsDetail.dateIdArray.count%2)*25+150;
                
                
                
                StuArrangeDateBtn *btn = [StuArrangeDateBtn buttonWithNib];
                btn.userInteractionEnabled = YES;
                
                [btn.arrangeViewBtn setTitle:date forState:UIControlStateNormal];
                
                if (btnIndex%2 == 0) {
                    btn.frame = CGRectMake(selectJobDateBtnPadding-paddingW, lastBtnY+paddingH+selectJobDateBtnH, selectJobDateBtnW, selectJobDateBtnH);
                    
                    lastBtnY = btn.frame.origin.y;
                }
                else
                {
                    btn.frame = CGRectMake(selectJobDateBtnPadding*2+selectJobDateBtnW-paddingW, lastBtnY, selectJobDateBtnW, selectJobDateBtnH);
                }
                
                if ([arrangeRecordsDetail.recruitsArray[i] intValue] > arrangeRecordsDetail.recruitNum*1.2) {
                    btn.userInteractionEnabled = NO;
                    [btn.arrangeViewImg setImage:[UIImage imageNamed:@"man"]];
                }
                if (arrangeRecordsDetail.mySignArray!=nil && arrangeRecordsDetail.mySignArray.count>0 && [arrangeRecordsDetail.mySignArray[0] isEqualToString:@"1"]) {
                    btn.userInteractionEnabled = NO;
                    [btn.arrangeViewImg setImage:[UIImage imageNamed:@"sheng"]];
                }
                
                [btn.arrangeViewBtn addTarget:self action:@selector(arrangeBtnClick:) forControlEvents:UIControlEventTouchDown];
                [applyView addSubview:btn];
                btnIndex++;
            }
        }
        
        //CGFloat applyViewH = 30+(recordArray.count/2+recordArray.count%2)*30+130;
        applyView.frame = CGRectMake(paddingW, lastApplyCommandViewY+paddingH, screenFrame.size.width-2*paddingW, applyViewH);
        //        applyView.backgroundColor = [UIColor redColor];
        [self.arrangeApplyView addSubview:applyView];
        lastApplyCommandViewY = CGRectGetMaxY(applyView.frame);
        //lastBtnY = CGRectGetMaxY(applyView.frame);
    }
    
    self.arrangeApplyView.frame = CGRectMake(0, CGRectGetMaxY(self.arrangeWantBtn.frame), screenFrame.size.width, lastApplyCommandViewY);
    
    [self.jobDetaiView addSubview:self.arrangeApplyView];
    
    self.jobDetaiView.frame = CGRectMake(0, 0, screenFrame.size.width, CGRectGetMaxY(self.arrangeApplyView.frame)+50);
    self.jobDetailscrollView.contentSize = CGSizeMake(screenFrame.size.width, CGRectGetMaxY(self.arrangeApplyView.frame)+50);
    
}

//申请包办工作请求发送
- (void)arrangeApplyBottomBtnClick:(UIButton*)btn
{
    //NSLog(@"arrangeApplyBottomBtnClick.tag=%ld", btn.tag);
    if ([globalComplete isEqualToString:@"0"]) {
        [MBProgressHUD showError:@"请先完善您的资料"];
        return;
    }
    
    StuArrangeApplyCommandView *applyView = self.applyViewArray[btn.tag-1];
    
    if (self.applyCommandArray.count == 0 || ![self.applyCommandArray[btn.tag-1] isEqualToString:applyView.commandL.text]) {
        [MBProgressHUD showError:@"您输入的口令不正确"];
        applyView.commandL.text = @"";
        return;
    }
    
    NSMutableString *strM = [NSMutableString string];
    
    if (self.applyDateArray.count == 0) {
        [MBProgressHUD showError:@"请选择日期"];
        return;
    }
    else
    {
        NSMutableArray *arryM = [NSMutableArray array];
        for (int i=0; i<self.applyDateArray.count; i++) {
            NSString *str = self.applyDateArray[i];
            for (int j=0; j<self.arrangeAllDateArry.count; j++) {
                if ([str isEqualToString:self.arrangeAllDateArry[j]]) {
                    [arryM addObject:self.arrangeAllDateIdArray[j]];
                }
            }
        }
        
        int i = 0;
        for (NSString *str in arryM)
        {
            [strM appendString:str];
            if (i != self.applyDateArray.count-1) {
                [strM appendString:@","];
            }
            i++;
        }
    }
    if (globalSessionId == nil || [globalSessionId isEqualToString:@""]) {
        [MBProgressHUD showError:@"请先登录"];
        return;
    }
    
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/weChat/arrangedSignUp/saveSignUp", serverIp]];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:URL];//默认为get请求
    request.timeoutInterval=5.0;//设置请求超时为5秒
    request.HTTPMethod=@"POST";//设置请求方法
    
    //设置请求体
    //NSString *param=[NSString stringWithFormat:@"arrangedRelationIds=%@&memberId=%@&dateIds=%@",self.applyRelationIdArray[btn.tag-1], globalSessionId, strM];
    NSString *param=[NSString stringWithFormat:@"arrangedRelationIds=%@&memberId=%@",strM, globalSessionId];
    //把拼接后的字符串转换为data，设置请求体
    request.HTTPBody=[param dataUsingEncoding:NSUTF8StringEncoding];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *responseStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    if ([responseStr isEqualToString:@"\"success\"" ]) {
        [MBProgressHUD showSuccess:@"申请职位成功"];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        [MBProgressHUD showError:@"申请职位失败"];
    }
}

//申请包办中日期的选择
- (void)arrangeBtnClick:(UIButton*)btn
{
    //    [btn setSelected:!btn.selected];
    //    StuJobDateObj *jobDate = self.oneJob.jobDates[btn.tag-1];
    //    if (btn.selected) {
    //        [self.applyDateArray addObject:jobDate.jobDateId];
    //    }
    //    else
    //    {
    //        [self.applyDateArray removeObject:jobDate.jobDateId];
    //    }
    
    [btn setSelected:!btn.selected];
    if (btn.selected) {
        [self.applyDateArray addObject:btn.titleLabel.text];
    }
    else
    {
        [self.applyDateArray removeObject:btn.titleLabel.text];
    }
}

- (void)setUpCompanyContentWithCompanyId:(NSString*)companyId
{
    self.companyInfoModel = [StuCompanyInfoModel companyDetailCheckWithCompanyId:companyId];
    self.companyInfoView.frame = CGRectMake(0, CGRectGetMaxY(self.companyInfoBtn.frame), screenFrame.size.width, self.jobDetailscrollView.contentSize.height-95);
    [self.companyInfoView setUpCompanyInfoWithCompanyModel:self.companyInfoModel];
    
    self.companyInfoJobArry = [StuHomeLocalJob jobsFromNetArray:self.companyInfoModel.jobs];
    
    [self.jobCompanyView addSubview:self.companyInfoView];
}

#pragma companyInfoJobsTableView delegate&datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.companyInfoJobArry.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return cellH;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StuHomeJobTableViewCell *cell = [StuHomeJobTableViewCell cellNibWithTableView:tableView];
    StuHomeLocalJob *oneJob = self.companyInfoJobArry[indexPath.row];
    cell.jobTypeBtn.titleLabel.text = oneJob.jobType;
    cell.jobTitleL.text = oneJob.name;
    cell.jobAddrBtn.titleLabel.text = oneJob.parseArea;
    cell.jobSalaryL.text = [NSString stringWithFormat:@"%d%@", (int)oneJob.salary, oneJob.unit];
    
    NSArray * array = [oneJob.workingStartDate componentsSeparatedByString:@" "];
    cell.jobStartDateL.text = array[0];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    StuHomeLocalJob *oneJobDetail = [[StuHomeLocalJob alloc]init];
    if ([self.oneJob.isAgent isEqualToString:@"0"]) {
        oneJobDetail = [StuHomeLocalJob nonArrangeJobWithJobId:self.oneJob.jobId MemberId:globalSessionId];
    }
    else
    {
        oneJobDetail = [StuHomeLocalJob arrangeJobWithJobId:self.oneJob.jobId MemberId:globalSessionId];
    }
    
    StuJobDetailViewController *jobDetaiVc = [[StuJobDetailViewController alloc]init];
    jobDetaiVc.oneJob = oneJobDetail;
    [self.navigationController pushViewController:jobDetaiVc animated:YES];
}
@end
