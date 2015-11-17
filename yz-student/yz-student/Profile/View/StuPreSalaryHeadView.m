//
//  StuPreSalaryHeadView.m
//  yz-student
//
//  Created by 仲光磊 on 15/10/8.
//  Copyright © 2015年 cdq. All rights reserved.
//

#import "StuPreSalaryHeadView.h"

@implementation StuPreSalaryHeadView

+ (instancetype)headViewFromNib
{
    StuPreSalaryHeadView *view = [[[NSBundle mainBundle]loadNibNamed:@"StuPreSalaryHeadView" owner:nil options:nil]lastObject];
    return view;
}

@end
