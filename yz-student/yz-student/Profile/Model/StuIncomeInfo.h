//
//  StuIncomeInfo.h
//  yz-student
//
//  Created by 仲光磊 on 15/9/17.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StuIncomeInfo : NSObject

@property(nonatomic, copy)NSString *createTime;
@property(nonatomic, copy)NSString *amount;
@property(nonatomic, copy)NSString *dealType;//1:充值，2提现，3收入，4培训

+(NSArray*)incomeWithSessionId:(NSString *)sessionId DealType:(NSString*)dealType CurrentPage:(NSString*)currentPage PageSize:(NSString*)pageSize;

@end
