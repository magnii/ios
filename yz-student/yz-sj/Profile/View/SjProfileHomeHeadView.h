//
//  SjProfileHomeHeadView.h
//  yz-student
//
//  Created by 仲光磊 on 15/10/29.
//  Copyright © 2015年 cdq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SjProfileHomeHeadView : UIView
@property (weak, nonatomic) IBOutlet UILabel *userNameL;
@property (weak, nonatomic) IBOutlet UILabel *userPointL;
@property (weak, nonatomic) IBOutlet UILabel *companyNameL;

+ (instancetype)viewFromNib;

@end
