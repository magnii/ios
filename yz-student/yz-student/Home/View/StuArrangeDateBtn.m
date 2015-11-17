//
//  StuArrangeDateBtn.m
//  yz-student
//
//  Created by 仲光磊 on 15/9/11.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import "StuArrangeDateBtn.h"

@implementation StuArrangeDateBtn

+(instancetype)buttonWithNib
{
    StuArrangeDateBtn *btn = [[[NSBundle mainBundle]loadNibNamed:@"StuArrangeDateBtn" owner:nil options:nil]lastObject];
    return btn;
}

@end
