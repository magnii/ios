//
//  SjProfileAuthenticationView.h
//  yz-student
//
//  Created by 仲光磊 on 15/11/4.
//  Copyright © 2015年 cdq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SjProfileAuthenticationView : UIView
@property (weak, nonatomic) IBOutlet UIButton *idCardFrontBtn;
@property (weak, nonatomic) IBOutlet UIButton *idCardBackBtn;
@property (weak, nonatomic) IBOutlet UIButton *idCardUploadBtn;
@property (weak, nonatomic) IBOutlet UIButton *bussinesLicenseBtn;
@property (weak, nonatomic) IBOutlet UIButton *bussinesLicenseUploadBtn;
@property (weak, nonatomic) IBOutlet UIButton *commitBtn;

+(instancetype)viewFromNib;

@end
