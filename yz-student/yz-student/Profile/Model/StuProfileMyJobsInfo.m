//
//  StuProfileMyJobsInfo.m
//  yz-student
//
//  Created by 仲光磊 on 15/9/23.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import "StuProfileMyJobsInfo.h"
#import "StuConfig.h"

@implementation StuProfileMyJobsInfo

+ (NSArray *)myJobsInfoWithSessionId:(NSString *)sessionId JobId:(NSString *)jobId
{
    NSString *strUrl = [NSString stringWithFormat:@"%@/weChat/job/getMyJobInfo4App?memberId=%@&jobId=%@", serverIp, sessionId, jobId];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:strUrl]] returningResponse:nil error:nil];
    
    NSArray *arry1 = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    
    NSDictionary *dict1 = [arry1 firstObject];
    NSArray *arry = dict1[@"mySignDates"];
    NSMutableArray *arryM = [NSMutableArray array];
    for (NSDictionary *dict in arry) {
        StuProfileMyJobsInfo *info = [[StuProfileMyJobsInfo alloc]init];
        info.status = dict[@"status"];
        info.date_id = dict[@"date_id"];
        NSString *strTmp = dict[@"date"];
        info.date = [strTmp substringFromIndex:5];
        [arryM addObject:info];
    }
    
    return arryM;
}

+ (BOOL)canEstimageWithSessionId:(NSString *)sessionId JobId:(NSString *)jobId IsAgent:(NSString*)isAgent
{
    NSString *strUrl = [NSString string];
    if (isAgent != nil && ![isAgent isEqualToString:@"1"]) {
        strUrl = [NSString stringWithFormat:@"%@/weChat/signUp/findState?memberId=%@&jobId=%@", serverIp, sessionId, jobId];
    }
    else
    {
        strUrl = [NSString stringWithFormat:@"%@/weChat/arrangedSignUp/findArrState?memberId=%@&jobId=%@", serverIp, sessionId, jobId];    }

    NSString *result = [NSString stringWithContentsOfURL:[NSURL URLWithString:strUrl] encoding:NSUTF8StringEncoding error:nil];
    
    if (result != nil && [result isEqualToString:@"\"success\""]) {
        return YES;
    }
    else
    {
        return NO;
    }
}

@end
