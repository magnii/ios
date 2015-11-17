//
//  StuCompanInfo.m
//  yz-student
//
//  Created by 仲光磊 on 15/9/9.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import "StuCompanInfo.h"
#import "StuCompanyInfoModel.h"
#import "UIImageView+WebCache.h"

#import "StuHomeJobTableViewController.h"
#import "StuConfig.h"

#define paddingW 20
#define paddingH 15
#define companyTextViewFontSize 12
#define companyTextViewFontcolor [UIColor colorWithRed:140/255.0 green:140/255.0 blue:140/255.0 alpha:1.0]

@interface StuCompanInfo()

@property(nonatomic, strong) UIView *companyInstruView;
@property(nonatomic, strong) UIView *companyJobsView;
@property(nonatomic, strong) UITextView *companyInfoTextView;

//*******在StuJobDetailViewController实现代理方法*********
@property(nonatomic, strong)NSMutableArray *companyInfoJobArry;

@end

@implementation StuCompanInfo

- (UITableView *)companyInfoJobsTableView
{
    if (_companyInfoJobsTableView == nil) {
        _companyInfoJobsTableView = [[UITableView alloc]init];
    }
    return _companyInfoJobsTableView;
}

- (UIView *)companyInstruView
{
    if (_companyInstruView == nil) {
        _companyInstruView = [[UIView alloc]init];
    }
    return _companyInstruView;
}

- (UIView *)companyJobsView
{
    if (_companyJobsView == nil) {
        _companyJobsView = [[UIView alloc]init];
    }
    return _companyJobsView;
}

- (UITextView *)companyInfoTextView
{
    if (_companyInfoTextView == nil) {
        _companyInfoTextView = [[UITextView alloc]init];
    }
    _companyInfoTextView.font = [UIFont systemFontOfSize:companyTextViewFontSize];
    _companyInfoTextView.textColor = companyTextViewFontcolor;
    return _companyInfoTextView;
}

- (IBAction)companyAttentionBtnClick:(UIButton *)sender {
    NSLog(@"companyAttentionBtnClick");
}
- (IBAction)companyInstruBtnClick:(UIButton *)sender {
    [self.companyInstruBtn setSelected:YES];
    [self.companyJobsBtn setSelected:NO];
    
    [self.companyJobsView removeFromSuperview];
    [self.companyInstruView addSubview:self.companyInfoTextView];
    [self addSubview:self.companyInstruView];
}

- (IBAction)companyJobsBtnClick:(UIButton *)sender {
    [self.companyJobsBtn setSelected:YES];
    [self.companyInstruBtn setSelected:NO];
    
    [self.companyInstruView removeFromSuperview];
    self.companyJobsView.frame = CGRectMake(0, CGRectGetMaxY(self.companyJobsBtn.frame), screenFrame.size.width, screenFrame.size.height);
    [self.companyJobsView addSubview:self.companyInfoJobsTableView];
    //公司详情中的兼职岗位tableview
    self.companyInfoJobsTableView.frame = CGRectMake(0, 0, screenFrame.size.width, screenFrame.size.height-CGRectGetMaxY(sender.frame)-40);
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    self.companyInfoJobsTableView.tableFooterView = view;
    [self addSubview:self.companyJobsView];
}

+ (instancetype)companyInfoWithNib
{
    StuCompanInfo *companyInfo = [[StuCompanInfo alloc]init];
    companyInfo = [[[NSBundle mainBundle]loadNibNamed:@"StuCompanInfo" owner:nil options:nil]lastObject];
    return companyInfo;
}

- (void)setUpCompanyInfoWithCompanyModel:(StuCompanyInfoModel*)companyInfoModel
{
    //xib内容填充
    self.companyNameL.text = companyInfoModel.name;
    [self.companyImg sd_setImageWithURL:[NSURL URLWithString:companyInfoModel.logoImage] placeholderImage:[UIImage imageNamed:@"icon_empty"]];
    self.companyRegistTimeL.text = [NSString stringWithFormat:@"注册时间：%@", companyInfoModel.createTime];
    self.companyHaveJobsL.text = [NSString stringWithFormat:@"%d个", companyInfoModel.jobsNumber];
    self.companyBeAttentionL.text = [NSString stringWithFormat:@"%d次", companyInfoModel.concernedCounts];
    
    //公司信息
    self.companyInfoTextView.text = [NSString stringWithFormat:@"       %@", companyInfoModel.brifIntrodution];
    
//    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//    dict[@"NSFontAttributeName"] = [UIFont systemFontOfSize:companyTextViewFontSize];
//    CGFloat companyInfoTextViewH = [self.companyInfoTextView.text boundingRectWithSize:CGSizeMake(screenFrame.size.width-paddingW*2, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size.height;
    
    self.companyInfoTextView.frame = CGRectMake(paddingW, CGRectGetMaxY(self.companyInstruBtn.frame)+paddingH, screenFrame.size.width-paddingW*2, self.frame.size.height-245);
    
    //星评
    float score = [StuCompanyInfoModel companyScoreCheckWithCompanyId:companyInfoModel.companyId];
    int scoreTmp = score+0.5;
    [self setCommentStarLight:scoreTmp];
    
    [self companyInstruBtnClick:nil];
}

- (void)setCommentStarLight:(int)stars
{
    if(stars == 0)
        return;
    self.commentStar1.selected=YES;
    if(stars == 1)
        return;
    self.commentStar2.selected=YES;
    if(stars == 2)
        return;
    self.commentStar3.selected=YES;
    if(stars == 3)
        return;
    self.commentStar4.selected=YES;
    if(stars == 4)
        return;
    self.commentStar5.selected=YES;
    return;
}

@end
