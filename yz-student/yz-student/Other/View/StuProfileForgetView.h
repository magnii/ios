//
//  StuProfileForgetView.h
//  yz-student
//
//  Created by 仲光磊 on 15/10/14.
//  Copyright © 2015年 cdq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StuProfileForgetView : UIView
@property (weak, nonatomic) IBOutlet UITextField *telephoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *identifyTextField;
@property (weak, nonatomic) IBOutlet UIButton *obtainIdentifyBtn;
@property (weak, nonatomic) IBOutlet UIView *identifyView;
@property (weak, nonatomic) IBOutlet UILabel *timeL;
@property (weak, nonatomic) IBOutlet UITextField *passwdOnceTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwdSecondTextField;
@property (weak, nonatomic) IBOutlet UIButton *resetBtn;

+(instancetype)viewFromNib;

@end
