//
//  StuProfileMyBasicInfoView.h
//  yz-student
//
//  Created by 仲光磊 on 15/10/3.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StuProfileMyBasicView : UIView
@property (weak, nonatomic) IBOutlet UITextField *nameL;
@property (weak, nonatomic) IBOutlet UITextField *genderL;
@property (weak, nonatomic) IBOutlet UITextField *heightL;
@property (weak, nonatomic) IBOutlet UIButton *basicInfoCommitBtn;

+(instancetype)basicInfoViewFromNib;

@end
