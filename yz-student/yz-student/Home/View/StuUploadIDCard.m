//
//  StuUploadIDCard.m
//  yz-student
//
//  Created by 仲光磊 on 15/10/7.
//  Copyright © 2015年 cdq. All rights reserved.
//

#import "StuUploadIDCard.h"

@implementation StuUploadIDCard

- (IBAction)uploadCertificateBtnClick:(UIButton *)sender {
}
- (IBAction)uploadStuCertificateBtnClick:(UIButton *)sender {
}

- (IBAction)commitBtnClick:(UIButton *)sender {
}

+(instancetype)viewFromNib
{
    StuUploadIDCard *view = [[StuUploadIDCard alloc]init];
    
    view = [[[NSBundle mainBundle]loadNibNamed:@"StuUploadIDCard" owner:nil options:nil]lastObject];
    
    [view.certificateBtn setBackgroundImage:[UIImage imageNamed:@"aaab1.jpg"] forState:UIControlStateNormal];
    [view.stuCertificateBtn setBackgroundImage:[UIImage imageNamed:@"aaab1.jpg"] forState:UIControlStateNormal];
    return view;
}
@end
