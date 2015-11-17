//
//  SjProfileHomeHeadView.m
//  yz-student
//
//  Created by 仲光磊 on 15/10/29.
//  Copyright © 2015年 cdq. All rights reserved.
//

#import "SjProfileHomeHeadView.h"

@implementation SjProfileHomeHeadView

+(instancetype)viewFromNib
{
    SjProfileHomeHeadView *view = [[SjProfileHomeHeadView alloc]init];
    view = [[[NSBundle mainBundle]loadNibNamed:@"SjProfileHomeHeadView" owner:nil options:nil]lastObject];
    return view;
}

@end
