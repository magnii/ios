//
//  StuPreSalaryViewController.m
//  yz-student
//
//  Created by 仲光磊 on 15/10/5.
//  Copyright © 2015年 cdq. All rights reserved.
//

#import "StuPreSalaryViewController.h"
#import "StuConfig.h"
#import "StuPreSalarySelectJobViewController.h"
#import "StuJobDateObj.h"
#import "StuPreSalaryUpLoadIDViewController.h"
#import "MBProgressHUD+MJ.h"

#define paddingX 10
#define paddingY 10
#define segmentedControlW 100
#define labelH 25
#define labelW 80
#define labelFontSize 14
#define textViewH 80
#define preProtocolW 100
#define selectJobBtnW 100
#define buttonH 30
#define selectJobDateBtnH 15
#define selectJobDateBtnW 80
#define selectJobDateBtnPadding ((screenFrame.size.width-selectJobDateBtnW*2)/3.0)
#define paddingH 10

#define myGrayColor [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0]
#define myYellowColor [UIColor colorWithRed:240/255.0 green:143/255.0 blue:2/255.0 alpha:1.0]

NSMutableArray *preDateIdArray;
int preAllSalary;

@interface StuPreSalaryViewController ()<UITextViewDelegate>

@property(nonatomic, strong)UILabel *textViewLabel;
@property(nonatomic, strong)UITextView *excuseTextView;
@property(nonatomic, strong)UIScrollView *preScrollView;
@property(nonatomic, strong)UISegmentedControl *segmentedControl;
@property(nonatomic, assign)CGFloat nextStepY;
@property(nonatomic, strong)UIButton *selectJobBtn;
@property(nonatomic, strong)UIButton *nextStepBtn;
@property(nonatomic, strong)NSMutableArray *btnArrayM;
@property(nonatomic, strong)NSMutableArray *btnLabelArrayM;

@end

@implementation StuPreSalaryViewController

- (NSMutableArray *)btnLabelArrayM
{
    if (_btnLabelArrayM == nil) {
        _btnLabelArrayM = [NSMutableArray array];
    }
    return _btnLabelArrayM;
}

- (NSMutableArray *)btnArrayM
{
    if (_btnArrayM == nil) {
        _btnArrayM = [NSMutableArray array];
    }
    return _btnArrayM;
}

- (UIButton *)selectJobBtn
{
    if (_selectJobBtn == nil) {
        _selectJobBtn = [[UIButton alloc]init];
    }
    return _selectJobBtn;
}

- (UIScrollView *)preScrollView
{
    if (_preScrollView == nil) {
        _preScrollView = [[UIScrollView alloc]init];
    }
    return _preScrollView;
}

- (UILabel *)textViewLabel
{
    if (_textViewLabel == nil) {
        _textViewLabel = [[UILabel alloc]init];
    }
    return _textViewLabel;
}

- (UITextView *)excuseTextView
{
    if (_excuseTextView == nil) {
        _excuseTextView = [[UITextView alloc]init];
    }
    return _excuseTextView;
}

- (UISegmentedControl *)segmentedControl
{
    if (_segmentedControl == nil) {
        NSArray *segmentArray = @[@"100元", @"200元"];
        _segmentedControl = [[UISegmentedControl alloc]initWithItems:segmentArray];
    }
    return _segmentedControl;
}

- (UIButton *)nextStepBtn
{
    if (_nextStepBtn == nil) {
        _nextStepBtn = [[UIButton alloc]init];
    }
    return _nextStepBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (preDateIdArray == nil) {
        preDateIdArray = [NSMutableArray array];
    }else
    {
        [preDateIdArray removeAllObjects];
    }
    
    self.title = @"预支工资";
    self.view.backgroundColor = myGrayColor;
    
    self.preScrollView.frame = screenFrame;
    self.preScrollView.contentSize = CGSizeMake(screenFrame.size.width, screenFrame.size.height+500);
    [self.view addSubview:self.preScrollView];
    
    UILabel *preNumL = [[UILabel alloc]initWithFrame:CGRectMake(paddingX, paddingY, labelW, labelH)];
    preNumL.text = @"预支金额 :";
    [preNumL setFont:[UIFont boldSystemFontOfSize:labelFontSize]];
    [self.preScrollView addSubview:preNumL];
    
    [self.preScrollView addSubview:self.segmentedControl];
    self.segmentedControl.frame = CGRectMake(CGRectGetMaxX(preNumL.frame), paddingY, segmentedControlW, labelH);
    self.segmentedControl.selectedSegmentIndex = 0;
    
    UILabel *preExecuseL = [[UILabel alloc]initWithFrame:CGRectMake(paddingX, CGRectGetMaxY(preNumL.frame)+10, labelW, labelH)];
    preExecuseL.text = @"预支理由 :";
    [preExecuseL setFont:[UIFont boldSystemFontOfSize:labelFontSize]];
    [self.preScrollView addSubview:preExecuseL];
    
    [self.excuseTextView.layer setBorderColor:[UIColor grayColor].CGColor];
    self.excuseTextView.layer.borderWidth = 1;
    self.excuseTextView.layer.cornerRadius = 5;
    self.excuseTextView.delegate = self;
    [self loadTextViewPlaceHolder];
    self.excuseTextView.frame = CGRectMake(CGRectGetMaxX(preExecuseL.frame), CGRectGetMaxY(self.segmentedControl.frame)+paddingY, screenFrame.size.width-CGRectGetMaxX(preExecuseL.frame)-paddingY*2, textViewH);
    [self.preScrollView addSubview:self.excuseTextView];
    
    UIButton *preProtocol = [[UIButton alloc]init];
    preProtocol.frame = CGRectMake((screenFrame.size.width-preProtocolW)*0.5, CGRectGetMaxY(self.excuseTextView.frame)+paddingY, preProtocolW, labelH);
    [preProtocol setImage:[UIImage imageNamed:@"duihao_2"] forState:UIControlStateNormal];
    [preProtocol setImage:[UIImage imageNamed:@"duihao_1"] forState:UIControlStateSelected];
    [preProtocol setTitle:@"预支工资协议" forState:UIControlStateNormal];
    [preProtocol.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [preProtocol setTitleColor:[UIColor colorWithRed:0/255.0 green:160/255.0 blue:219/255.0 alpha:1.0] forState:UIControlStateNormal];
    [preProtocol setSelected:YES];
    
    [preProtocol addTarget:self action:@selector(preProtocolBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    //[preProtocol setBackgroundImage:[UIImage imageNamed:@"line002"] forState:UIControlStateNormal];
    [self.preScrollView addSubview:preProtocol];
    
    self.selectJobBtn.frame = CGRectMake((screenFrame.size.width-selectJobBtnW)*0.5, CGRectGetMaxY(preProtocol.frame)+paddingY, selectJobBtnW, buttonH);
    [self.selectJobBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.selectJobBtn.backgroundColor = myYellowColor;
    self.selectJobBtn.layer.cornerRadius = 3;
    [self.selectJobBtn setTitle:@"选择兼职" forState:UIControlStateNormal];
    [self.selectJobBtn addTarget:self action:@selector(selectJobBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.selectJobBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [self.preScrollView addSubview:self.selectJobBtn];
    [self setNextStepFrame];
    
    UITapGestureRecognizer *singleFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self
     
                                            action:@selector(commentsTextViewDismissKeyboard)];
    
    [self.preScrollView addGestureRecognizer:singleFingerTap];
}

- (void)preProtocolBtnClick:(UIButton*)btn
{
    [btn setSelected:!btn.selected];
}

- (void)commentsTextViewDismissKeyboard
{
    [self.excuseTextView resignFirstResponder];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.nextStepY = CGRectGetMaxY(self.selectJobBtn.frame)+20;
    
    [self removeSelectBtns];
    [self removeSelectBtnLabels];
    [self setSelectBtns];
    
    self.nextStepBtn.frame = CGRectMake((screenFrame.size.width-selectJobBtnW)*0.5, self.nextStepY+paddingH*6, selectJobBtnW, buttonH);
}

- (void)selectJobBtnClick
{
    StuPreSalarySelectJobViewController *vc = [[StuPreSalarySelectJobViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)removeSelectBtns
{
    for (UIButton *btn in self.btnArrayM) {
        [btn removeFromSuperview];
    }
}

- (void)removeSelectBtnLabels
{
    for (UILabel *label in self.btnLabelArrayM) {
        [label removeFromSuperview];
    }
}

- (void)setSelectBtns
{
    NSMutableArray *selectBtnLM = [NSMutableArray array];
    for (StuJobDateObj *jobDate in preDateIdArray)
    {
        if (selectBtnLM.count == 0) {
            [selectBtnLM addObject:jobDate.jobName];
            continue;
        }
        for (int i=0; i<selectBtnLM.count; i++) {
            if ([jobDate.jobName isEqualToString:selectBtnLM[i]]) {
                break;
            }
            if (i == selectBtnLM.count-1) {
                [selectBtnLM addObject:jobDate.jobName];
            }
        }
    }
    
    for (NSString *name in selectBtnLM) {
        
        UILabel *label = [[UILabel alloc]init];
        [label setText:name];
        [label setTextColor:[UIColor colorWithRed:0/255.0 green:160/255.0 blue:219/255.0 alpha:1.0]];
        [label setFont:[UIFont boldSystemFontOfSize:16]];
        label.frame = CGRectMake(30, self.nextStepY+paddingH*2, screenFrame.size.width-60, 30);
        [self.preScrollView addSubview:label];
        self.nextStepY = label.frame.origin.y;
        [self.btnLabelArrayM addObject:label];
        
        int btnIndex = 0;
        for (StuJobDateObj *jobDate in preDateIdArray)
        {
            if ([name isEqualToString:jobDate.jobName]) {
                UIButton *btn = [[UIButton alloc]init];
                [btn setTitle:[jobDate.jobDate substringFromIndex:5] forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                [btn.titleLabel setFont:[UIFont systemFontOfSize:12]];
                
                btn.enabled = NO;
                
                if (btnIndex%2 == 0) {
                    btn.frame = CGRectMake(selectJobDateBtnPadding, self.nextStepY+paddingH+selectJobDateBtnH, selectJobDateBtnW, selectJobDateBtnH);
                    
                    self.nextStepY = btn.frame.origin.y;
                }
                else
                {
                    btn.frame = CGRectMake(selectJobDateBtnPadding*2+selectJobDateBtnW, self.nextStepY, selectJobDateBtnW, selectJobDateBtnH);
                }
                [self.btnArrayM addObject:btn];
                btnIndex++;
                [self.preScrollView addSubview:btn];
            }
        }
    }
}

- (void)setNextStepFrame
{
    [self.nextStepBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.nextStepBtn.backgroundColor = myYellowColor;
    self.nextStepBtn.layer.cornerRadius = 3;
    [self.nextStepBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [self.nextStepBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    
    [self.nextStepBtn addTarget:self action:@selector(nextStepBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.preScrollView addSubview:self.nextStepBtn];
}

- (void)nextStepBtnClick
{
    if ([self.excuseTextView.text isEqualToString:@""]) {
        [MBProgressHUD showError:@"请填写预支理由"];
        return;
    }
    if (preDateIdArray == nil || preDateIdArray.count == 0) {
        [MBProgressHUD showError:@"请选择兼职"];
        return;
    }
    NSString *allMoney = self.segmentedControl.selectedSegmentIndex == 0 ?@"100":@"200";
    if (preAllSalary < [allMoney intValue]) {
        [MBProgressHUD showError:@"申请的预支金额大于预支工资"];
        return;
    }
    StuPreSalaryUpLoadIDViewController *vc = [[StuPreSalaryUpLoadIDViewController alloc]init];
    vc.money = allMoney;
    vc.execuse = self.excuseTextView.text;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)loadTextViewPlaceHolder
{
    self.textViewLabel.text = @"请描述您的预支理由......";
    [self.textViewLabel setFont:[UIFont systemFontOfSize:12]];
    
    self.textViewLabel.frame = CGRectMake(5, 3, 150, 20);
    [self.excuseTextView addSubview:self.textViewLabel];
}

#pragma textViewDelegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (![text isEqualToString:@""])
    {
        self.textViewLabel.hidden = YES;
    }
    if ([text isEqualToString:@""] && range.location == 0 && range.length == 1)
    {
        self.textViewLabel.hidden = NO;
    }
    return YES;
}


@end
