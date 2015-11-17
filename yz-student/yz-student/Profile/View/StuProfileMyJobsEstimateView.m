//
//  StuProfileMyJobsEstimateView.m
//  yz-student
//
//  Created by 仲光磊 on 15/10/12.
//  Copyright © 2015年 cdq. All rights reserved.
//

#import "StuProfileMyJobsEstimateView.h"

@implementation StuProfileMyJobsEstimateView

+ (instancetype)viewFromNib
{
    StuProfileMyJobsEstimateView *view = [[[NSBundle mainBundle]loadNibNamed:@"StuProfileMyJobsEstimateView" owner:nil options:nil]lastObject];
    return view;
}

@end
