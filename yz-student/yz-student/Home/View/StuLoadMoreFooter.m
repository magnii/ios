//
//  StuLoadMoreFooter.m
//  yz-student
//
//  Created by 仲光磊 on 15/9/6.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import "StuLoadMoreFooter.h"

@implementation StuLoadMoreFooter

+ (instancetype)footer
{
    return [[[NSBundle mainBundle] loadNibNamed:@"StuLoadMoreFooter" owner:nil options:nil] lastObject];
}


@end
