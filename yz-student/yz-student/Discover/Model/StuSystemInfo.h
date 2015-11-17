//
//  StuSystemInfo.h
//  yz-student
//
//  Created by 仲光磊 on 15/9/15.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StuSystemInfo : NSObject
@property(nonatomic, copy) NSString *infoId;
@property(nonatomic, copy) NSString *createTime;
@property(nonatomic, copy) NSString *isRead;
@property(nonatomic, copy) NSString *content;

+(NSArray*)getSystemInfoWithInfoType:(NSString*)infoType;
@end
