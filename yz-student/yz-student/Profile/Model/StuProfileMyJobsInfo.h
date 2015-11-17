//
//  StuProfileMyJobsInfo.h
//  yz-student
//
//  Created by 仲光磊 on 15/9/23.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StuProfileMyJobsInfo : NSObject

@property(nonatomic, strong)NSString *status;
@property(nonatomic, strong)NSString *date_id;
@property(nonatomic, strong)NSString *date;

+(NSArray*)myJobsInfoWithSessionId:(NSString*)sessionId JobId:(NSString*)jobId;

+(BOOL)canEstimageWithSessionId:(NSString*)sessionId JobId:(NSString*)jobId IsAgent:(NSString*)isAgent;

@end
