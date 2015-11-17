//
//  SjJobInfo.m
//  yz-student
//
//  Created by 仲光磊 on 15/10/22.
//  Copyright © 2015年 cdq. All rights reserved.
//

#import "SjJobInfo.h"
#import "StuConfig.h"

@implementation SjJobInfo

+(instancetype)sjJobDetailWithJobId:(NSString *)jobId
{
    NSString *httpIp = [NSString stringWithFormat:@"%@/web/enterprise/getJobDetail?jobId=%@", sjIp, jobId];
    NSData *data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:httpIp]] returningResponse:nil error:nil];
    NSArray *arry = [NSArray array];
    if (data.length != 0) {
        arry = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    }
    
    SjJobInfo *jobInfo = [self translateWithDict:arry.firstObject];
    jobInfo.jobId = jobId;
    
    return jobInfo;
}

+(instancetype)translateWithDict:(NSDictionary*)dict
{
    SjJobInfo *jobInfo = [[SjJobInfo alloc]init];
    jobInfo.jobType = dict[@"jobType"];
    jobInfo.workContent = dict[@"workContent"];
    jobInfo.workingHours = dict[@"workingHours"];
    if ([dict[@"isAgent"] isEqualToString:@"1"]) {
        jobInfo.isAgent = @"包办";
        jobInfo.arrangedReward = [dict[@"arrangedReward"] intValue];
    }
    else
    {
        jobInfo.isAgent = @"非包办";
    }
    
    NSString *settlementStr = dict[@"settlementPeriod"];
    if ([settlementStr isEqualToString:@"day"]) {
        jobInfo.settlementPeriod = @"日结";
    }
    else if ([settlementStr isEqualToString:@"week"])
    {
        jobInfo.settlementPeriod = @"周结";
        NSString *accountDayStr= dict[@"accountDay"];
        if ([accountDayStr isEqualToString:@"1"]) {
            jobInfo.accountDay = @"周一";
        }
        else if ([accountDayStr isEqualToString:@"2"])
        {
            jobInfo.accountDay = @"周二";
        }
        else if ([accountDayStr isEqualToString:@"3"])
        {
            jobInfo.accountDay = @"周三";
        }
        else if ([accountDayStr isEqualToString:@"4"])
        {
            jobInfo.accountDay = @"周四";
        }
        else if ([accountDayStr isEqualToString:@"5"])
        {
            jobInfo.accountDay = @"周五";
        }
        else if ([accountDayStr isEqualToString:@"6"])
        {
            jobInfo.accountDay = @"周六";
        }
        else if ([accountDayStr isEqualToString:@"7"])
        {
            jobInfo.accountDay = @"周日";
        }
        
    }
    else if ([settlementStr isEqualToString:@"month"])
    {
        jobInfo.settlementPeriod = @"月结";
        jobInfo.accountDay = [NSString stringWithFormat:@"%@号", dict[@"accountDay"]];
    }
    else if ([settlementStr isEqualToString:@"end"])
    {
        jobInfo.settlementPeriod = @"完工结";
    }
    
    NSString *genderStr = dict[@"genderLimit"];
    if ([genderStr isEqualToString:@"m"])
    {
        jobInfo.genderLimit = @"男";
    }
    else if ([genderStr isEqualToString:@"n"])
    {
        jobInfo.genderLimit = @"女";
    }
    else
    {
        jobInfo.genderLimit = @"不限";
    }
    
    jobInfo.address = dict[@"address"];
    jobInfo.salary = (int)[dict[@"salary"] doubleValue];
    
    jobInfo.recruitNum = [dict[@"recruitNum"] intValue];
    jobInfo.specialRequired = dict[@"specialRequired"];
    if ([dict[@"heightLimit"] isEqualToString:@"n"]) {
        jobInfo.heightLimit = @"不限";
    }
    else
    {
        jobInfo.heightLimit = dict[@"heightLimit"];
    }
    if ([dict[@"isProvideStay"] isEqualToString:@"1"]) {
        jobInfo.isProvideStay = @"是";
    }
    else
    {
        jobInfo.isProvideStay = @"否";
    }
    
    if ([dict[@"isProvideMeal"] isEqualToString:@"1"]) {
        jobInfo.isProvideMeal = @"是";
    }
    else
    {
        jobInfo.isProvideMeal = @"否";
    }
    
    jobInfo.workingStartDate = dict[@"workingStartDate"];
    jobInfo.workingEndDate = dict[@"workingEndDate"];
    jobInfo.city = dict[@"city"];
    jobInfo.area = dict[@"area"];
    jobInfo.name = dict[@"name"];
    jobInfo.province = dict[@"province"];
    jobInfo.contactP = dict[@"contactP"];
    jobInfo.contactT = dict[@"contactT"];
    return jobInfo;
}

@end
