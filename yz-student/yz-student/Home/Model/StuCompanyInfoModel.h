//
//  StuCompanyInfo.h
//  yz-student
//
//  Created by 仲光磊 on 15/9/9.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StuCompanyInfoModel : NSObject

@property(nonatomic, copy)NSString *companyId;
@property(nonatomic, copy)NSString *name;
@property(nonatomic, copy)NSString *contactNumber;
@property(nonatomic, copy)NSString *contactPerson;
@property(nonatomic, copy)NSString *logoImage;
@property(nonatomic, copy)NSArray *jobs;
@property(nonatomic, assign)int jobsNumber;
@property(nonatomic, assign)int concernedCounts;
@property(nonatomic, copy)NSString *createTime;
@property(nonatomic, copy)NSString *brifIntrodution;
@property(nonatomic, assign)BOOL isAttentioned;

+ (instancetype)companyDetailCheckWithCompanyId:(NSString*)companyId;
+ (BOOL)companyAttentionWithCompanyId:(NSString *)companyId MemberId:(NSString*)memberId;
+ (double)companyScoreCheckWithCompanyId:(NSString*)companyId;
+(BOOL)isAttentionWithCompanyId:(NSString*)companyId SessionId:(NSString*)sessionId;


@end
