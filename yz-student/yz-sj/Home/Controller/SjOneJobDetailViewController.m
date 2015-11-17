//
//  SjOneJobDetailViewController.m
//  yz-student
//
//  Created by 仲光磊 on 15/10/22.
//  Copyright © 2015年 cdq. All rights reserved.
//

#import "SjOneJobDetailViewController.h"
#import "SjOneJobDetailView2.h"
#import "StuConfig.h"
#import "SjJobInfo.h"

@interface SjOneJobDetailViewController ()

@property(nonatomic, strong)UIScrollView *scrollView;

@end

@implementation SjOneJobDetailViewController

- (UIScrollView *)scrollView
{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc]init];
    }
    return _scrollView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"兼职详情";
    
    self.scrollView.frame = CGRectMake(0, 0, screenFrame.size.width, screenFrame.size.height);
    [self.view addSubview:self.scrollView];
    self.scrollView.contentSize = CGSizeMake(screenFrame.size.width, 600);
    
    SjOneJobDetailView2 *jobDetailView = [SjOneJobDetailView2 viewFromNib];
    
    jobDetailView.frame = CGRectMake(0, 0, screenFrame.size.width, screenFrame.size.height);
    [self.scrollView addSubview:jobDetailView];
    
    jobDetailView.recruitNumL.text = [NSString stringWithFormat:@"%d人", self.oneJobInfo.recruitNum];
    jobDetailView.salaryL.text = [NSString stringWithFormat:@"%d元/天", self.oneJobInfo.salary];
    jobDetailView.settlementPeriodL.text = self.oneJobInfo.settlementPeriod;
    jobDetailView.workDateL.text = [NSString stringWithFormat:@"%@ 至 %@", self.oneJobInfo.workingStartDate, self.oneJobInfo.workingEndDate];
    jobDetailView.workTimeL.text = self.oneJobInfo.workingHours;
    jobDetailView.workAddressL.text = self.oneJobInfo.address;
    jobDetailView.workContentL.text = self.oneJobInfo.workContent;
    jobDetailView.genderL.text = self.oneJobInfo.genderLimit;
    jobDetailView.heightL.text = self.oneJobInfo.heightLimit;
    jobDetailView.specialL.text = self.oneJobInfo.specialRequired;
}

@end
