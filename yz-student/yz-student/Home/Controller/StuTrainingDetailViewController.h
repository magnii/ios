//
//  StuTrainingDetailViewController.h
//  yz-student
//
//  Created by 仲光磊 on 15/9/10.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import <UIKit/UIKit.h>

@class StuTrainingModel;

@interface StuTrainingDetailViewController : UIViewController

@property(nonatomic, strong)StuTrainingModel *trainingModel;

@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UILabel *startDateL;
@property (weak, nonatomic) IBOutlet UILabel *endDateL;
@property (weak, nonatomic) IBOutlet UILabel *numbersL;
@property (weak, nonatomic) IBOutlet UILabel *congtactPL;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *contactTL;
@property (weak, nonatomic) IBOutlet UILabel *contactQL;
@property (weak, nonatomic) IBOutlet UILabel *instrumentL;
- (IBAction)trainingWantBtnClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *trainingWantBtn;

@end
