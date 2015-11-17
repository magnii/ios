//
//  SjOneJobInfo.m
//  yz-student
//
//  Created by 仲光磊 on 15/10/22.
//  Copyright © 2015年 cdq. All rights reserved.
//

#import "SjOneJobInfo.h"
#import "StuConfig.h"

@implementation SjOneJobInfo

+(NSArray*)sjJobsWithMemberId:(NSString*)memberId JobStatus:(NSString*)jobStatus MinResult:(NSString*)minResult MaxResult:(NSString*)maxResult
{
    jobStatus = @"";
    NSString *httpIp = [NSString stringWithFormat:@"%@/web/enterprise/getListByEnterpriseId?enterpriseId=%@&jobStatus=%@&minResult=%@&maxResult=%@", sjIp, memberId, jobStatus, minResult, maxResult];
    NSData *data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:httpIp]] returningResponse:nil error:nil];
    NSArray *array = [NSArray array];
    if (data.length != 0) {
        array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    }
    
    NSMutableArray *arryM = [NSMutableArray array];
    if (array.count == 0 || [array.firstObject isKindOfClass:[NSString class]]) {
        return arryM;
    }
    for (NSDictionary *dict in array) {
        SjOneJobInfo *jobInfo = [[SjOneJobInfo alloc]init];
        jobInfo.jobId = dict[@"id"];
        jobInfo.jobType = dict[@"jobType"];
        jobInfo.createTime = dict[@"createTime"];
        jobInfo.isAgent = dict[@"isAgent"];
        jobInfo.name = dict[@"name"];
        [arryM addObject:jobInfo];
    }
    return arryM;
}

@end
