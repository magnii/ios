//
//  SjProfileAuthenticationView.m
//  yz-student
//
//  Created by 仲光磊 on 15/11/4.
//  Copyright © 2015年 cdq. All rights reserved.
//

#import "SjProfileAuthenticationView.h"

@implementation SjProfileAuthenticationView

+(instancetype)viewFromNib
{
    SjProfileAuthenticationView *view = [[SjProfileAuthenticationView alloc]init];
    
    view = [[[NSBundle mainBundle]loadNibNamed:@"SjProfileAuthenticationView" owner:nil options:nil]lastObject];
    
    [view.idCardFrontBtn setBackgroundImage:[UIImage imageNamed:@"icon_empty"] forState:UIControlStateNormal];
    [view.idCardBackBtn setBackgroundImage:[UIImage imageNamed:@"icon_empty"] forState:UIControlStateNormal];
    [view.bussinesLicenseBtn setBackgroundImage:[UIImage imageNamed:@"icon_empty"] forState:UIControlStateNormal];
    return view;
}
@end
