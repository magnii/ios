//
//  StuUploadIDCard.h
//  yz-student
//
//  Created by 仲光磊 on 15/10/7.
//  Copyright © 2015年 cdq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StuUploadIDCard : UIView
@property (weak, nonatomic) IBOutlet UIButton *certificateBtn;
- (IBAction)uploadCertificateBtnClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *stuCertificateBtn;
- (IBAction)uploadStuCertificateBtnClick:(UIButton *)sender;
- (IBAction)commitBtnClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *uploadCertificateBtn;
@property (weak, nonatomic) IBOutlet UIButton *uploadStuCertificateBtn;
@property (weak, nonatomic) IBOutlet UIButton *commitBtn;

+(instancetype)viewFromNib;

@end
