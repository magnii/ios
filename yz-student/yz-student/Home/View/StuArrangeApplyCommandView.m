//
//  StuArrangeApplyCommandView.m
//  yz-student
//
//  Created by 仲光磊 on 15/9/8.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import "StuArrangeApplyCommandView.h"

@implementation StuArrangeApplyCommandView

- (IBAction)arrangeCommandClick {
}

+ (instancetype)applyCommandViewFromNib
{
    StuArrangeApplyCommandView *view = [[[NSBundle mainBundle]loadNibNamed:@"StuArrangeApplyCommand" owner:nil options:nil]lastObject];
    return view;
}
@end
