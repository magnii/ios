//
//  StuProfileRegisterView.h
//  yz-student
//
//  Created by 仲光磊 on 15/10/14.
//  Copyright © 2015年 cdq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StuProfileRegisterView : UIView

@property (weak, nonatomic) IBOutlet UITextField *telephoneTextFiled;
@property (weak, nonatomic) IBOutlet UITextField *identifyTextField;
@property (weak, nonatomic) IBOutlet UIView *identifyView;
@property (weak, nonatomic) IBOutlet UIButton *obtainIdentifyBtn;
@property (weak, nonatomic) IBOutlet UITextField *passwdOnceTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwdSecondTextField;
@property (weak, nonatomic) IBOutlet UITextField *InvitationTextField;
@property (weak, nonatomic) IBOutlet UIButton *commitBtn;
@property (weak, nonatomic) IBOutlet UILabel *timeL;

+(instancetype)viewFromNib;

@end
