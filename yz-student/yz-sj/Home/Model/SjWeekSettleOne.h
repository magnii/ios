//
//  SjWeekSettleOne.h
//  yz-student
//
//  Created by 仲光磊 on 15/11/9.
//  Copyright © 2015年 cdq. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum
{
    Settled = 0,
    Unsettled
}SettleType;

@interface SjWeekSettleOne : NSObject
@property(nonatomic, assign)long workDays;
@property(nonatomic, copy)NSString *days;
@property(nonatomic, copy)NSString *name;
@property(nonatomic, assign)int money;
@property(nonatomic, copy)NSString *memberId;
@property(nonatomic, copy)NSString *mobile;
@property(nonatomic, assign)int salary;

+(NSArray*)weekSettleOneWithJobId:(NSString*)jobId DateIds:(NSString*)dateIds SettleType:(SettleType)settleType;

@end
