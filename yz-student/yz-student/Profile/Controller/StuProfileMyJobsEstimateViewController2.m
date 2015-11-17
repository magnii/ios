//
//  StuProfileMyJobsEstimateViewController.m
//  yz-student
//
//  Created by 仲光磊 on 15/9/23.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import "StuProfileMyJobsEstimateViewController2.h"
#import "StuProfileMyJobsEstimateView.h"
#import "StuConfig.h"
#import "StuHomeLocalJob.h"
#import "StuProfileCommentInfo.h"
#import "MBProgressHUD+MJ.h"

extern NSString *globalSessionId;

@interface StuProfileMyJobsEstimateViewController2 ()<UITextViewDelegate>

@property(nonatomic, strong)StuProfileMyJobsEstimateView *estimateView;
@property(nonatomic, strong)UITextView *commentsTextView;
@property(nonatomic, strong)UILabel *label;
@property(nonatomic, strong)UIButton *commentsBtn;

@property(nonatomic, assign)unsigned long score1;
@property(nonatomic, assign)unsigned long score2;
@property(nonatomic, assign)unsigned long score3;
@property(nonatomic, assign)unsigned long score4;
@property(nonatomic, assign)unsigned long totalEs;
@property(nonatomic, copy)NSString *commentId;

@property(nonatomic, strong)NSArray *allBtns;

@end

@implementation StuProfileMyJobsEstimateViewController2

- (NSString *)commentId
{
    if (_commentId == nil) {
        _commentId = [NSString string];
    }
    return _commentId;
}

- (NSArray *)allBtns
{
    if (_allBtns == nil) {
        _allBtns = [NSArray arrayWithObjects:
                    self.estimateView.btn1,
                    self.estimateView.btn2,
                    self.estimateView.btn3,
                    self.estimateView.btn4,
                    self.estimateView.btn5,
                    self.estimateView.btn6,
                    self.estimateView.btn7,
                    self.estimateView.btn8,
                    self.estimateView.btn9,
                    self.estimateView.btn10,
                    self.estimateView.btn11,
                    self.estimateView.btn12,
                    self.estimateView.btn13,
                    self.estimateView.btn14,
                    self.estimateView.btn15,
                    self.estimateView.btn16,
                    self.estimateView.btn17,
                    self.estimateView.btn18,
                    self.estimateView.btn19,
                    self.estimateView.btn20,
                    self.estimateView.btn21,
                    self.estimateView.btn22,
                    self.estimateView.btn23,
                    self.estimateView.btn24,
                    self.estimateView.btn25, nil];
    }
    return _allBtns;
}

- (UITextView *)commentsTextView
{
    if (_commentsTextView == nil) {
        _commentsTextView = [[UITextView alloc]init];
    }
    return _commentsTextView;
}

- (UILabel *)label
{
    if (_label == nil) {
        _label = [[UILabel alloc]init];
    }
    return _label;
}

- (StuProfileMyJobsEstimateView *)estimateView
{
    if (_estimateView == nil) {
        _estimateView = [StuProfileMyJobsEstimateView viewFromNib];
    }
    return _estimateView;
}

- (UIButton *)commentsBtn
{
    if (_commentsBtn == nil) {
        _commentsBtn = [[UIButton alloc]init];
    }
    return _commentsBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.score1 = 0;
    self.score2 = 0;
    self.score3 = 0;
    self.score4 = 0;
    self.estimateView.totalEsitamate.userInteractionEnabled = NO;
    
    self.estimateView.frame = CGRectMake(0, 64, screenFrame.size.width, 200);
    [self.view addSubview:self.estimateView];
    [self addBtnsTarget];
    
    //textView
    self.commentsTextView.frame = CGRectMake(20, CGRectGetMaxY(self.estimateView.frame), screenFrame.size.width-40, 120);
    
    [self.commentsTextView.layer setBorderColor:[UIColor grayColor].CGColor];
    self.commentsTextView.layer.borderWidth = 1;
    self.commentsTextView.layer.cornerRadius = 5;
    self.commentsTextView.delegate = self;
    [self loadTextViewPlaceHolder];
    [self.view addSubview:self.commentsTextView];
    
    //commentsBtn
    self.commentsBtn.frame = CGRectMake(50, CGRectGetMaxY(self.commentsTextView.frame)+20, screenFrame.size.width-100, 35);
    
    [self.commentsBtn setTitle:@"提交" forState:UIControlStateNormal];
    self.commentsBtn.layer.cornerRadius = 5;
    [self.commentsBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.commentsBtn setBackgroundColor:[UIColor colorWithRed:0/255.0 green:160/255.0 blue:219/255.0 alpha:1.0]];
    [self.view addSubview:self.commentsBtn];
    [self.commentsBtn addTarget:self action:@selector(commentsBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    //添加手势动作，用来取消下面的评论键盘
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(commentsTextViewDismissKeyboard)];
    [self.view addGestureRecognizer:singleFingerTap];
    
    [self haveComments];    
}

- (void)haveComments
{
    StuProfileCommentInfo *commentInfo = [StuProfileCommentInfo getMyCommentWithSessionId:globalSessionId JobId:self.oneJob.jobId];
    self.commentId = commentInfo.commentId;
    if (commentInfo.jobStars == 0 &&commentInfo.salaryStars == 0 &&commentInfo.payTimeStars == 0 &&commentInfo.attitudeStars == 0) {
        return;
    }
    else{
        if (commentInfo.jobStars != 0) {
            UIButton *btn = (UIButton*)[self.estimateView viewWithTag:100+commentInfo.jobStars];
            [self btnClick:btn];
        }
        if (commentInfo.salaryStars != 0) {
            UIButton *btn = (UIButton*)[self.estimateView viewWithTag:105+commentInfo.salaryStars];
            [self btnClick:btn];
        }
        if (commentInfo.payTimeStars != 0) {
            UIButton *btn = (UIButton*)[self.estimateView viewWithTag:110+commentInfo.payTimeStars];
            [self btnClick:btn];
        }
        if (commentInfo.attitudeStars != 0) {
            UIButton *btn = (UIButton*)[self.estimateView viewWithTag:115+commentInfo.attitudeStars];
            [self btnClick:btn];
        }
        for (UIButton *btn in self.allBtns) {
            btn.userInteractionEnabled = NO;
        }
        self.commentsBtn.backgroundColor = [UIColor grayColor];
        self.commentsBtn.userInteractionEnabled = NO;
        
        [self.label setText:@""];
        self.commentsTextView.text = commentInfo.content;
        self.commentsTextView.userInteractionEnabled = NO;
        self.commentsBtn.hidden = YES;
        [self.commentsTextView.layer setBorderColor:[UIColor whiteColor].CGColor];
        [self.estimateView.wantEstimateL setText:@"我的评论："];
    }
}

- (void)loadTextViewPlaceHolder
{
    self.label.text = @"说点什么......";
    [self.label setFont:[UIFont systemFontOfSize:12]];
    
    self.label.frame = CGRectMake(5, 3, 120, 20);
    [self.commentsTextView addSubview:self.label];
}

- (void)addBtnsTarget
{
    [self.estimateView.btn1 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.estimateView.btn2 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.estimateView.btn3 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.estimateView.btn4 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.estimateView.btn5 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.estimateView.btn6 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.estimateView.btn7 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.estimateView.btn8 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.estimateView.btn9 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.estimateView.btn10 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.estimateView.btn11 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.estimateView.btn12 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.estimateView.btn13 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.estimateView.btn14 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.estimateView.btn15 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.estimateView.btn16 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.estimateView.btn17 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.estimateView.btn18 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.estimateView.btn19 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.estimateView.btn20 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.estimateView.btn21 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.estimateView.btn22 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.estimateView.btn23 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.estimateView.btn24 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.estimateView.btn25 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma textViewDelegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (![text isEqualToString:@""])
    {
        self.label.hidden = YES;
    }
    if ([text isEqualToString:@""] && range.location == 0 && range.length == 1)
    {
        self.label.hidden = NO;
    }
    return YES;
}

- (void)btnClick:(UIButton*)btn
{
    unsigned long btnIndex = btn.tag;
    unsigned long btnIndex1 = btn.tag;
    unsigned long btnIndex2 = btn.tag;
    while (true) {
        if (btnIndex1%5 == 0) {
            break;
        }
        btnIndex1++;
        UIButton *btn = (UIButton*)[self.estimateView viewWithTag:btnIndex1];
        [btn setSelected:NO];
    }
    
    while (true) {
        UIButton *btn = (UIButton*)[self.estimateView viewWithTag:btnIndex2];
        btnIndex2--;
        [btn setSelected:YES];
        if (btnIndex2%5 == 0) {
            break;
        }
    }
    
    if (btnIndex>=101 && btnIndex<=105) {
        self.score1 = btnIndex-100;
    }
    else if (btnIndex>=106 && btnIndex<=110)
    {
        self.score2 = btnIndex-105;
    }
    else if (btnIndex>=111 && btnIndex<=115)
    {
        self.score3 = btnIndex-110;
    }
    else if (btnIndex>=116 && btnIndex<=120)
    {
        self.score4 = btnIndex-115;
    }
    
    self.totalEs = (self.score1+self.score2+self.score3+self.score4)/4;
    for (int i=1; i<=self.totalEs; i++) {
        UIButton *btn = (UIButton*)[self.estimateView viewWithTag:(i+120)];
        [btn setSelected:YES];
    }
}

- (void)commentsTextViewDismissKeyboard {
    [self.commentsTextView resignFirstResponder];
}

- (void)commentsBtnClick
{
    BOOL result = [StuProfileCommentInfo commentsBtnClickWithCommentId:self.commentId JobStars:[NSString stringWithFormat:@"%ld", self.score1] SalaryStars:[NSString stringWithFormat:@"%ld", self.score2] PayTimeStars:[NSString stringWithFormat:@"%ld", self.score3] AttitudeStars:[NSString stringWithFormat:@"%ld", self.score4] AverageStars:[NSString stringWithFormat:@"%ld", self.totalEs] Content:self.commentsTextView.text];
    
    if (result) {
        [MBProgressHUD showSuccess:@"评价成功"];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        [MBProgressHUD showError:@"评价失败"];
    }
}
@end
