//
//  StuProfileMySignInfo.m
//  yz-student
//
//  Created by 仲光磊 on 15/9/24.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import "StuProfileMySignInfo.h"
#import "StuConfig.h"

@implementation StuProfileMySignInfo

+ (instancetype)mySignInfoWithSessionId:(NSString *)sessionId JobId:(NSString *)jobId IsAgent:(NSString *)isAgent
{
    StuProfileMySignInfo *info = [[StuProfileMySignInfo alloc]init];
    
    NSString *strUrl = [NSString stringWithFormat:@"%@/weChat/member/getCrrentDate?memberId=%@&jobId=%@&isAgent=%@", serverIp, sessionId, jobId, isAgent];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:strUrl]] returningResponse:nil error:nil];
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    
    info.date = dict[@"date"];
    info.dateId = dict[@"dateId"];
    info.signInTime = dict[@"signInTime"];
    info.signOutTime = dict[@"signOutTime"];
    
    return info;
}

@end
