//
//  StuProfileMyBasicInfoView.m
//  yz-student
//
//  Created by 仲光磊 on 15/10/3.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import "StuProfileMyBasicView.h"
#import "StuConfig.h"
#import "MBProgressHUD+MJ.h"

extern NSString *globalSessionId;

@implementation StuProfileMyBasicView

+(instancetype)basicInfoViewFromNib
{
    StuProfileMyBasicView *basicInfoView = [[StuProfileMyBasicView alloc]init];
    basicInfoView = [[[NSBundle mainBundle]loadNibNamed:@"StuProfileMyBasicView" owner:nil options:nil]lastObject];
    return basicInfoView;
}

@end
