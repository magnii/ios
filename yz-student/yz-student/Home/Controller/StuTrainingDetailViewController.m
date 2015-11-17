//
//  StuTrainingDetailViewController.m
//  yz-student
//
//  Created by 仲光磊 on 15/9/10.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import "StuTrainingDetailViewController.h"
#import "StuTrainingModel.h"
#import "MBProgressHUD+MJ.h"

extern NSString* globalSessionId;

@interface StuTrainingDetailViewController ()

@end

@implementation StuTrainingDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.titleL.text = self.trainingModel.name;
    self.startDateL.text = [NSString stringWithFormat:@"开始日期：%@", self.trainingModel.startDate];
    self.endDateL.text = [NSString stringWithFormat:@"结束日期：%@", self.trainingModel.endDate];
    self.numbersL.text = [NSString stringWithFormat:@"培训名额：%@人", self.trainingModel.peoples];
    self.congtactPL.text = [NSString stringWithFormat:@"联系人：%@", self.trainingModel.contactP];
    self.address.text = [NSString stringWithFormat:@"培训地点：%@", self.trainingModel.address];
    self.contactTL.text = [NSString stringWithFormat:@"报名电话：%@", self.trainingModel.telephone];
    self.contactQL.text = [NSString stringWithFormat:@"咨询QQ：%@", self.trainingModel.qq];
    self.instrumentL.text = self.trainingModel.content;
    
    if (self.trainingModel.hasSignUp != nil && [self.trainingModel.hasSignUp isEqualToString:@"1"]) {
        [self.trainingWantBtn setTitle:@"已经报名" forState:UIControlStateNormal];
        self.trainingWantBtn.userInteractionEnabled = NO;
    }
}

- (IBAction)trainingWantBtnClick:(UIButton *)sender {
    
    if (globalSessionId == nil || globalSessionId.length == 0) {
        [MBProgressHUD showError:@"您还没有登录"];
    }
    else
    {
        if ([StuTrainingModel trainingIWantWithSessionId:globalSessionId TrainingId:self.trainingModel.trainId]) {
            [MBProgressHUD showSuccess:@"报名成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }else
        {
            [MBProgressHUD showError:@"报名失败"];
        }
    }
}
@end
