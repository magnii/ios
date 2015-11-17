//
//  StuProfileMyJobDetailDateBtn.m
//  yz-student
//
//  Created by 仲光磊 on 15/9/19.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import "StuProfileMyJobDetailDateBtn.h"

@implementation StuProfileMyJobDetailDateBtn

+ (instancetype)dateBtnFromNib
{
    StuProfileMyJobDetailDateBtn *btn = [[[NSBundle mainBundle]loadNibNamed:@"StuProfileMyJobDetailDateBtn" owner:nil options:nil]lastObject];
    return btn;
}

@end
