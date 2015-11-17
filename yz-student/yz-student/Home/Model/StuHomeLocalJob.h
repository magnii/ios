//
//  StuHomeLocalJob.h
//  yz-student
//
//  Created by 仲光磊 on 15/9/5.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StuHomeLocalJob : NSObject

@property (nonatomic, assign)int recruitNum;
@property (nonatomic, copy)NSString *name;
@property (nonatomic, assign)int salary;
@property (nonatomic, copy)NSString *unit;
@property (nonatomic, copy)NSString *settlementPeriod;//"settlementPeriod":"day"
@property (nonatomic, copy)NSString *isProvideStay;//是否提供住宿0非1是;
@property (nonatomic, copy)NSString *isProvideMeal;//是否提供工作餐0非1是
@property (nonatomic, copy)NSString *workingStartDate;
@property (nonatomic, copy)NSString *workingEndDate;
@property (nonatomic, copy)NSString *workingHours;
@property (nonatomic, copy)NSString *jobAddress;
@property (nonatomic, copy)NSString *workContent;
@property (nonatomic, copy)NSString *parseArea;

@property (nonatomic, copy)NSString *genderLimit;
@property (nonatomic, copy)NSString *heightLimit;
@property (nonatomic, copy)NSString *ageLimit;
@property (nonatomic, copy)NSString *degreesLimit;
@property (nonatomic, copy)NSString *specialRequired;

@property (nonatomic, copy)NSString *isAgent;
@property (nonatomic, copy)NSString *jobType;

@property (nonatomic, copy)NSString *jobId;
@property (nonatomic, copy)NSString *companyId;

@property (nonatomic, copy)NSString *jobStatus;
@property (nonatomic, copy)NSString *contactP;
@property (nonatomic, copy)NSString *contactT;
@property (nonatomic, copy)NSString *viewCount;
@property (nonatomic, assign)int arrangedReward;
@property (nonatomic, strong)NSArray *recruits;
@property (nonatomic, copy)NSArray *jobDates;
@property (nonatomic, strong)NSArray *isArranged;
@property (nonatomic, strong)NSArray *arrangedDateIds;
@property (nonatomic, strong)NSArray *signUpsArry;

+ (NSString*)transfromCityNameToCityId:(NSString*)cityName;

+ (NSArray*)jobsWithCityId:(NSString *)cityId CurrentPage:(NSString *)currentPage PageSize:(NSString *)pageSize JobStatus:(NSString *)jobStatus;

+ (instancetype)nonArrangeJobWithJobId:(NSString*)jobId MemberId:(NSString*)memberId;
+ (instancetype)arrangeJobWithJobId:(NSString*)jobId MemberId:(NSString*)memberId;
+ (NSArray*)jobsFromNetArray:(NSArray*)arry;
+ (NSArray*)highSalaryJobsWithCityId:(NSString *)cityId CurrentPage:(NSString *)currentPage PageSize:(NSString *)pageSize JobStatus:(NSString *)jobStatus SalaryLeast:(NSString*)salary;

+ (NSArray*)arrangeJobsWithCityId:(NSString *)cityId CurrentPage:(NSString *)currentPage PageSize:(NSString *)pageSize JobStatus:(NSString *)jobStatus;
+(NSArray*)nearByJobsWithCityId:(NSString *)cityId TypeId:(NSString*)typeId CurrentPage:(NSString *)currentPage PageSize:(NSString *)pageSize Period:(NSString*)period JobStatus:(NSString *)jobStatus Lng:(NSString*)lng Lat:(NSString*)lat Radius:(NSString*)radius;
+ (NSArray*)jobsWithCityId:(NSString *)cityId AreaId:(NSString*)areaId TypeId:(NSString*)typeId CurrentPage:(NSString *)currentPage PageSize:(NSString *)pageSize Period:(NSString*)period Lng:(NSString*)lng Lat:(NSString*)lat Radius:(NSString*)radius Cond:(NSString*)cond Value:(NSString*)value JobStatus:(NSString *)jobStatus;
+ (NSArray*)jobsWithSessionId:(NSString*)sessionId CurrentPage:(NSString *)currentPage PageSize:(NSString *)pageSize;
+ (NSArray*)arrangeJobsWithSessionId:(NSString*)sessionId CurrentPage:(NSString*)currentPage PageSize:(NSString*)pageSize;

+ (BOOL)isSavedJobWithSessionId:(NSString*)sessionId JobId:(NSString*)jobId;
+ (BOOL)saveJobWithSessionId:(NSString*)sessionId JobId:(NSString*)jobId;

+ (NSArray*)savedJobsWithSession:(NSString*)sessionId CurrentPage:(NSString*)currentpage PageSize:(NSString*)pageSize;
+ (NSArray*)preSalaryWithCityId:(NSString*)cityId AreaId:(NSString*)areaId TypeId:(NSString*)typeId Period:(NSString*)period JobStatus:(NSString*)jobStatus CurrentPage:(NSString*)currentPage PageSize:(NSString*)pageSize;
@end
