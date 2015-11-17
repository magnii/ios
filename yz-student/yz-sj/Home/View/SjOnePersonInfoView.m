//
//  SjOnePersonInfoView.m
//  yz-student
//
//  Created by 仲光磊 on 15/11/5.
//  Copyright © 2015年 cdq. All rights reserved.
//

#import "SjOnePersonInfoView.h"

@implementation SjOnePersonInfoView

+ (instancetype)onePersonFromNib
{
    SjOnePersonInfoView *view = [[SjOnePersonInfoView alloc]init];
    view = [[[NSBundle mainBundle]loadNibNamed:@"SjOnePersonInfoView" owner:self options:nil]lastObject];
    return view;
}

@end
