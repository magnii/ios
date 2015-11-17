//
//  StuHomeFourBtnOne.m
//  yz-student
//
//  Created by 仲光磊 on 15/9/2.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import "StuHomeFourBtnOne.h"

#define imgWH 45
#define labelH 15
#define fontSize 10.0

@implementation StuHomeFourBtnOne

+ (instancetype) btnOneWithImg:(NSString*)img bottomL:(NSString*)bottomL
{
    StuHomeFourBtnOne *one = [[StuHomeFourBtnOne alloc]init];
    one.imgV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:img]];
    one.bottomL = [[UILabel alloc]init];
    one.bottomL.text = bottomL;
    one.bottomL.font = [UIFont systemFontOfSize:fontSize];
    [one addSubview:one.imgV];
    [one addSubview:one.bottomL];
    [one setAllFrame];
    
    return one;
}

- (void)setAllFrame
{
    self.imgV.frame = CGRectMake(0, 0, imgWH, imgWH);
    self.bottomL.frame = CGRectMake(0, CGRectGetMaxY(self.imgV.frame), imgWH, labelH);
    self.bottomL.textAlignment = NSTextAlignmentCenter;
}

@end
