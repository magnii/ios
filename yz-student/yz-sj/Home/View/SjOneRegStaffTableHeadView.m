//
//  SjOneRegStaffTableHeadView.m
//  yz-student
//
//  Created by 仲光磊 on 15/11/6.
//  Copyright © 2015年 cdq. All rights reserved.
//

#import "SjOneRegStaffTableHeadView.h"

@implementation SjOneRegStaffTableHeadView

+(instancetype)viewFromNib
{
    SjOneRegStaffTableHeadView *view = [[SjOneRegStaffTableHeadView alloc]init];
    view = [[[NSBundle mainBundle]loadNibNamed:@"SjOneRegStaffTableHeadView" owner:nil options:nil]lastObject];
    return view;
}

@end
