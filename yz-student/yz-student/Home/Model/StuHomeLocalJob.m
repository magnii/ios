//
//  StuHomeLocalJob.m
//  yz-student
//
//  Created by 仲光磊 on 15/9/5.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import "StuHomeLocalJob.h"
#import "StuJobDateObj.h"
#import "StuConfig.h"

@implementation StuHomeLocalJob

+ (NSString*)transfromCityNameToCityId:(NSString*)cityName
{
    NSString *ip = [NSString stringWithFormat:@"%@/weChat/city/getCityByCityName?cityName=%@&isApp=1", serverIp, cityName];
    NSString *newIp = [ip stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSError *error = [[NSError alloc]init];
    NSData *data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:newIp]] returningResponse:nil error:&error];
    
    NSDictionary *dict = [NSDictionary dictionary];
    if (error!=nil && data.length != 0) {
        dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    }
    return dict[@"id"];
}

+ (NSArray*)jobsWithCityId:(NSString *)cityId CurrentPage:(NSString *)currentPage PageSize:(NSString *)pageSize JobStatus:(NSString *)jobStatus
{
    NSString *strUrl = [NSString stringWithFormat:@"%@/weChat/job/findJobList?cityId=%@&currentPage=%@&pageSize=%@&jobStatus=%@", serverIp, cityId, currentPage, pageSize, jobStatus];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:strUrl]] returningResponse:nil error:nil];
    NSArray *arry = [NSArray array];
    if (data.length != 0) {
        arry = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    }
    
    return [StuHomeLocalJob jobsFromNetArray:arry];
}

+ (instancetype)nonArrangeJobWithJobId:(NSString *)jobId MemberId:(NSString *)memberId
{
    NSString *httpIp = [NSString stringWithFormat:@"%@/weChat/job/getJobById?id=%@&memberId=%@", serverIp, jobId, memberId];
    NSData *data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:httpIp]] returningResponse:nil error:nil];
    NSDictionary *dict = [NSDictionary dictionary];
    if (data.length != 0) {
        dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    }
    StuHomeLocalJob *job = [[StuHomeLocalJob alloc]init];
    job.recruitNum = [dict[@"recruitNum"] intValue];
    job.jobId = dict[@"id"];
    job.name = dict[@"name"];
    job.salary = [dict[@"salary"] intValue];
    job.unit = dict[@"unit"];
    job.settlementPeriod = dict[@"settlementPeriod"];
    job.isProvideStay = dict[@"isProvideStay"];
    job.isProvideMeal = dict[@"isProvideMeal"];
    NSString *tmpStr = dict[@"workingStartDate"];
    NSArray * array = [tmpStr componentsSeparatedByString:@" "];
    job.workingStartDate = array[0];
    tmpStr = dict[@"workingEndDate"];
    array = [tmpStr componentsSeparatedByString:@" "];
    job.workingEndDate = array[0];
    job.workingHours = dict[@"workingHours"];
    job.jobAddress = dict[@"address"];
    job.workContent = dict[@"workContent"];
    tmpStr = dict[@"genderLimit"];
    if ([tmpStr isEqualToString:@"m"]) {
        job.genderLimit = @"男";
    }
    else
    {
        job.genderLimit = @"女";
    }
    job.heightLimit = dict[@"heightLimit"];
    job.ageLimit = dict[@"ageLimit"];
    job.degreesLimit = dict[@"degreesLimit"];
    job.jobType = dict[@"jobType"];
    job.companyId = dict[@"companyId"];
    job.jobStatus = dict[@"jobStatus"];
    job.contactP = dict[@"contactP"];
    job.contactT = dict[@"contactT"];
    job.arrangedReward = [dict[@"arrangedReward"] intValue];
    job.recruits = dict[@"recruits"];
    job.isAgent = dict[@"isAgent"];
    job.specialRequired = dict[@"specialRequired"];
    
    NSArray *arrTmp = dict[@"signUps"];
    NSMutableArray *arrTmpM = [NSMutableArray array];
    if (arrTmp !=nil && ![arrTmp isKindOfClass:[NSString class]]) {
        for (NSDictionary *dict in arrTmp) {
            [arrTmpM addObject:dict[@"dateId"]];
        }
        job.signUpsArry = arrTmpM;
    }
    
    array = dict[@"jobDates"];
    NSMutableArray *arrayM = [NSMutableArray array];
    
    for (NSDictionary *dict in array) {
        StuJobDateObj *jobDate = [[StuJobDateObj alloc]init];
        jobDate.jobDateId = dict[@"id"];
        jobDate.jobDate = dict[@"date"];
        [arrayM addObject:jobDate];
    }
    job.jobDates = arrayM;
    
    return job;
}

+ (instancetype)arrangeJobWithJobId:(NSString *)jobId MemberId:(NSString *)memberId
{
    NSString *httpIp = [NSString stringWithFormat:@"%@/weChat/job/getJobInfosById4Arranged?id=%@&memberId=%@", serverIp, jobId, memberId];
    NSData *data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:httpIp]] returningResponse:nil error:nil];
    NSDictionary *dict = [NSDictionary dictionary];
    if (data.length != 0) {
        dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    }
    StuHomeLocalJob *job = [[StuHomeLocalJob alloc]init];
    job.recruitNum = [dict[@"recruitNum"] intValue];
    job.jobId = dict[@"id"];
    job.name = dict[@"name"];
    job.unit = dict[@"unit"];
    job.settlementPeriod = dict[@"settlementPeriod"];
    job.isProvideStay = dict[@"isProvideStay"];
    job.isProvideMeal = dict[@"isProvideMeal"];
    NSString *tmpStr = dict[@"workingStartDate"];
    NSArray * array = [tmpStr componentsSeparatedByString:@" "];
    job.workingStartDate = array[0];
    tmpStr = dict[@"workingEndDate"];
    array = [tmpStr componentsSeparatedByString:@" "];
    job.workingEndDate = array[0];
    job.workingHours = dict[@"workingHours"];
    job.jobAddress = dict[@"address"];
    job.workContent = dict[@"workContent"];
    //job.parseArea = dict[@"parseArea"];
    tmpStr = dict[@"genderLimit"];
    if ([tmpStr isEqualToString:@"m"]) {
        job.genderLimit = @"男";
    }
    else
    {
        job.genderLimit = @"女";
    }
    job.heightLimit = dict[@"heightLimit"];
    job.ageLimit = dict[@"ageLimit"];
    job.degreesLimit = dict[@"degreesLimit"];
    job.jobType = dict[@"jobType"];
    job.companyId = dict[@"companyId"];
    job.jobStatus = dict[@"jobStatus"];
    job.contactP = dict[@"contactP"];
    job.contactT = dict[@"contactT"];
    job.arrangedReward = [dict[@"arrangedReward"] intValue];
    job.salary = (int)([dict[@"salary"] doubleValue] - job.arrangedReward);
    job.isArranged = dict[@"isArranged"];
    job.recruits = dict[@"recruits"];
    job.isAgent = dict[@"isAgent"];
    job.specialRequired = dict[@"specialRequired"];
    job.arrangedDateIds = dict[@"arrangedDateIds"];
    
    array = dict[@"jobDates"];
    NSMutableArray *arrayM = [NSMutableArray array];
    
    for (NSDictionary *dict in array) {
        StuJobDateObj *jobDate = [[StuJobDateObj alloc]init];
        jobDate.jobDateId = dict[@"id"];
        //将年份去掉
        NSString *jobDateDateTmp = dict[@"date"];
        jobDate.jobDate = [[jobDateDateTmp componentsSeparatedByString:@"年"]lastObject];
        [arrayM addObject:jobDate];
    }
    job.jobDates = arrayM;
    
    //isArranged被别人包办，长度是array.count，1为被包办，0为没有被包办
    NSMutableArray *arrangeArrayM = [NSMutableArray array];
    for (int i=0; i<job.jobDates.count; i++) {
        StuJobDateObj *jobDate = [job.jobDates objectAtIndex:i];
        jobDate.isArranged = [job.isArranged objectAtIndex:i];
        
        [arrangeArrayM addObject:jobDate];
    }
    
    //根据job.arrangedDateIds 循环jobDate，得到具体是哪天被我包办的
    NSMutableArray *myArrangeArrayM = [NSMutableArray array];
    for (StuJobDateObj *jobDate in arrangeArrayM) {
        //数据有问题，传的是string空串，而不是空数组
        if (job.arrangedDateIds!=nil && ![job.arrangedDateIds isEqual:@""] && job.arrangedDateIds.count!=0) {
            for (NSString *str in job.arrangedDateIds) {
                if ([str isEqualToString:jobDate.jobDateId]) {
                    jobDate.isMyArranged = str;
                }
            }
        }
        [myArrangeArrayM addObject:jobDate];
    }
    
    job.jobDates = myArrangeArrayM;
    
    return job;
}

+ (NSArray *)jobsFromNetArray:(NSArray *)arry
{
    NSMutableArray *arryM = [NSMutableArray array];
    if (arry == nil || arry.count == 0) {
        return arryM;
    }
    for (NSDictionary *dict in arry) {
        StuHomeLocalJob *job = [[StuHomeLocalJob alloc]init];
        job.name = dict[@"name"];
        job.recruitNum = [dict[@"recruitNum"] intValue];
        //job.salary = [dict[@"salary"] doubleValue];
        job.unit = dict[@"unit"];
        job.settlementPeriod = dict[@"settlementPeriod"];
        job.isProvideStay = dict[@"isProvideStay"];
        job.isProvideMeal = dict[@"isProvideMeal"];
        job.workingStartDate = dict[@"workingStartDate"];
        job.workingEndDate = dict[@"workingEndDate"];
        job.workingHours = dict[@"workingHours"];
        job.workContent = dict[@"workContent"];
        job.genderLimit = dict[@"genderLimit"];
        job.heightLimit = dict[@"heightLimit"];
        job.ageLimit = dict[@"ageLimit"];
        job.degreesLimit = dict[@"degreesLimit"];
        job.jobType = dict[@"jobType"];
        job.parseArea = dict[@"parseArea"];
        job.jobAddress = dict[@"address"];
        job.specialRequired = dict[@"specialRequired"];
        job.isAgent = dict[@"isAgent"];
        job.jobId = dict[@"id"];
        job.arrangedReward = [dict[@"arrangedReward"] intValue];
        job.salary = (int)([dict[@"salary"] doubleValue] - job.arrangedReward);
        job.isArranged = dict[@"isArranged"];
        [arryM addObject:job];
    }
    return arryM;
}

+ (NSArray*)highSalaryJobsWithCityId:(NSString *)cityId CurrentPage:(NSString *)currentPage PageSize:(NSString *)pageSize JobStatus:(NSString *)jobStatus SalaryLeast:(NSString*)salary
{
    return [StuHomeLocalJob jobsWithCityId:cityId AreaId:nil TypeId:nil CurrentPage:currentPage PageSize:pageSize Period:nil Lng:nil Lat:nil Radius:nil Cond:@"unit,salary" Value:[NSString stringWithFormat:@"元/天,%@", salary] JobStatus:@"ongoing"];
}

+ (NSArray*)arrangeJobsWithCityId:(NSString *)cityId CurrentPage:(NSString *)currentPage PageSize:(NSString *)pageSize JobStatus:(NSString *)jobStatus
{
    return [StuHomeLocalJob jobsWithCityId:cityId AreaId:nil TypeId:nil CurrentPage:currentPage PageSize:pageSize Period:nil Lng:nil Lat:nil Radius:nil Cond:@"isAgent" Value:@"1" JobStatus:@"ongoing"];
}

+(NSArray*)nearByJobsWithCityId:(NSString *)cityId TypeId:(NSString*)typeId CurrentPage:(NSString *)currentPage PageSize:(NSString *)pageSize Period:(NSString*)period JobStatus:(NSString *)jobStatus Lng:(NSString*)lng Lat:(NSString*)lat Radius:(NSString*)radius
{
    return [StuHomeLocalJob jobsWithCityId:cityId AreaId:nil TypeId:typeId CurrentPage:currentPage PageSize:pageSize Period:period Lng:lng Lat:lat Radius:[NSString stringWithFormat:@"%d", radius.intValue] Cond:nil Value:nil JobStatus:jobStatus];
}

//****************根据不同参数获取兼职通用接口，以后将不再使用上面的接口*****************
+ (NSArray*)jobsWithCityId:(NSString *)cityId AreaId:(NSString*)areaId TypeId:(NSString*)typeId CurrentPage:(NSString *)currentPage PageSize:(NSString *)pageSize Period:(NSString*)period Lng:(NSString*)lng Lat:(NSString*)lat Radius:(NSString*)radius Cond:(NSString*)cond Value:(NSString*)value JobStatus:(NSString *)jobStatus
{
    if (typeId == nil)
        typeId=@"";
    if (period == nil)
        period=@"";
    if (lng == nil)
        lng = @"";
    if (lat == nil)
        lat = @"";
    if (radius == nil)
        radius = @"";
    if (cond == nil)
        cond = @"";
    if (value == nil)
        value = @"";
    if (jobStatus == nil)
        jobStatus = @"";
    if (areaId == nil) {
        areaId = @"";
    }
    
    
    NSString *strUrl = [NSString stringWithFormat:@"%@/weChat/job/findJobList?cityId=%@&areaId=%@&typeId=%@&currentPage=%@&pageSize=%@&period=%@&lng=%@&lat=%@&radius=%@&cond=%@&value=%@&jobStatus=%@&isApp=1", serverIp, cityId, areaId, typeId,currentPage, pageSize, period, lng, lat, radius, cond, value, jobStatus];
    
    NSString *newIp = [strUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:newIp]] returningResponse:nil error:nil];
    NSArray *arry = [NSArray array];
    if (data.length != 0) {
        arry = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    }
    
    return [StuHomeLocalJob jobsFromNetArray:arry];
}

+ (NSArray *)jobsWithSessionId:(NSString *)sessionId CurrentPage:(NSString *)currentPage PageSize:(NSString *)pageSize
{
    NSString *strUrl = [NSString stringWithFormat:@"%@/weChat/job/getMyJob?memberId=%@&currentPage=%@&pageSize=%@", serverIp, sessionId, currentPage, pageSize];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:strUrl]] returningResponse:nil error:nil];
    NSArray *arry = [NSArray array];
    if (data.length != 0) {
        arry = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    }
    
    return [StuHomeLocalJob jobsFromNetArray:arry];
}

+(NSArray*)arrangeJobsWithSessionId:(NSString*)sessionId CurrentPage:(NSString*)currentPage PageSize:(NSString*)pageSize
{
    NSString *strUrl = [NSString stringWithFormat:@"%@/weChat/arrangedRecrod/getRecordsByMemberId?memberId=%@&currentPage=%@&pageSize=%@", serverIp, sessionId, currentPage, pageSize];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:strUrl]] returningResponse:nil error:nil];
    NSArray *arry = [NSArray array];
    if (data.length != 0) {
        arry = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    }
    NSMutableArray *arryM = [NSMutableArray array];
    
    for (NSDictionary *dictTmp in arry)
    {
        NSDictionary *dict = dictTmp[@"job"];
        [arryM addObject:dict];
    }
    return [StuHomeLocalJob jobsFromNetArray:arryM];
}

+ (BOOL)isSavedJobWithSessionId:(NSString *)sessionId JobId:(NSString *)jobId
{
    NSString *strUrl = [NSString stringWithFormat:@"%@/weChat/storeRecords/findStoreByCond?memberId=%@&jobId=%@", serverIp, sessionId, jobId];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:strUrl]] returningResponse:nil error:nil];
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    if ([str isEqual:@"\"error\""]) {
        return NO;
    }
    else
    {
        return YES;
    }
}

+ (BOOL)saveJobWithSessionId:(NSString *)sessionId JobId:(NSString *)jobId
{
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/weChat/storeRecords/saveStoreRecords", serverIp]];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:URL];
    request.timeoutInterval=5.0;//设置请求超时为5秒
    request.HTTPMethod=@"POST";//设置请求方法
    
    //设置请求体
    NSString *param=[NSString stringWithFormat:@"memberId=%@&jobId=%@",sessionId, jobId];
    //把拼接后的字符串转换为data，设置请求体
    request.HTTPBody=[param dataUsingEncoding:NSUTF8StringEncoding];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    if ([str isEqual:@"\"error\""]) {
        return NO;
    }
    else
    {
        return YES;
    }
}

+ (NSArray *)savedJobsWithSession:(NSString *)sessionId CurrentPage:(NSString *)currentpage PageSize:(NSString *)pageSize
{
    NSString *strUrl = [NSString stringWithFormat:@"%@/weChat/storeRecords/getByMemberId?memberId=%@&currentPage=%@&pageSize=%@", serverIp, sessionId, currentpage, pageSize];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:strUrl]] returningResponse:nil error:nil];
    NSArray *arry = [NSArray array];
    if (data.length != 0) {
        arry = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    }
    NSMutableArray *arryM = [NSMutableArray array];
    
    if (arry != nil && arry.count != 0) {
        for (NSDictionary *dict in arry)
        {
            StuHomeLocalJob *job = [[StuHomeLocalJob alloc]init];
            job.name = dict[@"name"];
            job.recruitNum = [dict[@"recruitNum"] intValue];
            //job.salary = [dict[@"salary"] doubleValue];
            job.unit = dict[@"unit"];
            job.settlementPeriod = dict[@"settlementPeriod"];
            job.isProvideStay = dict[@"isProvideStay"];
            job.isProvideMeal = dict[@"isProvideMeal"];
            job.workingStartDate = dict[@"workingStartDate"];
            job.workingEndDate = dict[@"workingEndDate"];
            job.workingHours = dict[@"workingHours"];
            job.workContent = dict[@"workContent"];
            job.genderLimit = dict[@"genderLimit"];
            job.heightLimit = dict[@"heightLimit"];
            job.ageLimit = dict[@"ageLimit"];
            job.degreesLimit = dict[@"degreesLimit"];
            job.jobType = dict[@"jobType"];
            job.parseArea = dict[@"parseArea"];
            job.jobAddress = dict[@"address"];
            job.specialRequired = dict[@"specialRequired"];
            job.isAgent = dict[@"isAgent"];
            job.jobId = dict[@"id"];
            job.arrangedReward = [dict[@"arrangedReward"] intValue];
            job.salary = (int)([dict[@"salary"] doubleValue] - job.arrangedReward);
            job.isArranged = dict[@"isArranged"];
            [arryM addObject:job];
        }
    }
    return arryM;
}

+ (NSArray*)preSalaryWithCityId:(NSString*)cityId AreaId:(NSString*)areaId TypeId:(NSString*)typeId Period:(NSString*)period JobStatus:(NSString*)jobStatus CurrentPage:(NSString*)currentPage PageSize:(NSString*)pageSize
{
    NSString *strUrl = [NSString stringWithFormat:@"%@/weChat/job/findJobList4Advance?cityId=%@&areaId=%@&typeId=%@&period=%@&jobStatus=%@&currentPage=%@&pageSize=%@", serverIp, cityId, areaId, typeId, period, jobStatus, currentPage, pageSize];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:strUrl]] returningResponse:nil error:nil];
    NSArray *arry = [NSArray array];
    if (data.length != 0) {
        arry = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    }
    NSMutableArray *arryM = [NSMutableArray array];
    
    if (arry != nil && arry.count != 0) {
        for (NSDictionary *dict in arry)
        {
            StuHomeLocalJob *job = [[StuHomeLocalJob alloc]init];
            job.name = dict[@"name"];
            job.recruitNum = [dict[@"recruitNum"] intValue];
            //job.salary = [dict[@"salary"] doubleValue];
            job.unit = dict[@"unit"];
            job.settlementPeriod = dict[@"settlementPeriod"];
            job.isProvideStay = dict[@"isProvideStay"];
            job.isProvideMeal = dict[@"isProvideMeal"];
            job.workingStartDate = dict[@"workingStartDate"];
            job.workingEndDate = dict[@"workingEndDate"];
            job.workingHours = dict[@"workingHours"];
            job.workContent = dict[@"workContent"];
            job.genderLimit = dict[@"genderLimit"];
            job.heightLimit = dict[@"heightLimit"];
            job.ageLimit = dict[@"ageLimit"];
            job.degreesLimit = dict[@"degreesLimit"];
            job.jobType = dict[@"jobType"];
            job.parseArea = dict[@"parseArea"];
            job.jobAddress = dict[@"address"];
            job.specialRequired = dict[@"specialRequired"];
            job.isAgent = dict[@"isAgent"];
            job.jobId = dict[@"id"];
            job.arrangedReward = [dict[@"arrangedReward"] intValue];
            job.salary = (int)([dict[@"salary"] doubleValue] - job.arrangedReward);
            job.isArranged = dict[@"isArranged"];
            [arryM addObject:job];
        }
    }
    
    return arryM;
}

@end
