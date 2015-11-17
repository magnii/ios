//
//  StuProfileLoginView.h
//  yz-student
//
//  Created by 仲光磊 on 15/10/13.
//  Copyright © 2015年 cdq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StuProfileLoginView : UIView
@property (weak, nonatomic) IBOutlet UITextField *userNameL;
@property (weak, nonatomic) IBOutlet UITextField *passwordL;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *forgetPasswdBtn;
@property (weak, nonatomic) IBOutlet UIButton *registAccountBtn;

+(instancetype)viewFromNib;

@end
