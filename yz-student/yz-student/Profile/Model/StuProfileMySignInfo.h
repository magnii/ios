//
//  StuProfileMySignInfo.h
//  yz-student
//
//  Created by 仲光磊 on 15/9/24.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StuProfileMySignInfo : NSObject
@property(nonatomic,copy)NSString *date;
@property(nonatomic,copy)NSString *dateId;
@property(nonatomic,copy)NSString *signInTime;
@property(nonatomic,copy)NSString *signOutTime;

+(instancetype)mySignInfoWithSessionId:(NSString*)sessionId JobId:(NSString*)jobId IsAgent:(NSString*)isAgent;

@end
