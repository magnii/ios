//
//  StuRedPackageInfo.h
//  yz-student
//
//  Created by 仲光磊 on 15/9/17.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StuRedPackageInfo : NSObject

@property(nonatomic, copy)NSString *redPackageId;
@property(nonatomic, copy)NSString *createTime;
@property(nonatomic, assign)int money;
@property(nonatomic, copy)NSString *received;
@property(nonatomic, copy)NSString *desc;

+(NSArray*)redPackageWithSessionId:(NSString *)sessionId CurrentPage:(NSString*)currentPage PageSize:(NSString*)pageSize;

//+(void)openRedPackageWithSessionId:(NSString*)sessionId RedPackageId:(NSString*)redPackageId Money:(NSString*)money;

@end
