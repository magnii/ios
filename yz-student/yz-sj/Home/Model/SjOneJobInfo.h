//
//  SjOneJobInfo.h
//  yz-student
//
//  Created by 仲光磊 on 15/10/22.
//  Copyright © 2015年 cdq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SjOneJobInfo : NSObject

@property(nonatomic, copy)NSString *jobId;
@property(nonatomic, copy)NSString *jobType;
@property(nonatomic, copy)NSString *createTime;
@property(nonatomic, copy)NSString *isAgent;
@property(nonatomic, copy)NSString *name;

+(NSArray*)sjJobsWithMemberId:(NSString*)memberId JobStatus:(NSString*)jobStatus MinResult:(NSString*)minResult MaxResult:(NSString*)maxResult;

@end
