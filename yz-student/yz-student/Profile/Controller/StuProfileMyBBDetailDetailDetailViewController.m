//
//  StuProfileMyBBDetailDetailDetailViewController.m
//  yz-student
//
//  Created by 仲光磊 on 15/10/21.
//  Copyright © 2015年 cdq. All rights reserved.
//

#import "StuProfileMyBBDetailDetailDetailViewController.h"
#import "StuConfig.h"
#import "StuProfileBBOnePeopleDetail.h"
#import "StuProfileBBOnePeopleDetailOne.h"
#import "StuProfileMyBBDetailDetailDetailTableCell.h"
#import "StuProfileMyBBSignUpsViewController.h"
#import "StuProfileAllMySignInfo.h"
#import "MBProgressHUD+MJ.h"

#define headViewH 30
#define footerViewH 150
#define myYellowColor [UIColor colorWithRed:255/255.0 green:244/155.0 blue:194/255.0 alpha:1.0]
#define myBlueColor [UIColor colorWithRed:28/255.0 green:141/255.0 blue:213/255.0 alpha:1.0]
#define myGrayColor [UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1.0]
#define myFontSize 14
#define cellH 80
#define cellPaddingH 5
#define cellBtnH 20
#define cellBigBtnH 30
#define paddingW 20
#define hiredBtnTag 10001
#define checkSignBtnTag 60001

extern NSString *globalSessionId;

@interface StuProfileMyBBDetailDetailDetailViewController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong)UITableView *bbDetailTableView;
@property(nonatomic, strong)UITextField *actualNumTextField;
@property(nonatomic, strong)UIButton *overGameBtn;
@property(nonatomic, strong)StuProfileBBOnePeopleDetail *detail;
@property(nonatomic, assign)int hiredNums;
@property(nonatomic, copy)NSString* aMemberId;

@end

@implementation StuProfileMyBBDetailDetailDetailViewController

- (StuProfileBBOnePeopleDetail *)detail
{
    if (_detail == nil) {
        _detail = [[StuProfileBBOnePeopleDetail alloc]init];
    }
    return _detail;
}

- (UIButton *)overGameBtn
{
    if (_overGameBtn == nil) {
        _overGameBtn = [[UIButton alloc]init];
    }
    return _overGameBtn;
}

- (UITextField *)actualNumTextField
{
    if (_actualNumTextField == nil) {
        _actualNumTextField = [[UITextField alloc]init];
    }
    return _actualNumTextField;
}

- (UITableView *)bbDetailTableView
{
    if (_bbDetailTableView == nil) {
        _bbDetailTableView = [[UITableView alloc]init];
    }
    return _bbDetailTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *headView = [self setUpHeadView];
    headView.frame = CGRectMake(0, 64, screenFrame.size.width, headViewH);
    [self.view addSubview:headView];
    
    UIView *footerView = [self setUpFooterView];
    footerView.frame = CGRectMake(0, 30, screenFrame.size.width, footerViewH);
    self.bbDetailTableView.tableFooterView = footerView;
    
    self.bbDetailTableView.dataSource = self;
    self.bbDetailTableView.delegate = self;
    self.bbDetailTableView.frame = CGRectMake(0, CGRectGetMaxY(headView.frame), screenFrame.size.width, screenFrame.size.height-headViewH);
    [self.view addSubview:self.bbDetailTableView];
    self.bbDetailTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    StuProfileBBOnePeopleDetail *detail = [StuProfileBBOnePeopleDetail bbOnePelpleDetailWithRelationId:self.relationId];
    self.detail = detail;
    self.hiredNums = [self.detail.enrolNum intValue];
}

- (UIView*)setUpFooterView
{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = myGrayColor;
    [view addSubview:self.actualNumTextField];
    [view addSubview:self.overGameBtn];
    
    UIView *whiteView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenFrame.size.width, cellPaddingH*2)];
    whiteView.backgroundColor = [UIColor whiteColor];
    [view addSubview:whiteView];
    
    self.actualNumTextField.frame = CGRectMake(paddingW, 50, screenFrame.size.width-paddingW*2, cellBigBtnH);
    self.actualNumTextField.placeholder = @"实际工作人数";
    self.actualNumTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.actualNumTextField.font = [UIFont systemFontOfSize:myFontSize];
    self.actualNumTextField.keyboardType = UIKeyboardTypeNumberPad;
    
    self.overGameBtn.frame = CGRectMake(paddingW, CGRectGetMaxY(self.actualNumTextField.frame)+cellPaddingH*2, screenFrame.size.width-paddingW*2, cellBigBtnH);
    [self.overGameBtn setTitle:@"完工" forState:UIControlStateNormal];
    [self.overGameBtn setTitle:@"已完工" forState:UIControlStateSelected];
    self.overGameBtn.titleLabel.font = [UIFont systemFontOfSize:myFontSize];
    [self.overGameBtn setBackgroundColor:myBlueColor];
    [self.overGameBtn.titleLabel setTextColor:[UIColor whiteColor]];
    [self.overGameBtn addTarget:self action:@selector(overGameBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return view;
}

- (UIView*)setUpHeadView
{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = myGrayColor;
    //人员列表	联系方式	报名时间	操作
    CGFloat labelW = screenFrame.size.width/4.0;
    UILabel *peopleL = [[UILabel alloc]init];
    [peopleL setFont:[UIFont boldSystemFontOfSize:myFontSize]];
    peopleL.frame = CGRectMake(0, 0, labelW, headViewH);
    peopleL.textAlignment = NSTextAlignmentCenter;
    peopleL.text = @"人员列表";
    [view addSubview:peopleL];
    
    UILabel *telephoneL = [[UILabel alloc]init];
    [telephoneL setFont:[UIFont boldSystemFontOfSize:myFontSize]];
    telephoneL.frame = CGRectMake(labelW, 0, labelW, headViewH);
    telephoneL.textAlignment = NSTextAlignmentCenter;
    telephoneL.text = @"联系方式";
    [view addSubview:telephoneL];
    
    UILabel *signUpDateL = [[UILabel alloc]init];
    [signUpDateL setFont:[UIFont boldSystemFontOfSize:myFontSize]];
    signUpDateL.frame = CGRectMake(labelW*2, 0, labelW, headViewH);
    signUpDateL.textAlignment = NSTextAlignmentCenter;
    signUpDateL.text = @"报名时间";
    [view addSubview:signUpDateL];
    
    UILabel *actionL = [[UILabel alloc]init];
    [actionL setFont:[UIFont boldSystemFontOfSize:myFontSize]];
    actionL.frame = CGRectMake(labelW*3, 0, labelW, headViewH);
    actionL.textAlignment = NSTextAlignmentCenter;
    actionL.text = @"操作";
    [view addSubview:actionL];
    
    return view;
}

#pragma tableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.detail.oneArray.count;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return cellH;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StuProfileBBOnePeopleDetailOne *one = self.detail.oneArray[indexPath.row];
    StuProfileMyBBDetailDetailDetailTableCell *cell = [StuProfileMyBBDetailDetailDetailTableCell cellWithTableView:tableView];
    
    cell.peopleL.text = one.oneOne.name;
    cell.telephoneL.text = one.oneOne.telephone;
    cell.signUpDateL.text = [[one.oneOne.createDate substringFromIndex:5] substringToIndex:5];
    if ([one.oneOne.status isEqualToString:@"1"]) {
        [cell.hiredBtn setSelected:YES];
    }
    [cell.hiredBtn addTarget:self action:@selector(hiredBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.checkSignUpBtn addTarget:self action:@selector(checkSignUpBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.hiredBtn.tag = hiredBtnTag + indexPath.row;
    cell.checkSignUpBtn.tag = checkSignBtnTag + indexPath.row;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if ([one.memberId isEqualToString:globalSessionId]) {
        cell.backgroundColor = myYellowColor;
    }
    else
    {
        cell.backgroundColor = myGrayColor;
    }
    
    if ([self.status isEqualToString:@"2"] || [self.status isEqualToString:@"3"] ||[self.status isEqualToString:@"4"] ||[self.status isEqualToString:@"5"]) {
        cell.hiredBtn.hidden = YES;
        CGFloat labelW = screenFrame.size.width/4.0;
        cell.checkSignUpBtn.frame = CGRectMake(screenFrame.size.width/4.0*3.0+cellPaddingH*2, cellPaddingH*2, labelW-cellPaddingH*2, cellBtnH);
        cell.checkSignUpBtn.center = CGPointMake(screenFrame.size.width-cellPaddingH-labelW*0.5, cellH*0.5);
        
        if ([self.status isEqualToString:@"3"] ||[self.status isEqualToString:@"4"] ||[self.status isEqualToString:@"5"]) {
            self.bbDetailTableView.tableFooterView.hidden = YES;
        }
    }
    return cell;
}

- (void)hiredBtnClick:(UIButton*)btn
{
    StuProfileBBOnePeopleDetailOne *one = self.detail.oneArray[btn.tag - hiredBtnTag];
    if (btn.selected) {
        [self hiredWithSessionId:one.memberId JobId:self.jobId RelationId:self.detail.relationId State:@"0"];
        [btn setSelected:!btn.selected];
    }
    else
    {
        if (self.hiredNums == self.recruitNum-1) {
            self.aMemberId = one.memberId;
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"录取该人员后包办将完成，已录取人员将不能被取消，继续？" message:nil delegate:self cancelButtonTitle:@"继续" otherButtonTitles:@"取消", nil];
            [alertView show];
        }
        else
        {
            [self hiredWithSessionId:one.memberId JobId:self.jobId RelationId:self.detail.relationId State:@"1"];
            [btn setSelected:!btn.selected];
        }
        
        self.hiredNums++;
    }
}

- (void)overGameBtnClick:(UIButton*)btn
{
    NSString *actualNum = self.actualNumTextField.text;
    if (actualNum.intValue > self.recruitNum) {
        [MBProgressHUD showError:@"您输入的人数大于招聘人数"];
        return;
    }
    
    if (actualNum.intValue == 0) {
        [MBProgressHUD showError:@"请输入人数"];
        return;
    }
    
    if (![self.status isEqualToString:@"2"]) {
        [MBProgressHUD showError:@"包办未完成,不能结算"];
        return;
    }
    
    if ([self overGameWithRelationId:self.detail.relationId ActualNum:actualNum]) {
        [btn setTitle:@"已完工" forState:UIControlStateNormal];
        btn.userInteractionEnabled = NO;
        self.actualNumTextField.userInteractionEnabled = NO;
        [MBProgressHUD showSuccess:@"完工成功"];
    }
    else{
        [MBProgressHUD showError:@"完工失败"];
        self.actualNumTextField.text = @"";
    }
}


#pragma alertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        BOOL result = [self hiredWithSessionId:self.aMemberId JobId:self.jobId RelationId:self.detail.relationId State:@"1"];

        if (result) {
            StuProfileBBOnePeopleDetail *detail = [StuProfileBBOnePeopleDetail bbOnePelpleDetailWithRelationId:self.relationId];
            self.detail = detail;
            self.status = @"2";
            [self.bbDetailTableView reloadData];
        }
        else
        {
            return;
        }
    }
    
}

- (void)checkSignUpBtnClick:(UIButton*)btn
{
    StuProfileBBOnePeopleDetailOne *one = self.detail.oneArray[btn.tag - checkSignBtnTag];
    [self checkSignInWithSessionId:globalSessionId JobId:self.jobId ArrangeId:one.memberId DateId:self.detail.signUpDateId];
}

- (BOOL)hiredWithSessionId:(NSString*)sessionId JobId:(NSString*)jobId RelationId:(NSString*)relationId State:(NSString*)state
{
    NSString *url = @"/weChat/arrangedSignUp/updateState";
    
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", serverIp, url]];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:URL];
    request.timeoutInterval=5.0;//设置请求超时为5秒
    request.HTTPMethod=@"POST";//设置请求方法
    
    //设置请求体
    NSString *param=[NSString stringWithFormat:@"memberId=%@&relationId=%@&jobId=%@&state=%@",sessionId, relationId, jobId, state];
    //把拼接后的字符串转换为data，设置请求体
    request.HTTPBody=[param dataUsingEncoding:NSUTF8StringEncoding];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    if ([str isEqualToString:@"\"error\""]) {
        return NO;
    }
    else
    {
        return YES;
    }
}

- (BOOL)overGameWithRelationId:(NSString*)relationId ActualNum:(NSString*)actualNum
{
    NSString *url = @"/weChat/arrangedRelation/complete";
    
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", serverIp, url]];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:URL];
    request.timeoutInterval=5.0;//设置请求超时为5秒
    request.HTTPMethod=@"POST";//设置请求方法
    
    //设置请求体
    NSString *param=[NSString stringWithFormat:@"relationId=%@&actualNum=%@",relationId, actualNum];
    //把拼接后的字符串转换为data，设置请求体
    request.HTTPBody=[param dataUsingEncoding:NSUTF8StringEncoding];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    if ([str isEqual:@"\"success\""]) {
        return YES;
    }
    else
    {
        return NO;
    }
}

- (void)checkSignInWithSessionId:(NSString*)sessionId JobId:(NSString*)jobId ArrangeId:(NSString*)arrangeId DateId:(NSString*)dateId
{
    NSString *strUrl = [NSString stringWithFormat:@"%@/weChat/arrangedSignUp/getMySignInInfo?memberId=%@&jobId=%@&arrangedId=%@&dateId=%@", serverIp, sessionId, jobId, arrangeId, dateId];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:strUrl]] returningResponse:nil error:nil];
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    
    NSString *nowDateUrl = [NSString stringWithFormat:@"%@/weChat/member/getNoWTime", serverIp];
    NSData *nowDateData = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:nowDateUrl]] returningResponse:nil error:nil];
    NSString *nowDateStr = [[NSString alloc]initWithData:nowDateData encoding:NSUTF8StringEncoding];
    
    StuProfileAllMySignInfo *signInfo = [[StuProfileAllMySignInfo alloc]init];
    signInfo.date = [NSString stringWithFormat:@"%@", [nowDateStr substringWithRange:NSMakeRange(1, 10)]];
    signInfo.signInTime = dict[@"signInTime"];
    signInfo.signInAddress = dict[@"signInAddress"];
    signInfo.signOutTime = dict[@"signOutTime"];
    signInfo.signOutAddress = dict[@"signOutAddress"];
    
    StuProfileMyBBSignUpsViewController *vc = [[StuProfileMyBBSignUpsViewController alloc]init];
    vc.signInfo = signInfo;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
