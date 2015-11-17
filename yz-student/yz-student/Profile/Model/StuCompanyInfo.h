//
//  StuCompanyInfo.h
//  yz-student
//
//  Created by 仲光磊 on 15/9/26.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StuCompanyInfo : NSObject

@property(nonatomic, strong)NSString *companyId;
@property(nonatomic, strong)NSString *createTime;
@property(nonatomic, strong)NSString *name;
@property(nonatomic, strong)NSString *contactNumber;
@property(nonatomic, strong)NSString *contactPerson;
@property(nonatomic, strong)NSString *gender;
@property(nonatomic, strong)NSString *loginName;
@property(nonatomic, strong)NSString *industry;
@property(nonatomic, strong)NSString *homePage;
@property(nonatomic, strong)NSString *points;
@property(nonatomic, strong)NSString *logoId;
@property(nonatomic, strong)NSString *cardId;
@property(nonatomic, strong)NSString *licenseId;
@property(nonatomic, strong)NSString *type;
@property(nonatomic, strong)NSString *attribute;
@property(nonatomic, strong)NSString *scale;
@property(nonatomic, strong)NSString *email;
@property(nonatomic, strong)NSString *address;
@property(nonatomic, strong)NSString *brifIntrodution;
@property(nonatomic, strong)NSString *cardIdStatus;
@property(nonatomic, strong)NSString *licenseIdStatus;
@property(nonatomic, strong)NSString *complete;


+(NSArray*)companyInfosWithSessionId:(NSString*)sessionId CurrentPage:(NSString*)currentPage PageSize:(NSString*)pageSize;

@end
