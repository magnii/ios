//
//  SjOneSignView.m
//  yz-student
//
//  Created by 仲光磊 on 15/11/6.
//  Copyright © 2015年 cdq. All rights reserved.
//

#import "SjOneSignView.h"

@implementation SjOneSignView

+(instancetype)viewFromNib
{
    SjOneSignView *view = [[SjOneSignView alloc]init];
    view = [[[NSBundle mainBundle]loadNibNamed:@"SjOneSignView" owner:nil options:nil]lastObject];
    return view;
}

@end
