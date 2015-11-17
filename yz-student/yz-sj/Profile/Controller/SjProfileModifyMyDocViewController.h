//
//  SjProfileModifyMyDocViewController.h
//  yz-student
//
//  Created by 仲光磊 on 15/11/2.
//  Copyright © 2015年 cdq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SjProfileModifyMyDocViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *sjNameTF;
@property (weak, nonatomic) IBOutlet UIButton *sjLogoBtn;
@property (weak, nonatomic) IBOutlet UIButton *sjIndustyBtn;
@property (weak, nonatomic) IBOutlet UIButton *sjTypeBtn;
@property (weak, nonatomic) IBOutlet UIButton *sjAttributeBtn;
@property (weak, nonatomic) IBOutlet UIButton *sjScaleBtn;
@property (weak, nonatomic) IBOutlet UIView *sjBriefView;
@property (weak, nonatomic) IBOutlet UITextField *sjAllureTextField;
@property (weak, nonatomic) IBOutlet UIButton *sjAddAllureBtn;
@property (weak, nonatomic) IBOutlet UIScrollView *sjAllAllureScrollView;
@property (weak, nonatomic) IBOutlet UITextField *sjContactP;
@property (weak, nonatomic) IBOutlet UITextField *sjContactT;
@property (weak, nonatomic) IBOutlet UITextField *sjEmail;
@property (weak, nonatomic) IBOutlet UITextField *sjHomePage;
@property (weak, nonatomic) IBOutlet UITextField *sjAddress;
@property (weak, nonatomic) IBOutlet UIButton *sjCommitBtn;

@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UIView *view3;
@property (weak, nonatomic) IBOutlet UIView *view4;


@end
