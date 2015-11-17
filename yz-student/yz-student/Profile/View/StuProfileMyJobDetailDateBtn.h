//
//  StuProfileMyJobDetailDateBtn.h
//  yz-student
//
//  Created by 仲光磊 on 15/9/19.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StuProfileMyJobDetailDateBtn : UIView
@property (weak, nonatomic) IBOutlet UILabel *dateL;
@property (weak, nonatomic) IBOutlet UIButton *dateBtn;
@property(nonatomic, strong) NSString *jobId;

+(instancetype)dateBtnFromNib;

@end
