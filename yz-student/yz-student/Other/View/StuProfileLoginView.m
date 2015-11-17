//
//  StuProfileLoginView.m
//  yz-student
//
//  Created by 仲光磊 on 15/10/13.
//  Copyright © 2015年 cdq. All rights reserved.
//

#import "StuProfileLoginView.h"

@implementation StuProfileLoginView

+ (instancetype)viewFromNib
{
    StuProfileLoginView *view = [[StuProfileLoginView alloc]init];
    view = [[[NSBundle mainBundle]loadNibNamed:@"StuProfileLoginView" owner:nil options:nil]lastObject];
    return view;
}
@end
