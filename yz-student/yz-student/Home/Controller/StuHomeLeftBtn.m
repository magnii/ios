//
//  StuHomeLeftBtn.m
//  yz-student
//
//  Created by 仲光磊 on 15/9/3.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import "StuHomeLeftBtn.h"

@implementation StuHomeLeftBtn

+ (instancetype)stuHomeLeftBtnWithNib
{
    StuHomeLeftBtn *leftBtn = [[[NSBundle mainBundle]loadNibNamed:@"StuHomeLeftBtn" owner:nil options:nil] lastObject];
    return leftBtn;
}

@end
