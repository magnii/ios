//
//  StuProfileMyInfo.h
//  yz-student
//
//  Created by 仲光磊 on 15/9/18.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StuProfileMyInfo : NSObject

@property(nonatomic, copy)NSString *infoId;
@property(nonatomic, copy)NSString *createTime;
@property(nonatomic, copy)NSString *content;
@property(nonatomic, copy)NSString *isRead;

+(NSArray*)myInfoWithSessionId:(NSString*)sessionId;

@end
