//
//  SjComposeJob UIViewController.h
//  yz-student
//
//  Created by 仲光磊 on 15/10/22.
//  Copyright © 2015年 cdq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SjJobInfo;

@interface SjComposeJobViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *nameL;
@property (weak, nonatomic) IBOutlet UITextField *recruitNumL;
@property (weak, nonatomic) IBOutlet UIButton *SettlementTypeBtn;
@property (weak, nonatomic) IBOutlet UIButton *SettlementDateBtn;
@property (weak, nonatomic) IBOutlet UILabel *SettlementDateL;
@property (weak, nonatomic) IBOutlet UITextField *salaryL;
@property (weak, nonatomic) IBOutlet UIButton *jobTypeBtn;
@property (weak, nonatomic) IBOutlet UIButton *isAgentBtn;
@property (weak, nonatomic) IBOutlet UIButton *arrangeRewardBtn;
@property (weak, nonatomic) IBOutlet UILabel *arrangeRewardL;
@property (weak, nonatomic) IBOutlet UIButton *accommodateBtn;
@property (weak, nonatomic) IBOutlet UIButton *workingLunchBtn;
@property (weak, nonatomic) IBOutlet UIButton *provinceBtn;
@property (weak, nonatomic) IBOutlet UIButton *cityBtn;
@property (weak, nonatomic) IBOutlet UIButton *areaBtn;
@property (weak, nonatomic) IBOutlet UITextField *addressTextField;
@property (weak, nonatomic) IBOutlet UIButton *workStartDateBtn;
@property (weak, nonatomic) IBOutlet UIButton *workEndDateBtn;
@property (weak, nonatomic) IBOutlet UIButton *workStartHourBtn;
@property (weak, nonatomic) IBOutlet UIButton *workEndHourBtn;
@property (weak, nonatomic) IBOutlet UIView *workContentView;
@property (weak, nonatomic) IBOutlet UIButton *gentderBtn;
@property (weak, nonatomic) IBOutlet UIButton *heightBtn;
@property (weak, nonatomic) IBOutlet UIView *specialView;
@property (weak, nonatomic) IBOutlet UITextField *contactL;
@property (weak, nonatomic) IBOutlet UITextField *telephoneL;
@property (weak, nonatomic) IBOutlet UIButton *commitBtn;
@property (weak, nonatomic) IBOutlet UIButton *resetBtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollViewHeight;

@property (weak, nonatomic) IBOutlet UIView *View1;
@property (weak, nonatomic) IBOutlet UIView *View2;
@property (weak, nonatomic) IBOutlet UIView *View3;
@property (weak, nonatomic) IBOutlet UIView *View4;
@property (weak, nonatomic) IBOutlet UIView *View5;
@property (weak, nonatomic) IBOutlet UIView *View6;
@property (weak, nonatomic) IBOutlet UIView *View7;
@property (weak, nonatomic) IBOutlet UIView *View8;
@property (weak, nonatomic) IBOutlet UIView *View9;
@property (weak, nonatomic) IBOutlet UIView *View10;
@property (weak, nonatomic) IBOutlet UIView *View11;
@property (weak, nonatomic) IBOutlet UIView *View12;

@property(nonatomic, strong)SjJobInfo *oneJobInfo;
@property (weak, nonatomic) IBOutlet UIView *scrollContentView;

@end
