//
//  StuProfileHomeHead2View.m
//  yz-student
//
//  Created by 仲光磊 on 15/10/3.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import "StuProfileHomeHead2View.h"

@implementation StuProfileHomeHead2View

+ (instancetype)headViewFromNib
{
    StuProfileHomeHead2View *view = [[[NSBundle mainBundle]loadNibNamed:@"StuProfileHomeHead2" owner:nil options:nil]lastObject];
    return view;
}

@end
