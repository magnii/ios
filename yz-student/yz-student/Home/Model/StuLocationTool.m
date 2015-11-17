//
//  StuLocalCityInfo.m
//  yz-student
//
//  Created by 仲光磊 on 15/9/4.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import "StuLocation.h"
#import "StuLocationTool.h"

#define LocationPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"StuLocation.archive"]

@implementation StuLocationTool

+ (StuLocation *)location
{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:LocationPath];
}

+ (void)saveLocation:(StuLocation *)location
{
    [NSKeyedArchiver archiveRootObject:location toFile:LocationPath];
}

@end

