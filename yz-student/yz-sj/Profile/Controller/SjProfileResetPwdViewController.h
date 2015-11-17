//
//  SjProfileResetPwdViewController.h
//  yz-student
//
//  Created by 仲光磊 on 15/10/29.
//  Copyright © 2015年 cdq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SjProfileResetPwdViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *oldPwdTextField;
@property (weak, nonatomic) IBOutlet UITextField *oncePwdTextField;
@property (weak, nonatomic) IBOutlet UITextField *secondPwdTextField;
@property (weak, nonatomic) IBOutlet UIButton *resetPwdBtn;
- (IBAction)resetPwdBtnClick:(id)sender;

@end
