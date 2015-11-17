//
//  SjOneSignView.h
//  yz-student
//
//  Created by 仲光磊 on 15/11/6.
//  Copyright © 2015年 cdq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SjOneSignView : UIView
@property (weak, nonatomic) IBOutlet UILabel *dateL;
@property (weak, nonatomic) IBOutlet UILabel *signInDateL;
@property (weak, nonatomic) IBOutlet UILabel *signInAddrL;
@property (weak, nonatomic) IBOutlet UILabel *signOutDateL;
@property (weak, nonatomic) IBOutlet UILabel *signOutAddrL;

+(instancetype)viewFromNib;

@end
