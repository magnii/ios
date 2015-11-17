//
//  SjWeekSettle.h
//  yz-student
//
//  Created by 仲光磊 on 15/11/9.
//  Copyright © 2015年 cdq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SjWeekSettle : NSObject

@property(nonatomic, copy)NSString *rangeDate;
@property(nonatomic, copy)NSString *dateIds;

+(NSArray*)weekDateListWithJobId:(NSString*)jobId;

@end
