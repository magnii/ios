//
//  SjOneJobDetailView.m
//  yz-student
//
//  Created by 仲光磊 on 15/10/22.
//  Copyright © 2015年 cdq. All rights reserved.
//

#import "SjOneJobDetailView2.h"

@implementation SjOneJobDetailView2

+ (instancetype)viewFromNib
{
    SjOneJobDetailView2 *view = [[SjOneJobDetailView2 alloc]init];
    view = [[[NSBundle mainBundle]loadNibNamed:@"SjOneJobDetailView2" owner:nil options:nil]lastObject];
    return view;
}

@end
