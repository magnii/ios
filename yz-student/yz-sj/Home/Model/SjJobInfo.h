//
//  SjJobInfo.h
//  yz-student
//
//  Created by 仲光磊 on 15/10/22.
//  Copyright © 2015年 cdq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SjJobInfo : NSObject
//{"workDate":"2015-10-20至2015-11-20","workContent":"的点点滴滴","workingHours":"07:00-16:00","isAgent":"0","settlementPeriod":"日结","genderLimit":"不限","address":"长江路230号","salary":"100.0元/天","recruitNum":"1人","specialRequired":" 对对对对对对","heightLimit":"不限"}
@property(nonatomic, copy) NSString *jobType;
@property(nonatomic, copy) NSString *workContent;
@property(nonatomic, copy) NSString *workingHours;
@property(nonatomic, copy) NSString *isProvideStay;
@property(nonatomic, copy) NSString *isProvideMeal;
@property(nonatomic, copy) NSString *workingStartDate;
@property(nonatomic, copy) NSString *workingEndDate;
@property(nonatomic, copy) NSString *city;
@property(nonatomic, copy) NSString *area;
@property(nonatomic, copy) NSString *isAgent;
@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSString *province;
@property(nonatomic, copy) NSString *contactP;
@property(nonatomic, copy) NSString *contactT;
@property(nonatomic, copy) NSString *settlementPeriod;
@property(nonatomic, copy) NSString *genderLimit;
@property(nonatomic, copy) NSString *address;
@property(nonatomic, assign) int salary;
@property(nonatomic, assign) int recruitNum;
@property(nonatomic, assign) int arrangedReward;
@property(nonatomic, copy) NSString *specialRequired;
@property(nonatomic, copy) NSString *heightLimit;
@property(nonatomic, copy) NSString *accountDay;
@property(nonatomic, copy) NSString *jobId;

+(instancetype)sjJobDetailWithJobId:(NSString*)jobId;

@end
