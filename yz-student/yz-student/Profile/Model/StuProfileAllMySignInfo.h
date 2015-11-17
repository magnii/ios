//
//  StuProfileAllMySignInfo.h
//  yz-student
//
//  Created by 仲光磊 on 15/9/24.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StuProfileAllMySignInfo : NSObject

@property(nonatomic,copy)NSString *date;
@property(nonatomic,copy)NSString *signInTime;
@property(nonatomic,copy)NSString *signInAddress;
@property(nonatomic,copy)NSString *signOutTime;
@property(nonatomic,copy)NSString *signOutAddress;

+(NSArray*)allMySignInfoWithSessionId:(NSString*)sessionId JobId:(NSString*)jobId IsAgent:(NSString*)isAgent;

+(BOOL)signInOutWithSessionId:(NSString*)sessionId DateId:(NSString*)dateId IsAgent:(NSString*)isAgent Address:(NSString*)address InOrOut:(NSString*)inOrOut;

@end
