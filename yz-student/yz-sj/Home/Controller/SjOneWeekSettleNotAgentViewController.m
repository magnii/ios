//
//  SjOneWeekSettleNotAgentViewController.m
//  yz-student
//
//  Created by 仲光磊 on 15/11/9.
//  Copyright © 2015年 cdq. All rights reserved.
//

#import "SjOneWeekSettleNotAgentViewController.h"
#import "StuConfig.h"
#import "SjWeekSettleOne.h"
#import "SjWeekSettleOneWeekTableViewCell.h"

#define cellHeadH 80
#define oneRegisMemberH 50
#define SettleBtnH 30

#define workDayTFTag 10010
#define checkSignBtnTag 20020
#define selectBtnTag 30030
#define salaryLTag 40040

#define BtnBackgroundBlueColor [UIColor colorWithRed:28/255.0 green:141/255.0 blue:213/255.0 alpha:1.0]

@interface SjOneWeekSettleNotAgentViewController ()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property(nonatomic, strong)UITableView *weekSettleTableView;
@property(nonatomic, strong)NSArray *wekSettleArry;
@property(nonatomic, strong)UIView *headView;
@property(nonatomic, strong)UIButton *unSettledBtn;
@property(nonatomic, strong)UIButton *settledBtn;
@property(nonatomic, strong)UIButton *overGameBtn;

@end

@implementation SjOneWeekSettleNotAgentViewController

- (UIButton *)overGameBtn
{
    if (_overGameBtn == nil) {
        _overGameBtn = [[UIButton alloc]init];
        [_overGameBtn setTitle:@"结算" forState:UIControlStateNormal];
        _overGameBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        [_overGameBtn setBackgroundColor:BtnBackgroundBlueColor];
        [_overGameBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _overGameBtn;
}

- (UIButton *)unSettledBtn
{
    if (_unSettledBtn == nil) {
        _unSettledBtn = [[UIButton alloc]init];
        [_unSettledBtn setTitle:@"待结算" forState:UIControlStateNormal];
        [_unSettledBtn setTitleColor:BtnBackgroundBlueColor forState:UIControlStateNormal];
        [_unSettledBtn setBackgroundColor:[UIColor whiteColor]];
        [_unSettledBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
        [_unSettledBtn addTarget:self action:@selector(unSettledBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _unSettledBtn;
}

- (UIButton *)settledBtn
{
    if (_settledBtn == nil) {
        _settledBtn = [[UIButton alloc]init];
        [_settledBtn setTitle:@"已结算" forState:UIControlStateNormal];
        [_settledBtn setTitleColor:BtnBackgroundBlueColor forState:UIControlStateNormal];
        [_settledBtn setBackgroundColor:[UIColor whiteColor]];
        [_settledBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
        [_settledBtn addTarget:self action:@selector(settledBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _settledBtn;
}

- (UIView *)headView
{
    if (_headView == nil) {
        _headView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, screenFrame.size.width, SettleBtnH)];
        self.unSettledBtn.frame = CGRectMake(0, 0, screenFrame.size.width*0.5, SettleBtnH);
        self.settledBtn.frame = CGRectMake(CGRectGetMaxX(self.unSettledBtn.frame), 0, screenFrame.size.width*0.5, SettleBtnH);
        [_headView addSubview:self.unSettledBtn];
        [_headView addSubview:self.settledBtn];
    }
    return _headView;
}

- (UITableView *)weekSettleTableView
{
    if (_weekSettleTableView == nil) {
        _weekSettleTableView = [[UITableView alloc]init];
    }
    return _weekSettleTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"结算";
    
    self.weekSettleTableView.delegate = self;
    self.weekSettleTableView.dataSource = self;
    
    self.weekSettleTableView.frame = CGRectMake(0, SettleBtnH+64, screenFrame.size.width, screenFrame.size.height-SettleBtnH);
    [self.view addSubview:self.headView];
    [self.view addSubview:self.weekSettleTableView];
    
    [self unSettledBtnClick: self.unSettledBtn];
    
    UITapGestureRecognizer *singleFingerTap =
    
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:singleFingerTap];
    
    [self loadFooterView];
}

- (void)loadFooterView
{
    UIView *footerView = [[UIView alloc]init];
    footerView.frame = CGRectMake(0, 0, screenFrame.size.width, 50);
    self.overGameBtn.frame = CGRectMake(40, 15, screenFrame.size.width-40*2, 30);
    [footerView addSubview:self.overGameBtn];
    [self.overGameBtn addTarget:self action:@selector(overGameBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.weekSettleTableView.tableFooterView = footerView;
}

- (void)dismissKeyboard
{
    [self.view endEditing:YES];
}


- (void)unSettledBtnClick:(UIButton*)btn
{
    if (btn.selected) {
        return;
    }
    else
    {
        self.wekSettleArry = [SjWeekSettleOne weekSettleOneWithJobId:self.jobId DateIds:self.dateIds SettleType:Unsettled];
        [self.weekSettleTableView reloadData];
        if (self.wekSettleArry.count == 0) {
            self.overGameBtn.hidden = YES;
        }
        
        btn.selected = YES;
        self.settledBtn.selected = NO;
        [self.settledBtn setBackgroundColor:[UIColor whiteColor]];
        [self.settledBtn setTitleColor:BtnBackgroundBlueColor forState:UIControlStateNormal];
        
        [self.unSettledBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.unSettledBtn setBackgroundColor:BtnBackgroundBlueColor];
    }
}

- (void)settledBtnClick:(UIButton*)btn
{
    if (btn.selected) {
        return;
    }
    else
    {
        self.wekSettleArry = [SjWeekSettleOne weekSettleOneWithJobId:self.jobId DateIds:self.dateIds SettleType:Settled];
        [self.weekSettleTableView reloadData];
        if (self.wekSettleArry.count == 0) {
            self.overGameBtn.hidden = YES;
        }
        
        btn.selected = !btn.selected;
        self.unSettledBtn.selected = NO;
        [self.unSettledBtn setBackgroundColor:[UIColor whiteColor]];
        [self.unSettledBtn setTitleColor:BtnBackgroundBlueColor forState:UIControlStateNormal];
        
        [self.settledBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.settledBtn setBackgroundColor:BtnBackgroundBlueColor];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.wekSettleArry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SjWeekSettleOne *weekOne = self.wekSettleArry[indexPath.row];
    
    SjWeekSettleOneWeekTableViewCell *cell = [SjWeekSettleOneWeekTableViewCell cellWithTableView:tableView];
    if (self.settledBtn.selected) {
        cell.nameL.text = weekOne.name;
        cell.phoneL.text = weekOne.mobile;
        cell.salaryL.text = [NSString stringWithFormat:@"%d", weekOne.money];
        cell.daysL.text = weekOne.days;
        cell.workDayTF.text = [NSString stringWithFormat:@"%ld", weekOne.workDays];
        cell.workDayTF.userInteractionEnabled = NO;
        cell.selectBtn.selected = YES;
        cell.selectBtn.userInteractionEnabled = NO;
    }
    else
    {
        cell.nameL.text = weekOne.name;
        cell.phoneL.text = weekOne.mobile;
        cell.salaryL.text = @"";//[NSString stringWithFormat:@"%d", weekOne.salary];
        cell.salaryL.tag = salaryLTag+indexPath.row;
        cell.daysL.text = weekOne.days;
        cell.workDayTF.tag = workDayTFTag+indexPath.row;
        cell.workDayTF.delegate = self;
        cell.workDayTF.userInteractionEnabled = NO;
        cell.signBtn.tag = checkSignBtnTag+indexPath.row;
        cell.selectBtn.tag = selectBtnTag+indexPath.row;
        [cell.selectBtn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [cell.signBtn addTarget:self action:@selector(signBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma uiTextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    long tmpTag = textField.tag;
    UIView *view = [self.view viewWithTag:(tmpTag-workDayTFTag+salaryLTag)];
    if ([view isKindOfClass:[UILabel class]]) {
        UILabel *label = (UILabel *)view;
        SjWeekSettleOne *weekOne = self.wekSettleArry.firstObject;
        label.text = [NSString stringWithFormat:@"%d", weekOne.salary*textField.text.intValue];
    }
}

- (void)signBtnClick:(UIButton*)btn
{
    NSLog(@"signBtnClick.tag=%ld", (long)btn.tag);
}

- (void)selectBtnClick:(UIButton *)btn
{
    btn.selected = !btn.selected;
    long tmpTag = btn.tag-selectBtnTag+workDayTFTag;
    UIView *view = [self.view viewWithTag:tmpTag];
    if ([view isKindOfClass:[UITextField class]]) {
        UITextField *tf = (UITextField*)view;
        tf.userInteractionEnabled = YES;
    }
}

- (void)overGameBtnClick
{
    NSLog(@"overGameBtnClick");
}
@end
