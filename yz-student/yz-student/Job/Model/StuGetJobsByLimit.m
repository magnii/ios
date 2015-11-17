//
//  StuGetJobsByLimit.m
//  yz-student
//
//  Created by 仲光磊 on 15/9/13.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import "StuGetJobsByLimit.h"
#import "StuConfig.h"
#import "StuCityAreasId.h"
#import "StuCityJobTypeId.h"

extern NSString *globalCityName;
extern NSString *globalCityId;

@implementation StuGetJobsByLimit

+ (instancetype)getCityAreasJobTypeWithCityId:(NSString *)cityId
{
    StuGetJobsByLimit *jobsByLimit = [[StuGetJobsByLimit alloc]init];
    
    NSString *ip = [NSString stringWithFormat:@"%@/weChat/dictionary/getConditionsByCityId?cityId=%@", serverIp, cityId];
    NSError *error = [[NSError alloc]init];
    NSData *data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:ip]] returningResponse:nil error:&error];
    
    NSDictionary *dict = [NSDictionary dictionary];
    if (error!=nil && data.length != 0) {
        dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    }
    
    NSArray *jobType = dict[@"jobTypes"];
    NSMutableArray *jobtypesM = [NSMutableArray array];
    for (NSDictionary *dictJobTypes in jobType) {
        StuCityJobTypeId *jobType = [[StuCityJobTypeId alloc]init];
        jobType.jobTypeName = dictJobTypes[@"name"];
        jobType.jobTypeId = dictJobTypes[@"id"];
        
        [jobtypesM addObject:jobType];
    }
    
    jobsByLimit.jobTypes = jobtypesM;
    
    NSArray *jobAreas = dict[@"areas"];
    NSMutableArray *jobAreasM = [NSMutableArray array];
    for (NSDictionary *dictCityArea in jobAreas) {
        StuCityAreasId *jobArea = [[StuCityAreasId alloc]init];
        jobArea.cityAreaName = dictCityArea[@"name"];
        jobArea.cityAreaId = dictCityArea[@"id"];
        
        [jobAreasM addObject:jobArea];
    }
    
    jobsByLimit.cityareas = jobAreasM;
    
    return jobsByLimit;
}

@end
