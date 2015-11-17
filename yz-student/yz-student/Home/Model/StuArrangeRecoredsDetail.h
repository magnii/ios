//
//  StuArrangeRecoredsDetail.h
//  yz-student
//
//  Created by 仲光磊 on 15/9/22.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StuArrangeRecoredsDetail : NSObject

@property(nonatomic, strong)NSArray *recruitsArray;
@property(nonatomic, strong)NSArray *mySignArray;
@property(nonatomic, strong)NSArray *dateArray;
@property(nonatomic, strong)NSArray *dateIdArray;

@property(nonatomic, copy)NSString *command;
@property(nonatomic, assign)long recruitNum;

+(instancetype)loadArrangeRecordsDetailWithSessionId:(NSString*)sessionId JobId:(NSString*)jobId RecordId:(NSString*)recordId;

@end
