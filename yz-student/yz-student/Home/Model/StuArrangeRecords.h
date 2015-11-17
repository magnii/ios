//
//  StuArrangeRecords.h
//  yz-student
//
//  Created by 仲光磊 on 15/9/22.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StuArrangeRecords : NSObject

@property(nonatomic, copy)NSString * recordId;
@property(nonatomic, copy)NSString * mobile;

+(NSArray*)loadArrangeRecordsWithJobId:(NSString*)jobId;

@end
