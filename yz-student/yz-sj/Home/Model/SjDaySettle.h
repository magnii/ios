//
//  SjDaySettle.h
//  yz-student
//
//  Created by 仲光磊 on 15/11/5.
//  Copyright © 2015年 cdq. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum
{
    Settled = 0,
    Unsettled
}SettleType;

@interface SjDaySettle : NSObject

@property(nonatomic, copy)NSString *dayDateId;
@property(nonatomic, copy)NSString *dayDateStr;
@property(nonatomic, strong)NSArray *daySettleArry;//class SjOneRegisMember

+(NSArray*)daySettleListWithJobId:(NSString*)jobId SettleType:(SettleType)settleType;

@end
