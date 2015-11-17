//
//  StuProfileBBInfo.h
//  yz-student
//
//  Created by 仲光磊 on 15/9/20.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StuProfileBBInfo : NSObject

@property(nonatomic, copy)NSString *command;
@property(nonatomic, copy)NSString *recordId;
@property(nonatomic, strong)NSArray *recordDatesArry;

+(instancetype)bbJobsWithSessionId:(NSString*)sessionId JobId:(NSString*)jobId;

@end
