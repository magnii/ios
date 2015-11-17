//
//  StuArrangeRecoredsDetail.m
//  yz-student
//
//  Created by 仲光磊 on 15/9/22.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import "StuArrangeRecoredsDetail.h"
#import "StuConfig.h"

@implementation StuArrangeRecoredsDetail

+ (instancetype)loadArrangeRecordsDetailWithSessionId:(NSString *)sessionId JobId:(NSString *)jobId RecordId:(NSString *)recordId
{
    NSString *strUrl = [NSString stringWithFormat:@"%@/weChat/job/getRelationByRecordId?memberId=%@&jobId=%@&recordId=%@", serverIp, sessionId, jobId, recordId];
    
    NSString *newIp = [strUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    NSData *data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:newIp]] returningResponse:nil error:nil];
    
    NSArray *arry = [NSArray array];
    
    StuArrangeRecoredsDetail *detail = [[StuArrangeRecoredsDetail alloc]init];
    if (data.length != 0) {
        arry = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    }
    
    if (arry!=nil && arry.count!=0) {
        NSDictionary *dict = arry[0];
        detail.command = dict[@"command"];
        detail.recruitNum = [dict[@"recruitNum"] longLongValue];
        detail.recruitsArray = dict[@"recruits"];
        detail.mySignArray = dict[@"mySignUp"];
        detail.dateIdArray = dict[@"relationIds"];
        
        NSArray *arryTmp = dict[@"dates"];
        NSMutableArray *arryM = [NSMutableArray array];
        for (NSString *str in arryTmp) {
            [arryM addObject:[str substringFromIndex:5]];
        }
        detail.dateArray = arryM;

    }
    
    return detail;
}

@end
