//
//  SjComposeJob UIViewController.m
//  yz-student
//
//  Created by 仲光磊 on 15/10/22.
//  Copyright © 2015年 cdq. All rights reserved.
//

#import "SjComposeJobViewController.h"
#import "StuConfig.h"
#import "MBProgressHUD+MJ.h"
#import "SjCityAreas.h"
#import "SjCity.h"
#import "SjCities.h"
#import "SjCityAreas.h"
#import "Sjarea.h"
#import "AFNetworking.h"
#import "SjJobInfo.h"
#import "SjUserDoc.h"

#define workContentTag 888
#define workSpecialTag 999
#define SettlementTypeBtnTag 1000
#define isAgentBtnTag 1001
#define arrangeRewardBtnTag 1002
#define accommodateBtnTag 1003
#define workingLunchBtnTag 1004
#define gentderBtnTag 1005
#define heightBtnTag 1006
#define pickerViewH 192

extern NSString *sjGlobalSessionId;

typedef enum
{
    SettlementTypeBtn = 0,
    JobTypeBtn,
    ProvinceTypeBtn,
    CityTypeBtn,
    AreaTypeBtn,
    WorkStartDateBtn,
    WorkEndDateBtn,
    WorkStartHourBtn,
    WorkEndHourBtn
}ClickButtonType;

@interface SjComposeJobViewController ()<UITextViewDelegate, UIActionSheetDelegate, UIPickerViewDataSource, UIPickerViewDelegate>
@property(nonatomic, strong)UILabel *workContentLabel;
@property(nonatomic, strong)UILabel *workSpecialLabel;
@property(nonatomic, strong)UITextView *workContentTextView;
@property(nonatomic, strong)UITextView *workSpecialTextView;

@property(nonatomic, strong)NSMutableArray *pickerArray;
@property(nonatomic, strong)UIView *pickerView;

@property(nonatomic, copy)NSString *selectItemStr;

@property(nonatomic, strong)SjCityAreas *cityAreas;

@property(nonatomic, assign)ClickButtonType clickButtonType;

@property(nonatomic, strong)SjUserDoc *userDoc;

@end

@implementation SjComposeJobViewController

- (SjUserDoc *)userDoc
{
    if (_userDoc == nil) {
        _userDoc = [[SjUserDoc alloc]init];
    }
    return _userDoc;
}

- (SjCityAreas *)cityAreas
{
    if (_cityAreas == nil) {
        _cityAreas = [[SjCityAreas alloc]init];
    }
    return _cityAreas;
}

- (NSString *)selectItemStr
{
    if (_selectItemStr == nil) {
        _selectItemStr = [NSString string];
    }
    return _selectItemStr;
}

- (UIView *)pickerView
{
    if (_pickerView == nil) {
        _pickerView = [[UIView alloc]init];
    }
    return _pickerView;
}

- (NSMutableArray *)pickerArray
{
    if (_pickerArray == nil) {
        _pickerArray = [NSMutableArray array];
    }
    return _pickerArray;
}

- (UILabel *)workContentLabel
{
    if (_workContentLabel == nil) {
        _workContentLabel = [[UILabel alloc]init];
    }
    return _workContentLabel;
}

- (UILabel *)workSpecialLabel
{
    if (_workSpecialLabel == nil) {
        _workSpecialLabel = [[UILabel alloc]init];
    }
    return _workSpecialLabel;
}

- (UITextView *)workContentTextView
{
    if (_workContentTextView == nil) {
        _workContentTextView = [[UITextView alloc]init];
    }
    return _workContentTextView;
}

- (UITextView *)workSpecialTextView
{
    if (_workSpecialTextView == nil) {
        _workSpecialTextView = [[UITextView alloc]init];
    }
    return _workSpecialTextView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setViewsCorner];
    
    [self loadTextViewPlaceHolder];
    
    [self setButtonsTarget];
    
    [self loadPickerView];
    
    [self loadCityArea];
    
    if (self.oneJobInfo != nil) {
        [self loadOneJobInfo];
    }
    
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(viewDismissKeyboard)];
    [self.view addGestureRecognizer:singleFingerTap];
}

- (void)viewDismissKeyboard
{
    [self.view endEditing:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadUserContact];
}

- (void)loadUserContact
{
    if (![self.userDoc.complete isEqualToString:@"1"]) {
        [MBProgressHUD showError:@"请先完善资料"];
    }
    self.userDoc = [SjUserDoc sjUserDocWithSessionId:sjGlobalSessionId];
    self.contactL.text = self.userDoc.contactPerson;
    self.telephoneL.text = self.userDoc.contactNumber;
}

- (void)loadCityArea
{
    self.cityAreas = [SjCityAreas cityAreasWithNet];
}

- (void)loadPickerView
{
    UIToolbar *toolBar = [[UIToolbar alloc]init];
    toolBar.frame = CGRectMake(0, 0, screenFrame.size.width, 30);
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(buttonItemClick)];
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [toolBar setItems:@[flexibleSpace, buttonItem]];
    [self.pickerView addSubview:toolBar];
    
    self.pickerView.frame = CGRectMake(0, screenFrame.size.height-pickerViewH-49, screenFrame.size.width, pickerViewH);
    
    self.pickerView.hidden = YES;
    [self.view addSubview:self.pickerView];
    self.pickerView.backgroundColor = [UIColor whiteColor];
}

//完成按钮
- (void)buttonItemClick
{
    switch (self.clickButtonType) {
        case SettlementTypeBtn:
            [self.SettlementDateBtn setTitle:self.selectItemStr forState:UIControlStateNormal];
            break;
        case JobTypeBtn:
            [self.jobTypeBtn.titleLabel setText:self.selectItemStr];
            [self.jobTypeBtn setTitle:self.selectItemStr forState:UIControlStateNormal];
            break;
        case ProvinceTypeBtn:
            [self.provinceBtn setTitle:self.selectItemStr forState:UIControlStateNormal];
            break;
        case CityTypeBtn:
            [self.cityBtn setTitle:self.selectItemStr forState:UIControlStateNormal];
            break;
        case AreaTypeBtn:
            [self.areaBtn setTitle:self.selectItemStr forState:UIControlStateNormal];
            break;
        case WorkStartDateBtn:
            [self.workStartDateBtn setTitle:self.selectItemStr forState:UIControlStateNormal];
            break;
        case WorkEndDateBtn:
            [self.workEndDateBtn setTitle:self.selectItemStr forState:UIControlStateNormal];
            break;
        case WorkStartHourBtn:
            [self.workStartHourBtn setTitle:self.selectItemStr forState:UIControlStateNormal];
            break;
        case WorkEndHourBtn:
            [self.workEndHourBtn setTitle:self.selectItemStr forState:UIControlStateNormal];
            break;
            
        default:
            break;
    }
    
    self.pickerView.hidden = YES;
    for (UIView *view in self.pickerView.subviews) {
        if ([view isKindOfClass:[UIToolbar class]]) {
            continue;
        }
        [view removeFromSuperview];
    }
}

- (void)setViewsCorner
{
    [self setOneViewCorner:self.View1];
    [self setOneViewCorner:self.View2];
    [self setOneViewCorner:self.View3];
    [self setOneViewCorner:self.View4];
    [self setOneViewCorner:self.View5];
    [self setOneViewCorner:self.View6];
    [self setOneViewCorner:self.View7];
    [self setOneViewCorner:self.View8];
    [self setOneViewCorner:self.View9];
    [self setOneViewCorner:self.View10];
    [self setOneViewCorner:self.View11];
    [self setOneViewCorner:self.View12];
    
    [self setOneViewCorner:self.workStartDateBtn];
    [self setOneViewCorner:self.workEndDateBtn];
    [self setOneViewCorner:self.workStartHourBtn];
    [self setOneViewCorner:self.workEndHourBtn];
    
}

- (void)setOneViewCorner:(UIView *)view
{
    view.layer.borderColor = [UIColor colorWithRed:201/255.0 green:201/255.0 blue:201/255.0 alpha:0.5].CGColor;
    view.layer.borderWidth = 0.5;
    view.layer.cornerRadius = 3;
}

- (void)loadTextViewPlaceHolder
{
    self.workContentLabel.text = @"请描述您的工作内容......";
    [self.workContentLabel setFont:[UIFont systemFontOfSize:14]];
    self.workContentLabel.frame = CGRectMake(5, 3, 180, 20);
    [self.workContentTextView addSubview:self.workContentLabel];
    
    self.workSpecialLabel.text = @"请描述您的其它要求......";
    [self.workSpecialLabel setFont:[UIFont systemFontOfSize:14]];
    self.workSpecialLabel.frame = CGRectMake(5, 3, 180, 20);
    [self.workSpecialTextView addSubview:self.workSpecialLabel];
    
    [self.workContentTextView.layer setBorderColor:[UIColor grayColor].CGColor];
    self.workContentTextView.layer.borderWidth = 1;
    self.workContentTextView.layer.cornerRadius = 5;
    self.workContentTextView.delegate = self;
    self.workContentTextView.tag = workContentTag;
    
    [self.workSpecialTextView.layer setBorderColor:[UIColor grayColor].CGColor];
    self.workSpecialTextView.layer.borderWidth = 1;
    self.workSpecialTextView.layer.cornerRadius = 5;
    self.workSpecialTextView.delegate = self;
    self.workSpecialTextView.tag = workSpecialTag;
    
    self.workContentTextView.frame = self.workContentView.bounds;
    self.workSpecialTextView.frame = self.specialView.bounds;
    
    [self.workContentView addSubview:self.workContentTextView];
    [self.specialView addSubview:self.workSpecialTextView];
}

- (void)setButtonsTarget
{
    [self.SettlementTypeBtn addTarget:self action:@selector(SettlementTypeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.SettlementDateBtn addTarget:self action:@selector(SettlementDateBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.jobTypeBtn addTarget:self action:@selector(jobTypeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.isAgentBtn addTarget:self action:@selector(isAgentBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.arrangeRewardBtn addTarget:self action:@selector(arrangeRewardBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.accommodateBtn addTarget:self action:@selector(accommodateBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.workingLunchBtn addTarget:self action:@selector(workingLunchBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.provinceBtn addTarget:self action:@selector(provinceBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.cityBtn addTarget:self action:@selector(cityBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.areaBtn addTarget:self action:@selector(areaBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.workStartDateBtn addTarget:self action:@selector(workStartDateBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.workEndDateBtn addTarget:self action:@selector(workEndDateBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.workStartHourBtn addTarget:self action:@selector(workStartHourBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.workEndHourBtn addTarget:self action:@selector(workEndHourBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.gentderBtn addTarget:self action:@selector(gentderBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.heightBtn addTarget:self action:@selector(heightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.commitBtn addTarget:self action:@selector(commitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.resetBtn addTarget:self action:@selector(resetBtnClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)gentderBtnClick
{
    UIActionSheet *settlementTypeActionSheet = [[UIActionSheet alloc]initWithTitle:@"性别要求" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"不限", @"男", @"女", nil];
    settlementTypeActionSheet.tag = gentderBtnTag;
    
    settlementTypeActionSheet.actionSheetStyle = UIBarStyleDefault;
    [settlementTypeActionSheet showInView:self.view];
}

- (void)heightBtnClick
{
    UIActionSheet *settlementTypeActionSheet = [[UIActionSheet alloc]initWithTitle:@"身高要求" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"不限", @"160cm~170cm", @"170cm~180cm", @"180cm~185cm", @"185cm以上", nil];
    settlementTypeActionSheet.tag = heightBtnTag;
    
    settlementTypeActionSheet.actionSheetStyle = UIBarStyleDefault;
    [settlementTypeActionSheet showInView:self.view];
}

- (void)workStartHourBtnClick
{
    self.clickButtonType = WorkStartHourBtn;
    UIDatePicker *pickerView = [[UIDatePicker alloc]init];
    pickerView.frame = CGRectMake(0, 30, screenFrame.size.width, 162);
    pickerView.datePickerMode = UIDatePickerModeTime;
    
    [self.pickerView addSubview:pickerView];
    self.pickerView.hidden = NO;
    
    [pickerView addTarget:self action:@selector(dateHourPickerChanged:) forControlEvents:UIControlEventValueChanged];
    
    NSDate *  senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"HH:mm"];
    NSString *  locationString=[dateformatter stringFromDate:senddate];
    self.selectItemStr = locationString;
}

- (void)workEndHourBtnClick
{
    self.clickButtonType = WorkEndHourBtn;
    UIDatePicker *pickerView = [[UIDatePicker alloc]init];
    pickerView.frame = CGRectMake(0, 30, screenFrame.size.width, 162);
    pickerView.datePickerMode = UIDatePickerModeTime;
    
    [self.pickerView addSubview:pickerView];
    self.pickerView.hidden = NO;
    
    [pickerView addTarget:self action:@selector(dateHourPickerChanged:) forControlEvents:UIControlEventValueChanged];
    
    NSDate *  senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"HH:mm"];
    NSString *  locationString=[dateformatter stringFromDate:senddate];
    self.selectItemStr = locationString;
}

- (void)dateHourPickerChanged:(id)sender
{
    UIDatePicker *datePicker = (UIDatePicker*)sender;
    NSDate *senddate = datePicker.date;
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"HH:mm"];
    NSString *  locationString=[dateformatter stringFromDate:senddate];
    self.selectItemStr = locationString;
}

- (void)workEndDateBtnClick
{
    self.clickButtonType = WorkEndDateBtn;
    UIDatePicker *pickerView = [[UIDatePicker alloc]init];
    pickerView.frame = CGRectMake(0, 30, screenFrame.size.width, 162);
    pickerView.datePickerMode = UIDatePickerModeDate;
    
    [self.pickerView addSubview:pickerView];
    self.pickerView.hidden = NO;
    
    [pickerView addTarget:self action:@selector(datePickerChanged:) forControlEvents:UIControlEventValueChanged];
    
    NSDate *  senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd"];
    NSString *  locationString=[dateformatter stringFromDate:senddate];
    self.selectItemStr = locationString;
}

- (void)workStartDateBtnClick
{
    self.clickButtonType = WorkStartDateBtn;
    UIDatePicker *pickerView = [[UIDatePicker alloc]init];
    pickerView.frame = CGRectMake(0, 30, screenFrame.size.width, 162);
    pickerView.datePickerMode = UIDatePickerModeDate;
    
    [self.pickerView addSubview:pickerView];
    self.pickerView.hidden = NO;
    
    [pickerView addTarget:self action:@selector(datePickerChanged:) forControlEvents:UIControlEventValueChanged];
    
    NSDate *senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd"];
    NSString *  locationString=[dateformatter stringFromDate:senddate];
    self.selectItemStr = locationString;
}

- (void)datePickerChanged:(id)sender
{
    UIDatePicker *datePicker = (UIDatePicker*)sender;
    NSDate *senddate = datePicker.date;
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd"];
    NSString *  locationString=[dateformatter stringFromDate:senddate];
    self.selectItemStr = locationString;
}

- (void)areaBtnClick
{
    if ([self.provinceBtn.titleLabel.text isEqualToString:@"请选择"]) {
        [MBProgressHUD showError:@"请先选择省份"];
        return;
    }
    if ([self.cityBtn.titleLabel.text isEqualToString:@"请选择"]) {
        [MBProgressHUD showError:@"请先选择城市"];
        return;
    }
    self.clickButtonType = AreaTypeBtn;
    [self.pickerArray removeAllObjects];
    for (SjCity *city in self.cityAreas.cityArry) {
        if ([self.provinceBtn.titleLabel.text isEqualToString:city.provinceName]) {
            for (SjCities *cities in city.citiesArry) {
                if ([self.cityBtn.titleLabel.text isEqualToString:cities.cityName]) {
                    if (cities.cityAreaArry == nil || cities.cityAreaArry.count == 0) {
                        [MBProgressHUD showError:@"该城市暂没有区域开通"];
                        return;
                    }
                    for (Sjarea *area in cities.cityAreaArry) {
                        [self.pickerArray addObject:area.areaName];
                    }
                }
            }
            
        }
    }
    UIPickerView *pickerView = [[UIPickerView alloc]init];
    pickerView.frame = CGRectMake(0, 30, screenFrame.size.width, 162);
    
    
    [self.pickerView addSubview:pickerView];
    self.pickerView.hidden = NO;
    
    pickerView.delegate = self;
    pickerView.dataSource = self;
    self.selectItemStr = self.pickerArray.firstObject;
}

- (void)cityBtnClick
{
    if ([self.provinceBtn.titleLabel.text isEqualToString:@"请选择"]) {
        [MBProgressHUD showError:@"请先选择省份"];
        return;
    }
    [self.areaBtn setTitle:@"请选择" forState:UIControlStateNormal];
    self.clickButtonType = CityTypeBtn;
    [self.pickerArray removeAllObjects];
    for (SjCity *city in self.cityAreas.cityArry) {
        if ([self.provinceBtn.titleLabel.text isEqualToString:city.provinceName]) {
            for (SjCities *cities in city.citiesArry) {
                [self.pickerArray addObject:cities.cityName];
            }
            
        }
    }
    UIPickerView *pickerView = [[UIPickerView alloc]init];
    pickerView.frame = CGRectMake(0, 30, screenFrame.size.width, 162);
    
    
    [self.pickerView addSubview:pickerView];
    self.pickerView.hidden = NO;
    
    pickerView.delegate = self;
    pickerView.dataSource = self;
    self.selectItemStr = self.pickerArray.firstObject;
}

- (void)provinceBtnClick
{
    [self.areaBtn setTitle:@"请选择" forState:UIControlStateNormal];
    [self.cityBtn setTitle:@"请选择" forState:UIControlStateNormal];
    self.clickButtonType = ProvinceTypeBtn;
    [self.pickerArray removeAllObjects];
    for (SjCity *city in self.cityAreas.cityArry) {
        [self.pickerArray addObject:city.provinceName];
    }
    UIPickerView *pickerView = [[UIPickerView alloc]init];
    pickerView.frame = CGRectMake(0, 30, screenFrame.size.width, 162);
    
    
    [self.pickerView addSubview:pickerView];
    self.pickerView.hidden = NO;
    
    pickerView.delegate = self;
    pickerView.dataSource = self;
    self.selectItemStr = self.pickerArray.firstObject;
}

- (void)workingLunchBtnClick
{
    UIActionSheet *settlementTypeActionSheet = [[UIActionSheet alloc]initWithTitle:@"是否提供工作餐" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"是", @"否", nil];
    settlementTypeActionSheet.tag = workingLunchBtnTag;
    
    settlementTypeActionSheet.actionSheetStyle = UIBarStyleDefault;
    [settlementTypeActionSheet showInView:self.view];
}

- (void)accommodateBtnClick
{
    UIActionSheet *settlementTypeActionSheet = [[UIActionSheet alloc]initWithTitle:@"是否提供住宿" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"是", @"否", nil];
    settlementTypeActionSheet.tag = accommodateBtnTag;
    
    settlementTypeActionSheet.actionSheetStyle = UIBarStyleDefault;
    [settlementTypeActionSheet showInView:self.view];
}

- (void)arrangeRewardBtnClick
{
    if ([self.isAgentBtn.titleLabel.text isEqualToString:@"请选择"]) {
        [MBProgressHUD showError:@"请先选择是否包办"];
        return;
    }
    UIActionSheet *settlementTypeActionSheet = [[UIActionSheet alloc]initWithTitle:@"包办奖励" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"5元/人", @"8元/人", @"10元/人", nil];
    settlementTypeActionSheet.tag = arrangeRewardBtnTag;
    
    settlementTypeActionSheet.actionSheetStyle = UIBarStyleDefault;
    [settlementTypeActionSheet showInView:self.view];
}

- (void)isAgentBtnClick
{
    UIActionSheet *settlementTypeActionSheet = [[UIActionSheet alloc]initWithTitle:@"是否包办" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"包办", @"非包办", nil];
    settlementTypeActionSheet.tag = isAgentBtnTag;
    
    settlementTypeActionSheet.actionSheetStyle = UIBarStyleDefault;
    [settlementTypeActionSheet showInView:self.view];
}

- (void)jobTypeBtnClick
{
    self.clickButtonType = JobTypeBtn;
    [self.pickerArray removeAllObjects];
    [self.pickerArray addObjectsFromArray: self.cityAreas.jobTypeNameArry];
    UIPickerView *pickerView = [[UIPickerView alloc]init];
    pickerView.frame = CGRectMake(0, 30, screenFrame.size.width, 162);
    
    
    [self.pickerView addSubview:pickerView];
    self.pickerView.hidden = NO;
    
    pickerView.delegate = self;
    pickerView.dataSource = self;
    self.selectItemStr = self.pickerArray.firstObject;
}

- (void)SettlementTypeBtnClick
{
//    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"test" message:@"message" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"1", @"2",@"3", @"4",@"5", @"6",@"7", @"8",@"9", @"10",@"11",@"12",@"13", nil];
////    CGRect myRect = alertView.frame;
////    myRect.size.height = 100;
////    alertView.frame = myRect;
//    alertView.frame = CGRectMake(50, 50, 100, 100);
//    [alertView show];
//    return;
    
    
    UIActionSheet *settlementTypeActionSheet = [[UIActionSheet alloc]initWithTitle:@"结算方式" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"日结", @"周结", @"月结", @"完工结", nil];
    settlementTypeActionSheet.tag = SettlementTypeBtnTag;
    
    settlementTypeActionSheet.actionSheetStyle = UIBarStyleDefault;
    [settlementTypeActionSheet showInView:self.view];
}

- (void)willPresentAlertView:(UIAlertView *)alertView
{
    alertView.frame = CGRectMake(50, 50, 100, 100);
}

- (void)SettlementDateBtnClick
{
    self.clickButtonType = SettlementTypeBtn;
    if ([self.SettlementTypeBtn.titleLabel.text isEqualToString:@"请选择"]) {
        [MBProgressHUD showError:@"请先选择结算方式"];
        return;
    }
    UIPickerView *pickerView = [[UIPickerView alloc]init];
    pickerView.frame = CGRectMake(0, 30, screenFrame.size.width, 162);
    
    
    [self.pickerView addSubview:pickerView];
    self.pickerView.hidden = NO;
    
    pickerView.delegate = self;
    pickerView.dataSource = self;
    self.selectItemStr = self.pickerArray.firstObject;
}

#pragma textViewDelegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (textView.tag == workContentTag) {
        if (![text isEqualToString:@""])
        {
            self.workContentLabel.hidden = YES;
        }
        if ([text isEqualToString:@""] && range.location == 0 && range.length == 1)
        {
            self.workContentLabel.hidden = NO;
        }
    }
    
    if (textView.tag == workSpecialTag) {
        if (![text isEqualToString:@""])
        {
            self.workSpecialLabel.hidden = YES;
        }
        if ([text isEqualToString:@""] && range.location == 0 && range.length == 1)
        {
            self.workSpecialLabel.hidden = NO;
        }
    }
    
    return YES;
}

#pragma actionSheet

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *selectTitle = [NSString string];
    if (actionSheet.tag == SettlementTypeBtnTag) {
        if (buttonIndex == 0) {
            selectTitle = @"日结";
            self.SettlementDateL.hidden = YES;
            self.View2.hidden = YES;
        }
        else if(buttonIndex == 1)
        {
            selectTitle = @"周结";
            self.SettlementDateL.hidden = NO;
            self.View2.hidden = NO;
            [self.pickerArray removeAllObjects];
            [self.pickerArray addObjectsFromArray:@[@"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六"]];
        }
        else if(buttonIndex == 2)
        {
            selectTitle = @"月结";
            self.SettlementDateL.hidden = NO;
            self.View2.hidden = NO;
            [self.pickerArray removeAllObjects];
            [self.pickerArray addObjectsFromArray:@[@"1日", @"2日", @"3日", @"4日", @"5日", @"6日", @"7日", @"8日", @"9日", @"10日", @"11日", @"12日", @"13日", @"14日", @"15日", @"16日", @"17日", @"18日", @"19日", @"20日", @"21日", @"22日", @"23日", @"24日", @"25日", @"26日", @"27日", @"28日", @"29日", @"30日", @"31日"]];
        }
        else if(buttonIndex == 3)
        {
            selectTitle = @"完工结";
            self.SettlementDateL.hidden = YES;
            self.View2.hidden = YES;
        }
        else
        {
            selectTitle = self.SettlementTypeBtn.titleLabel.text;
            self.SettlementDateL.hidden = YES;
            self.View2.hidden = YES;
        }
        [self.SettlementTypeBtn setTitle:selectTitle forState:UIControlStateNormal];
        [self.SettlementDateBtn setTitle:@"请选择" forState:UIControlStateNormal];
    }
    else if(actionSheet.tag == isAgentBtnTag)
    {
        if (buttonIndex == 0) {
            [self.isAgentBtn setTitle:@"包办" forState:UIControlStateNormal];
            self.View5.hidden = NO;
            self.arrangeRewardL.hidden = NO;
        }
        else if(buttonIndex == 1)
        {
            [self.isAgentBtn setTitle:@"非包办" forState:UIControlStateNormal];
            self.View5.hidden = YES;
            self.arrangeRewardL.hidden = YES;
        }
    }
    else if (actionSheet.tag == arrangeRewardBtnTag)
    {
        if (buttonIndex == 0) {
            [self.arrangeRewardBtn setTitle:@"5元/人" forState:UIControlStateNormal];
        }
        else if(buttonIndex == 1)
        {
            [self.arrangeRewardBtn setTitle:@"8元/人" forState:UIControlStateNormal];
        }
        else if(buttonIndex == 2)
        {
            [self.arrangeRewardBtn setTitle:@"10元/人" forState:UIControlStateNormal];
        }
    }
    else if (actionSheet.tag == accommodateBtnTag)
    {
        if (buttonIndex == 0) {
            [self.accommodateBtn setTitle:@"是" forState:UIControlStateNormal];
        }
        else if(buttonIndex == 1)
        {
            [self.accommodateBtn setTitle:@"否" forState:UIControlStateNormal];
        }
    }
    else if (actionSheet.tag == workingLunchBtnTag)
    {
        if (buttonIndex == 0) {
            [self.workingLunchBtn setTitle:@"是" forState:UIControlStateNormal];
        }
        else if(buttonIndex == 1)
        {
            [self.workingLunchBtn setTitle:@"否" forState:UIControlStateNormal];
        }
    }
    else if (actionSheet.tag == gentderBtnTag)
    {
        if (buttonIndex == 0) {
            [self.gentderBtn setTitle:@"不限" forState:UIControlStateNormal];
        }
        else if(buttonIndex == 1)
        {
            [self.gentderBtn setTitle:@"男" forState:UIControlStateNormal];
        }
        else if(buttonIndex == 1)
        {
            [self.gentderBtn setTitle:@"女" forState:UIControlStateNormal];
        }
    }
    else if (actionSheet.tag == heightBtnTag)
    {
        if (buttonIndex == 0) {
            [self.heightBtn setTitle:@"不限" forState:UIControlStateNormal];
        }
        else if(buttonIndex == 1)
        {
            [self.heightBtn setTitle:@"160cm~170cm" forState:UIControlStateNormal];
        }
        else if(buttonIndex == 2)
        {
            [self.heightBtn setTitle:@"170cm~180cm" forState:UIControlStateNormal];
        }
        else if(buttonIndex == 3)
        {
            [self.heightBtn setTitle:@"180cm~185cm" forState:UIControlStateNormal];
        }
        else if(buttonIndex == 4)
        {
            [self.heightBtn setTitle:@"185cm以上" forState:UIControlStateNormal];
        }
    }
}

#pragma pickerViewDelegate
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.pickerArray.count;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.pickerArray[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.selectItemStr = self.pickerArray[row];
}

- (void)commitBtnClick
{
    if (![self checkInfoIsValid]) {
        return;
    }
//    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
//    mgr.requestSerializer = [AFHTTPRequestSerializer serializer];
//    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    //application/json
    // 2.拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"name"] = self.nameL.text;
    params[@"recruitNum"] = self.recruitNumL.text;
    if ([self.SettlementTypeBtn.titleLabel.text isEqual:@"日结"]) {
        params[@"settlementPeriod"] = @"day";
    }
    else if([self.SettlementTypeBtn.titleLabel.text isEqual:@"周结"]) {
        params[@"settlementPeriod"] = @"week";
        if ([self.SettlementDateBtn.titleLabel.text isEqualToString:@"周一"]) {
            params[@"accountDay"] = @"1";
        }
        else if ([self.SettlementDateBtn.titleLabel.text isEqualToString:@"周二"]){
            params[@"accountDay"] = @"2";
        }
        else if ([self.SettlementDateBtn.titleLabel.text isEqualToString:@"周三"]){
            params[@"accountDay"] = @"3";
        }
        else if ([self.SettlementDateBtn.titleLabel.text isEqualToString:@"周四"]){
            params[@"accountDay"] = @"4";
        }
        else if ([self.SettlementDateBtn.titleLabel.text isEqualToString:@"周五"]){
            params[@"accountDay"] = @"5";
        }
        else if ([self.SettlementDateBtn.titleLabel.text isEqualToString:@"周六"]){
            params[@"accountDay"] = @"6";
        }
        else if ([self.SettlementDateBtn.titleLabel.text isEqualToString:@"周日"]){
            params[@"accountDay"] = @"7";
        }
    }
    else if([self.SettlementTypeBtn.titleLabel.text isEqual:@"月结"]) {
        params[@"settlementPeriod"] = @"month";
        NSString *dateStr = self.SettlementDateBtn.titleLabel.text;
        NSRange range = [dateStr rangeOfString:@"日"];
        if (range.location != NSNotFound)
        {
            NSString *settlementDateStr = [dateStr substringToIndex:range.location];
            params[@"accountDay"] = settlementDateStr;
        }
    }
    else if([self.SettlementTypeBtn.titleLabel.text isEqual:@"完工结"]) {
        params[@"settlementPeriod"] = @"end";
    }
    
    params[@"salary"] = self.salaryL.text;
    
    for (int i = 0; i<self.cityAreas.jobTypeNameArry.count; i++) {
        if ([self.jobTypeBtn.titleLabel.text isEqualToString:self.cityAreas.jobTypeNameArry[i]]) {
            params[@"jobTypeId"] = self.cityAreas.jobTypeIdArry[i];
        }
    }
    
    if ([self.isAgentBtn.titleLabel.text isEqualToString:@"包办"]) {
        params[@"isAgent"] = @"1";
    }
    else
    {
        params[@"isAgent"] = @"0";
    }
    if ([self.arrangeRewardBtn.titleLabel.text isEqualToString:@"5元/人"]) {
        params[@"arrangedReward"] = @"5";
    }
    else if ([self.arrangeRewardBtn.titleLabel.text isEqualToString:@"8元/人"]) {
        params[@"arrangedReward"] = @"8";
    }
    else if ([self.arrangeRewardBtn.titleLabel.text isEqualToString:@"10元/人"]) {
        params[@"arrangedReward"] = @"10";
    }
    if ([self.accommodateBtn.titleLabel.text isEqualToString:@"是"]) {
        params[@"isProvideStay"] = @"1";
    }
    else
    {
        params[@"isProvideStay"] = @"0";
    }
    if ([self.workingLunchBtn.titleLabel.text isEqualToString:@"是"]) {
        params[@"isProvideMeal"] = @"1";
    }
    else
    {
        params[@"isProvideMeal"] = @"0";
    }
    for (int i=0; i<self.cityAreas.cityArry.count; i++) {
        SjCity *city = self.cityAreas.cityArry[i];
        if ([self.provinceBtn.titleLabel.text isEqualToString:city.provinceName]) {
            params[@"provinceId"] = city.provinceId;
        }
        for (int j=0; j<city.citiesArry.count; j++) {
            SjCities *cities = city.citiesArry[j];
            if ([self.cityBtn.titleLabel.text isEqualToString:cities.cityName]) {
                params[@"cityId"] = cities.cityId;
            }
            for (int k=0; k<cities.cityAreaArry.count; k++) {
                Sjarea *area = cities.cityAreaArry[k];
                if ([self.areaBtn.titleLabel.text isEqualToString:area.areaName]) {
                    params[@"areaId"] = area.areaId;
                }
            }
        }
    }
    
    params[@"address"] = self.addressTextField.text;
    params[@"workingStartDate"] = self.workStartDateBtn.titleLabel.text;
    params[@"workingEndDate"] = self.workEndDateBtn.titleLabel.text;
    params[@"workingHours"] = [NSString stringWithFormat:@"%@-%@", self.workStartHourBtn.titleLabel.text, self.workEndHourBtn.titleLabel.text];
    params[@"workContent"] = self.workContentTextView.text;
    if([self.gentderBtn.titleLabel.text isEqualToString:@"不限"])
    {
        params[@"genderLimit"] = @"n";
    }
    else if ([self.gentderBtn.titleLabel.text isEqualToString:@"男"])
    {
        params[@"genderLimit"] = @"m";
    }
    else if ([self.gentderBtn.titleLabel.text isEqualToString:@"女"])
    {
        params[@"genderLimit"] = @"f";
    }
    
    params[@"heightLimit"] = self.heightBtn.titleLabel.text;
    params[@"specialRequired"] = self.workSpecialTextView.text;
    params[@"companyId"] = sjGlobalSessionId;
    if (self.oneJobInfo == nil) {
        params[@"jobId"] = @"";
    }
    else
    {
        params[@"jobId"] = self.oneJobInfo.jobId;
    }
    params[@"contactPerson"] = self.contactL.text;
    params[@"contactNumber"] = self.telephoneL.text;
    
//    AFHTTPRequestOperation *response = [mgr POST:[NSString stringWithFormat:@"%@/web/enterprise/saveJob4App", sjIp] parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//    } success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
//        
//        //NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        if (self.oneJobInfo != nil) {
//            [MBProgressHUD showSuccess:@"修改职位成功"];
//        }
//        else
//        {
//            [MBProgressHUD showSuccess:@"发布职位成功"];
//        }
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//        if (self.oneJobInfo != nil) {
//            [MBProgressHUD showError:@"修改职位失败"];
//        }
//        else
//        {
//            [MBProgressHUD showError:@"发布职位失败"];
//        }
//        
//    }];
    
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/web/enterprise/saveJob4App", sjIp]];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:URL];
    request.timeoutInterval=5.0;//设置请求超时为5秒
    request.HTTPMethod=@"POST";//设置请求方法

    NSMutableString *strM = [NSMutableString string];
    for (NSString *key in [params allKeys]) {
        NSString *str = [NSString stringWithFormat:@"%@=%@&", key, params[key]];
        [strM appendString:str];
    }
    //设置请求体
    NSString *param=strM;
    //把拼接后的字符串转换为data，设置请求体
    request.HTTPBody=[param dataUsingEncoding:NSUTF8StringEncoding];

    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    if ([str isEqual:@"\"success\""]) {
        if (self.oneJobInfo != nil) {
            [MBProgressHUD showSuccess:@"修改职位成功"];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        else
        {
            [MBProgressHUD showSuccess:@"发布职位成功"];
            [self resetBtnClick];
        }
        self.tabBarController.selectedViewController = self.tabBarController.viewControllers.firstObject;
    }
    else if ([str isEqual:@"\"address_error\""])
    {
        [MBProgressHUD showError:@"工作地址填写错误"];
    }
    else
    {
        if (self.oneJobInfo != nil) {
            [MBProgressHUD showError:[NSString stringWithFormat:@"修改职位失败"]];
        }
        else
        {
            [MBProgressHUD showError:[NSString stringWithFormat:@"发布职位失败"]];
        }
    }
    
}

- (BOOL)checkInfoIsValid
{
    if (![self.userDoc.complete isEqualToString:@"1"]) {
        return NO;
    }
    
    if ([self.nameL.text isEqualToString:@" "] || self.nameL.text.length == 0) {
        [MBProgressHUD showError:@"请填写职位名称"];
        [self.nameL becomeFirstResponder];
        return NO;
    }
    if ([self.recruitNumL.text isEqualToString:@" "] || self.recruitNumL.text.length == 0) {
        [MBProgressHUD showError:@"请填写招聘人数"];
        [self.recruitNumL becomeFirstResponder];
        return NO;
    }
    if ([self.SettlementTypeBtn.titleLabel.text isEqualToString:@"请选择"]) {
        [MBProgressHUD showError:@"请选择结算方式"];
        return NO;
    }
    if (([self.SettlementTypeBtn.titleLabel.text isEqualToString:@"周结"] || [self.SettlementTypeBtn.titleLabel.text isEqualToString:@"月结"]) && [self.SettlementDateBtn.titleLabel.text isEqualToString:@"请选择"]) {
        [MBProgressHUD showError:@"请选择结算日期"];
        return NO;
    }
    if ([self.salaryL.text isEqualToString:@" "] || self.salaryL.text.length == 0) {
        [MBProgressHUD showError:@"请填写工作薪酬"];
        [self.salaryL becomeFirstResponder];
        return NO;
    }
    if ([self.jobTypeBtn.titleLabel.text isEqualToString:@"请选择"]) {
        [MBProgressHUD showError:@"请选择职位类型"];
        return NO;
    }
    if ([self.isAgentBtn.titleLabel.text isEqualToString:@"请选择"]) {
        [MBProgressHUD showError:@"请选择是否包办"];
        return NO;
    }
    if ([self.isAgentBtn.titleLabel.text isEqualToString:@"包办"] && [self.arrangeRewardBtn.titleLabel.text isEqualToString:@"请选择"]) {
        [MBProgressHUD showError:@"请选择包办奖励"];
        return NO;
    }
    if ([self.provinceBtn.titleLabel.text isEqualToString:@"请选择"]) {
        [MBProgressHUD showError:@"请选择所在省份"];
        return NO;
    }
    if ([self.cityBtn.titleLabel.text isEqualToString:@"请选择"]) {
        [MBProgressHUD showError:@"请选择所在城市"];
        return NO;
    }
    if ([self.areaBtn.titleLabel.text isEqualToString:@"请选择"]) {
        [MBProgressHUD showError:@"请选择所在区域"];
        return NO;
    }
    if ([self.addressTextField.text isEqualToString:@" "] || self.addressTextField.text.length == 0) {
        [MBProgressHUD showError:@"请填写详细地址"];
        return NO;
    }
    if ([self.workStartDateBtn.titleLabel.text isEqualToString:@"开始日期"]) {
        [MBProgressHUD showError:@"请选择开始日期"];
        return NO;
    }
    if ([self.workEndDateBtn.titleLabel.text isEqualToString:@"结束日期"]) {
        [MBProgressHUD showError:@"请选择结束日期"];
        return NO;
    }
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd"];
    NSDate *dt1 = [[NSDate alloc] init];
    NSDate *dt2 = [[NSDate alloc] init];
    dt1 = [df dateFromString:self.workStartDateBtn.titleLabel.text];
    dt2 = [df dateFromString:self.workEndDateBtn.titleLabel.text];
    NSComparisonResult result = [dt1 compare:dt2];
    if (result == NSOrderedDescending) {
        [MBProgressHUD showError:@"开始日期不能晚于结束日期"];
        return NO;
    }
    
    if ([self.workStartHourBtn.titleLabel.text isEqualToString:@"开始时间"]) {
        [MBProgressHUD showError:@"请选择开始时间"];
        return NO;
    }
    if ([self.workEndHourBtn.titleLabel.text isEqualToString:@"结束时间"]) {
        [MBProgressHUD showError:@"请选择结束时间"];
        return NO;
    }
    
    NSDateFormatter *df2 = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"HH:mm"];
    NSDate *dt3 = [[NSDate alloc] init];
    NSDate *dt4 = [[NSDate alloc] init];
    dt3 = [df2 dateFromString:self.workStartHourBtn.titleLabel.text];
    dt4 = [df2 dateFromString:self.workEndHourBtn.titleLabel.text];
    NSComparisonResult result2 = [dt3 compare:dt4];
    if (result2 == NSOrderedDescending) {
        [MBProgressHUD showError:@"开始时间不能晚于结束时间"];
        return NO;
    }
    
    if ([self.workContentTextView.text isEqualToString:@" "] || self.workContentTextView.text.length == 0) {
        [MBProgressHUD showError:@"请填写工作内容"];
        return NO;
    }
    
    if ([self.contactL.text isEqualToString:@" "] || self.contactL.text.length == 0) {
        [MBProgressHUD showError:@"请完善个人资料的联系人"];
        return NO;
    }
    if ([self.telephoneL.text isEqualToString:@" "] || self.telephoneL.text.length == 0) {
        [MBProgressHUD showError:@"请完善个人资料的电话"];
        return NO;
    }
    
//    if ([self.workSpecialTextView.text isEqualToString:@" "] || self.workSpecialTextView.text.length == 0) {
//        [MBProgressHUD showError:@"请填其它要求"];
//        return NO;
//    }
    
    return YES;
}

- (void)resetBtnClick
{
    self.nameL.text = @"";
    self.recruitNumL.text = @"";
    [self.SettlementTypeBtn setTitle:@"请选择" forState:UIControlStateNormal];
    [self.SettlementDateBtn setTitle:@"请选择" forState:UIControlStateNormal];
    self.salaryL.text = @"";
    [self.jobTypeBtn setTitle:@"请选择" forState:UIControlStateNormal];
    [self.isAgentBtn setTitle:@"请选择" forState:UIControlStateNormal];
    [self.arrangeRewardBtn setTitle:@"请选择" forState:UIControlStateNormal];
    [self.accommodateBtn setTitle:@"否" forState:UIControlStateNormal];
    [self.workingLunchBtn setTitle:@"否" forState:UIControlStateNormal];
    [self.provinceBtn setTitle:@"请选择" forState:UIControlStateNormal];
    [self.cityBtn setTitle:@"请选择" forState:UIControlStateNormal];
    [self.areaBtn setTitle:@"请选择" forState:UIControlStateNormal];
    [self.workStartDateBtn setTitle:@"开始日期" forState:UIControlStateNormal];
    [self.workEndDateBtn setTitle:@"结束日期" forState:UIControlStateNormal];
    [self.workStartHourBtn setTitle:@"开始时间" forState:UIControlStateNormal];
    [self.workEndHourBtn setTitle:@"结束时间" forState:UIControlStateNormal];
    [self.gentderBtn setTitle:@"不限" forState:UIControlStateNormal];
    [self.heightBtn setTitle:@"不限" forState:UIControlStateNormal];
    self.addressTextField.text = @"";
    self.workContentTextView.text = @"";
    self.workSpecialTextView.text = @"";
}

- (void)loadOneJobInfo
{
    self.nameL.text = self.oneJobInfo.name;
    self.recruitNumL.text = [NSString stringWithFormat:@"%d", self.oneJobInfo.recruitNum];
    [self.SettlementTypeBtn setTitle:self.oneJobInfo.settlementPeriod forState:UIControlStateNormal];
    if ([self.oneJobInfo.settlementPeriod isEqualToString:@"周结"] || [self.oneJobInfo.settlementPeriod isEqualToString:@"月结"]) {
        [self.SettlementDateBtn setTitle:self.oneJobInfo.accountDay forState:UIControlStateNormal];
    }
    else
    {
        self.View2.hidden = YES;
        self.SettlementDateL.hidden = YES;
    }
    self.salaryL.text = [NSString stringWithFormat:@"%d", self.oneJobInfo.salary];
    [self.jobTypeBtn setTitle:self.oneJobInfo.jobType forState:UIControlStateNormal];
    [self.isAgentBtn setTitle:self.oneJobInfo.isAgent forState:UIControlStateNormal];
    if ([self.isAgentBtn.titleLabel.text isEqualToString:@"包办"]) {
        [self.arrangeRewardBtn setTitle:[NSString stringWithFormat:@"%d元/人", self.oneJobInfo.arrangedReward] forState:UIControlStateNormal];
    }
    else
    {
        self.arrangeRewardL.hidden = YES;
        self.View5.hidden = YES;
    }
    
    [self.accommodateBtn setTitle:self.oneJobInfo.isProvideStay forState:UIControlStateNormal];
    [self.workingLunchBtn setTitle:self.oneJobInfo.isProvideMeal forState:UIControlStateNormal];
    [self.provinceBtn setTitle:self.oneJobInfo.province forState:UIControlStateNormal];
    [self.cityBtn setTitle:self.oneJobInfo.city forState:UIControlStateNormal];
    [self.areaBtn setTitle:self.oneJobInfo.area forState:UIControlStateNormal];
    self.addressTextField.text = self.oneJobInfo.address;
    [self.workStartDateBtn setTitle:self.oneJobInfo.workingStartDate forState:UIControlStateNormal];
    self.workStartDateBtn.userInteractionEnabled = NO;
    [self.workEndDateBtn setTitle:self.oneJobInfo.workingEndDate forState:UIControlStateNormal];
    self.workEndDateBtn.userInteractionEnabled = NO;
    [self.workStartHourBtn setTitle:[self.oneJobInfo.workingHours substringToIndex:5] forState:UIControlStateNormal];
    [self.workEndHourBtn setTitle:[self.oneJobInfo.workingHours substringFromIndex:6] forState:UIControlStateNormal];
    self.workContentTextView.text = self.oneJobInfo.workContent;
    self.workContentLabel.hidden = YES;
    [self.gentderBtn setTitle:self.oneJobInfo.genderLimit forState:UIControlStateNormal];
    [self.heightBtn setTitle:self.oneJobInfo.heightLimit forState:UIControlStateNormal];
    self.workSpecialTextView.text = self.oneJobInfo.specialRequired;
    self.workSpecialLabel.hidden = YES;
    self.contactL.text = self.oneJobInfo.contactP;
    self.telephoneL.text = self.oneJobInfo.contactT;
    
    self.resetBtn.hidden = YES;
    self.commitBtn.hidden = YES;

    UIButton *modifyBtn = [[UIButton alloc]init];
    modifyBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [modifyBtn setTitle:@"修改" forState:UIControlStateNormal];
    modifyBtn.backgroundColor = [UIColor colorWithRed:0/255.0 green:152/255.0 blue:209/255.0 alpha:1.0];
    [modifyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    modifyBtn.frame = CGRectMake(40, self.commitBtn.frame.origin.y, screenFrame.size.width-80, 30);
    [self.scrollContentView addSubview:modifyBtn];
    [modifyBtn addTarget:self action:@selector(commitBtnClick) forControlEvents:UIControlEventTouchUpInside];
}
@end
