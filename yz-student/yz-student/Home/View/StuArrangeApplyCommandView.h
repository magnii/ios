//
//  StuArrangeApplyCommandView.h
//  yz-student
//
//  Created by 仲光磊 on 15/9/8.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StuArrangeApplyCommandView : UIView
@property (weak, nonatomic) IBOutlet UILabel *contactPhoneL;
@property (weak, nonatomic) IBOutlet UITextField *commandL;
- (IBAction)arrangeCommandClick;

+(instancetype)applyCommandViewFromNib;

@property (weak, nonatomic) IBOutlet UIButton *arrangeCommandBtn;
@end
