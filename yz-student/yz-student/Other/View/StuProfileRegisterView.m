//
//  StuProfileRegisterView.m
//  yz-student
//
//  Created by 仲光磊 on 15/10/14.
//  Copyright © 2015年 cdq. All rights reserved.
//

#import "StuProfileRegisterView.h"

@implementation StuProfileRegisterView

+ (instancetype)viewFromNib
{
    StuProfileRegisterView *view = [[StuProfileRegisterView alloc]init];
    view = [[[NSBundle mainBundle]loadNibNamed:@"StuProfileRegisterView" owner:nil options:nil]lastObject];
    return view;
}
@end
