//
//  SjProfileModifyMyDocViewController.m
//  yz-student
//
//  Created by 仲光磊 on 15/11/2.
//  Copyright © 2015年 cdq. All rights reserved.
//

#import "SjProfileModifyMyDocViewController.h"
#import "StuConfig.h"
#import "SjJobIndustry.h"
#import "SjUserDoc.h"
#import "UIImageView+WebCache.h"
#import "MBProgressHUD+MJ.h"

#define pickerViewH 192

#define sjTypeAlertViewTag 1000
#define sjAttributeAlertViewTag 1001
#define sjScaleAlertViewTag 1002

extern NSString *sjGlobalSessionId;

@interface SjProfileModifyMyDocViewController ()<UITextViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UIAlertViewDelegate>

@property(nonatomic, strong)NSMutableArray *pickerArray;
@property(nonatomic, strong)UIView *pickerView;

@property(nonatomic, strong)UILabel *sjBriefLabel;
@property(nonatomic, strong)UITextView *sjBriefTextView;
@property(nonatomic, strong)UIPickerView *onePickerView;
@property(nonatomic, copy)NSString *selectItemStr;
@property(nonatomic, strong)NSArray *IndustryArray;

@property(nonatomic, assign)CGFloat sjAllureY;

@end

@implementation SjProfileModifyMyDocViewController

- (NSArray *)IndustryArray
{
    if (_IndustryArray == nil) {
        _IndustryArray = [NSArray array];
    }
    return _IndustryArray;
}

- (UIPickerView *)onePickerView
{
    if (_onePickerView == nil) {
        _onePickerView = [[UIPickerView alloc]init];
        _onePickerView.frame = CGRectMake(0, 30, screenFrame.size.width, 162);
    }
    return _onePickerView;
}

- (UIView *)pickerView
{
    if (_pickerView == nil) {
        _pickerView = [[UIView alloc]init];
        _pickerView.hidden = YES;
        [_pickerView addSubview:self.onePickerView];
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

- (UILabel *)sjBriefLabel
{
    if (_sjBriefLabel == nil) {
        _sjBriefLabel = [[UILabel alloc]init];
    }
    return _sjBriefLabel;
}

- (UITextView *)sjBriefTextView
{
    if (_sjBriefTextView == nil) {
        _sjBriefTextView = [[UITextView alloc]init];
    }
    return _sjBriefTextView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"完善资料";
    
    [self setAllViewBorder];
    [self loadTextViewPlaceHolder];
    self.onePickerView.delegate = self;
    self.onePickerView.dataSource = self;
    
    [self loadPickerArry];
    [self addAllBtnTarget];
    [self loadPickerView];
    [self loadOldInfo];
    
    self.sjAllAllureScrollView.layer.borderColor = [UIColor colorWithRed:201/255.0 green:201/255.0 blue:201/255.0 alpha:0.5].CGColor;
    self.sjAllAllureScrollView.layer.borderWidth = 0.5;
    self.sjAllAllureScrollView.backgroundColor = [UIColor whiteColor];
    
    
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(viewDismissKeyboard)];
    [self.view addGestureRecognizer:singleFingerTap];
}

- (void)viewDismissKeyboard
{
    [self.view endEditing:YES];
}

- (void)loadOldInfo
{
    SjUserDoc *doc = [SjUserDoc sjUserDocWithSessionId:sjGlobalSessionId];
    self.sjNameTF.text = doc.name;
    
    if (doc.logoImage !=nil && doc.logoImage.length != 0) {
        UIImageView *imgView = [[UIImageView alloc]init];
        [imgView sd_setImageWithURL:[NSURL URLWithString:doc.logoImage] placeholderImage:[UIImage imageNamed:@"icon_empty"]];
        [self.sjLogoBtn setBackgroundImage:imgView.image forState:UIControlStateNormal];
        [self.sjLogoBtn setTitle:@"" forState:UIControlStateNormal];
        self.sjLogoBtn.userInteractionEnabled = NO;
    }
    
    if (doc.brifIntrodution != nil && doc.brifIntrodution.length !=0) {
        self.sjBriefLabel.hidden = YES;
        self.sjBriefTextView.text = doc.brifIntrodution;
    }
    if(doc.scale != nil && doc.scale.length !=0)
    {
       [self.sjScaleBtn setTitle:doc.scale forState:UIControlStateNormal];
    }
    if(doc.industry != nil && doc.industry.length !=0)
    {
        [self.sjIndustyBtn setTitle:doc.industry forState:UIControlStateNormal];
    }
    if(doc.attribute != nil && doc.attribute.length !=0)
    {
        [self.sjAttributeBtn setTitle:doc.attribute forState:UIControlStateNormal];
    }
    if(doc.type != nil && doc.type.length !=0)
    {
        [self.sjTypeBtn setTitle:doc.type forState:UIControlStateNormal];
    }
    
    self.sjContactP.text = doc.contactPerson;
    self.sjContactT.text = doc.contactNumber;
    self.sjEmail.text = doc.email;
    self.sjHomePage.text = doc.homePage;
    self.sjAddress.text = doc.address;
    
    for (NSString *str in doc.labelsArry) {
        if(str.length != 0)
        {
            [self sjAddOneAllureBtn:str];
        }
    }
}

- (void)addAllBtnTarget
{
    [self.sjLogoBtn addTarget:self action:@selector(sjLogoBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.sjIndustyBtn addTarget:self action:@selector(sjIndustyBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.sjTypeBtn addTarget:self action:@selector(sjTypeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.sjAttributeBtn addTarget:self action:@selector(sjAttributeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.sjScaleBtn addTarget:self action:@selector(sjScaleBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.sjAddAllureBtn addTarget:self action:@selector(sjAddAllureBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.sjCommitBtn addTarget:self action:@selector(commitBtnClick) forControlEvents:UIControlEventTouchUpInside];
}

//添加一条商家诱惑
- (void)sjAddAllureBtnClick
{
    if (self.sjAllureTextField.text.length == 0 || [self.sjAllureTextField.text isEqualToString:@""]) {
        return;
    }
    [self sjAddOneAllureBtn:self.sjAllureTextField.text];
    
    self.sjAllureTextField.text = @"";
}

- (void)sjAddOneAllureBtn:(NSString*)str
{
    UIButton *btn = [[UIButton alloc]init];
    btn.backgroundColor = [UIColor colorWithRed:205/255.0 green:230/255.0 blue:156/255.0 alpha:0.8];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [btn setTitle:str forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(sjOneAllureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    NSDictionary *dict = @{NSFontAttributeName: [UIFont systemFontOfSize:14]};
    NSStringDrawingOptions options = NSStringDrawingTruncatesLastVisibleLine |
    NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    
    CGSize btnSize = [str boundingRectWithSize:CGSizeMake(screenFrame.size.width-50, MAXFLOAT) options: options attributes:dict context:nil].size;
    
    btn.frame = CGRectMake(10, self.sjAllureY+3, btnSize.width+10, btnSize.height+5);
    self.sjAllureY = CGRectGetMaxY(btn.frame);
    self.sjAllAllureScrollView.contentSize = CGSizeMake(btn.frame.size.width, self.sjAllureY);
    btn.titleLabel.numberOfLines = 0;
    
    [self.sjAllAllureScrollView addSubview:btn];
}

- (void)sjOneAllureBtnClick:(UIButton*)btn
{
    [btn removeFromSuperview];
    self.sjAllureY = 0;
    for (UIView *view in self.sjAllAllureScrollView.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *btnTmp = (UIButton*)view;
            
            btnTmp.frame = CGRectMake(10, self.sjAllureY+3, btnTmp.frame.size.width, btnTmp.frame.size.height);
            self.sjAllureY = CGRectGetMaxY(btnTmp.frame);
        }
    }
}

//完成按钮
- (void)buttonItemClick
{
    [self.sjIndustyBtn setTitle:self.selectItemStr forState:UIControlStateNormal];
    
    self.pickerView.hidden = YES;
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

- (void)sjLogoBtnClick
{
    
}

- (void)loadPickerArry
{
    if (self.pickerArray.count == 0) {
        NSArray *arry = [SjJobIndustry jobIndustryFromNet];
        self.IndustryArray = arry;
        NSMutableArray *arryM = [NSMutableArray array];
        for (SjJobIndustry *industry in arry) {
            [arryM addObject:industry.industryName];
        }
        [arryM addObject:@"取消"];
        if (arry != nil && arry.count > 0) {
            [self.pickerArray addObjectsFromArray:arryM];
        }
    }
}

- (void)sjIndustyBtnClick
{
    self.pickerView.hidden = NO;
    self.selectItemStr = self.pickerArray.firstObject;
}

- (void)sjTypeBtnClick
{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"商家类型" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"商家", @"个人",@"取消", nil];
    alertView.tag = sjTypeAlertViewTag;
    
    [alertView show];
}

- (void)sjAttributeBtnClick
{
    //商家属性
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"商家属性" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"国有企业", @"合资企业",@"集体企业",@"私营企业",@"取消", nil];
    alertView.tag = sjAttributeAlertViewTag;
    
    [alertView show];
}

- (void)sjScaleBtnClick
{
    //sjScaleAlertViewTag
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"商家规模" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"20人以下", @"21人至50人",@"51人至100人",@"101人以上",@"取消", nil];
    alertView.tag = sjScaleAlertViewTag;
    
    [alertView show];
}

- (void)loadTextViewPlaceHolder
{
    self.sjBriefLabel.text = @"请描述商家简介......";
    [self.sjBriefLabel setFont:[UIFont systemFontOfSize:14]];
    self.sjBriefLabel.frame = CGRectMake(5, 3, 180, 20);
    [self.sjBriefTextView addSubview:self.sjBriefLabel];
    
    [self.sjBriefTextView.layer setBorderColor:[UIColor grayColor].CGColor];
    self.sjBriefTextView.layer.borderWidth = 1;
    self.sjBriefTextView.layer.cornerRadius = 5;
    self.sjBriefTextView.delegate = self;

    self.sjBriefTextView.frame = self.sjBriefView.bounds;
    [self.sjBriefView addSubview:self.sjBriefTextView];
}

- (void)setAllViewBorder
{
    [self setOneViewCorner:self.view1];
    [self setOneViewCorner:self.view2];
    [self setOneViewCorner:self.view3];
    [self setOneViewCorner:self.view4];
}

- (void)setOneViewCorner:(UIView *)view
{
    view.layer.borderColor = [UIColor colorWithRed:201/255.0 green:201/255.0 blue:201/255.0 alpha:0.5].CGColor;
    view.layer.borderWidth = 0.5;
    view.layer.cornerRadius = 3;
}

#pragma textViewDelegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (![text isEqualToString:@""])
    {
        self.sjBriefLabel.hidden = YES;
    }
    if ([text isEqualToString:@""] && range.location == 0 && range.length == 1)
    {
        self.sjBriefLabel.hidden = NO;
    }
    
    return YES;
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
    if (row == self.pickerArray.count-1) {
        self.selectItemStr = @"请选择";
    }
    else
    {
        self.selectItemStr = self.pickerArray[row];
    }
}

#pragma alertView delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == sjTypeAlertViewTag) {
        if (buttonIndex == 0) {
            [self.sjTypeBtn setTitle:@"商家" forState:UIControlStateNormal];
        }
        else if (buttonIndex == 1)
        {
            [self.sjTypeBtn setTitle:@"个人" forState:UIControlStateNormal];
        }
        else
        {
            [self.sjTypeBtn setTitle:@"请选择" forState:UIControlStateNormal];
        }
    }
    else if (alertView.tag == sjAttributeAlertViewTag)
    {
        //国有企业", @"合资企业",@"集体企业",@"私营企业
        if (buttonIndex == 0) {
            [self.sjAttributeBtn setTitle:@"国有企业" forState:UIControlStateNormal];
        }
        else if(buttonIndex == 1)
        {
            [self.sjAttributeBtn setTitle:@"合资企业" forState:UIControlStateNormal];
        }
        else if(buttonIndex == 2)
        {
            [self.sjAttributeBtn setTitle:@"集体企业" forState:UIControlStateNormal];
        }
        else if(buttonIndex == 3)
        {
            [self.sjAttributeBtn setTitle:@"私营企业" forState:UIControlStateNormal];
        }
        else
        {
            [self.sjAttributeBtn setTitle:@"请选择" forState:UIControlStateNormal];
        }
    }
    else if (alertView.tag == sjScaleAlertViewTag)
    {
        if (buttonIndex == 0) {
            [self.sjScaleBtn setTitle:@"20人以下" forState:UIControlStateNormal];
        }
        else if(buttonIndex == 1)
        {
            [self.sjScaleBtn setTitle:@"21人至50人" forState:UIControlStateNormal];
        }
        else if(buttonIndex == 2)
        {
            [self.sjScaleBtn setTitle:@"51人至100人" forState:UIControlStateNormal];
        }
        else if(buttonIndex == 3)
        {
            [self.sjScaleBtn setTitle:@"101人以上" forState:UIControlStateNormal];
        }
        else
        {
            [self.sjScaleBtn setTitle:@"请选择" forState:UIControlStateNormal];
        }
    }
}

- (void)commitBtnClick
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"id"] = sjGlobalSessionId;
    for (SjJobIndustry *industry in self.IndustryArray) {
        if ([industry.industryName isEqualToString:self.sjIndustyBtn.titleLabel.text]) {
            params[@"industry"] = industry.industryId;
        }
    }
    params[@"name"] = self.sjNameTF.text;
    if ([self.sjTypeBtn.titleLabel.text isEqualToString:@"商家"]) {
        params[@"type"] = @"enterprise";
    }
    else if ([self.sjTypeBtn.titleLabel.text isEqualToString:@"个人"])
    {
        params[@"type"] = @"personnal";
    }
    else
    {
        params[@"type"] = @"";
    }
    if ([self.sjAttributeBtn.titleLabel.text isEqualToString:@"国有企业"]) {
        params[@"attribute"] = @"1";
    }
    else if ([self.sjAttributeBtn.titleLabel.text isEqualToString:@"合资企业"])
    {
        params[@"attribute"] = @"2";
    }
    else if ([self.sjAttributeBtn.titleLabel.text isEqualToString:@"集体企业"])
    {
        params[@"attribute"] = @"3";
    }
    else if ([self.sjAttributeBtn.titleLabel.text isEqualToString:@"私营企业"])
    {
        params[@"attribute"] = @"4";
    }
    else
    {
        params[@"attribute"] = @"";
    }
    if ([self.sjScaleBtn.titleLabel.text isEqualToString:@"20人以下"]) {
        params[@"scale"] = @"20人以下";
    }
    else if ([self.sjScaleBtn.titleLabel.text isEqualToString:@"21人至50人"])
    {
        params[@"scale"] = @"21人至50人";
    }
    else if ([self.sjScaleBtn.titleLabel.text isEqualToString:@"51人至100人"])
    {
        params[@"scale"] = @"51人至100人";
    }
    else if ([self.sjScaleBtn.titleLabel.text isEqualToString:@"101人以上"])
    {
        params[@"scale"] = @"101人以上";
    }
    else
    {
        params[@"scale"] = @"";
    }
    
    params[@"brifIntrodution"] = self.sjBriefTextView.text;
    NSMutableString *allureStrM = [NSMutableString string];
    for (UIView *view in self.sjAllAllureScrollView.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton*)view;
            [allureStrM appendString:[NSString stringWithFormat:@"%@,", btn.titleLabel.text]];
        }
    }
    if (allureStrM.length > 0) {
        [allureStrM substringToIndex:allureStrM.length-1];
    }
    params[@"labels"] = allureStrM;
    params[@"contactPerson"] = self.sjContactP.text;
    params[@"contactNumber"] = self.sjContactT.text;
    params[@"email"] = self.sjEmail.text;
    params[@"homePage"] = self.sjHomePage.text;
    params[@"address"] = self.sjAddress.text;
    
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/web/enterprise/saveEnterpriseInfo4App", sjIp]];
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
    NSDictionary *dict = [NSDictionary dictionary];
    if (data.length != 0) {
        dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    }
    //state
    if ([dict[@"state"] isEqual:@"success"])
    {
        [MBProgressHUD showSuccess:@"资料修改成功"];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        [MBProgressHUD showError:@"资料修改失败"];
    }
}

@end
