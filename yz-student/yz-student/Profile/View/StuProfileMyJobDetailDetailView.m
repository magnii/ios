//
//  StuProfileMyJobDetailDetailView.m
//  yz-student
//
//  Created by 仲光磊 on 15/9/19.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import "StuProfileMyJobDetailDetailView.h"

@implementation StuProfileMyJobDetailDetailView

+ (instancetype)viewFromNib
{
    StuProfileMyJobDetailDetailView *view = [[[NSBundle mainBundle]loadNibNamed:@"StuProfileMyJobDetailDetailView" owner:nil options:nil]lastObject];
    return view;
}

@end
