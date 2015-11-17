//
//  StuProfileMyJobDetailDetailView.h
//  yz-student
//
//  Created by 仲光磊 on 15/9/19.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StuProfileMyJobDetailDetailView : UIView
@property (weak, nonatomic) IBOutlet UILabel *numbersL;
@property (weak, nonatomic) IBOutlet UILabel *salaryL;
@property (weak, nonatomic) IBOutlet UILabel *balanceL;
@property (weak, nonatomic) IBOutlet UILabel *startDateL;
@property (weak, nonatomic) IBOutlet UILabel *endDateL;
@property (weak, nonatomic) IBOutlet UILabel *workHL;
@property (weak, nonatomic) IBOutlet UILabel *addressL;
@property (weak, nonatomic) IBOutlet UILabel *contentL;
@property (weak, nonatomic) IBOutlet UILabel *gentderL;
@property (weak, nonatomic) IBOutlet UILabel *heightL;
@property (weak, nonatomic) IBOutlet UILabel *specialL;

+(instancetype)viewFromNib;

@end
