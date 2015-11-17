//
//  StuPreSalaryInfo.h
//  yz-student
//
//  Created by 仲光磊 on 15/10/8.
//  Copyright © 2015年 cdq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StuPreSalaryInfo : NSObject
@property(nonatomic, copy)NSString *date;
@property(nonatomic, assign)double money;
@property(nonatomic, copy)NSString *status;

+(NSArray*)preSalaryInfoWithSessionId:(NSString*)sessionId;

@end
