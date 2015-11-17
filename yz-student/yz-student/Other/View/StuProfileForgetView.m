//
//  StuProfileForgetView.m
//  yz-student
//
//  Created by 仲光磊 on 15/10/14.
//  Copyright © 2015年 cdq. All rights reserved.
//

#import "StuProfileForgetView.h"

@implementation StuProfileForgetView

+ (instancetype)viewFromNib
{
    StuProfileForgetView *view = [[StuProfileForgetView alloc]init];
    view = [[[NSBundle mainBundle]loadNibNamed:@"StuProfileForgetView" owner:nil options:nil]lastObject];
    return view;
}

@end
