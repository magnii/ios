//
//  SjOneJobDetailView.h
//  yz-student
//
//  Created by 仲光磊 on 15/10/22.
//  Copyright © 2015年 cdq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SjOneJobDetailView2 : UIView

+(instancetype)viewFromNib;
@property (weak, nonatomic) IBOutlet UILabel *recruitNumL;
@property (weak, nonatomic) IBOutlet UILabel *salaryL;
@property (weak, nonatomic) IBOutlet UILabel *settlementPeriodL;
@property (weak, nonatomic) IBOutlet UILabel *workDateL;
@property (weak, nonatomic) IBOutlet UILabel *workTimeL;
@property (weak, nonatomic) IBOutlet UILabel *workAddressL;
@property (weak, nonatomic) IBOutlet UILabel *workContentL;
@property (weak, nonatomic) IBOutlet UILabel *genderL;
@property (weak, nonatomic) IBOutlet UILabel *heightL;
@property (weak, nonatomic) IBOutlet UILabel *specialL;


@end
