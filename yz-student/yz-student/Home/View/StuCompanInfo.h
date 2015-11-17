//
//  StuCompanInfo.h
//  yz-student
//
//  Created by 仲光磊 on 15/9/9.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import <UIKit/UIKit.h>

@class StuCompanyInfoModel;

@interface StuCompanInfo : UIView
@property (weak, nonatomic) IBOutlet UIImageView *companyImg;
@property (weak, nonatomic) IBOutlet UILabel *companyNameL;
@property (weak, nonatomic) IBOutlet UILabel *companyRegistTimeL;
@property (weak, nonatomic) IBOutlet UIButton *companyAttentionBtn;


@property (weak, nonatomic) IBOutlet UILabel *companyHaveJobsL;
@property (weak, nonatomic) IBOutlet UILabel *companyBeAttentionL;
@property (weak, nonatomic) IBOutlet UIButton *commentStar1;
@property (weak, nonatomic) IBOutlet UIButton *commentStar2;
@property (weak, nonatomic) IBOutlet UIButton *commentStar3;
@property (weak, nonatomic) IBOutlet UIButton *commentStar4;
@property (weak, nonatomic) IBOutlet UIButton *commentStar5;

@property (weak, nonatomic) IBOutlet UIButton *companyInstruBtn;
- (IBAction)companyInstruBtnClick:(UIButton *)sender;

- (IBAction)companyJobsBtnClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *companyJobsBtn;

+(instancetype)companyInfoWithNib;
- (void)setUpCompanyInfoWithCompanyModel:(StuCompanyInfoModel*)companyInfoModel;

@property (weak, nonatomic) IBOutlet UIView *lineView1;
@property (weak, nonatomic) IBOutlet UIView *lineView2;
@property (weak, nonatomic) IBOutlet UIView *startView;
@property (weak, nonatomic) IBOutlet UIView *lineView3;

@property(nonatomic, strong)UITableView *companyInfoJobsTableView;


@end
