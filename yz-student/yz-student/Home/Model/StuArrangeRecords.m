//
//  StuArrangeRecords.m
//  yz-student
//
//  Created by 仲光磊 on 15/9/22.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import "StuArrangeRecords.h"
#import "StuConfig.h"

@implementation StuArrangeRecords

+ (NSArray *)loadArrangeRecordsWithJobId:(NSString *)jobId
{
    NSString *strUrl = [NSString stringWithFormat:@"%@/weChat/job/getArrengedRecords?jobId=%@", serverIp, jobId];
    
    NSString *newIp = [strUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    NSData *data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:newIp]] returningResponse:nil error:nil];
    NSArray *arry = [NSArray array];
    if (data.length != 0) {
        arry = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    }
    
    NSMutableArray *arrayM = [NSMutableArray array];
    for (NSDictionary *dict in arry) {
        StuArrangeRecords *record = [[StuArrangeRecords alloc]init];
        record.recordId = dict[@"recordId"];
        record.mobile = dict[@"mobile"];
        [arrayM addObject:record];
    }
    return arrayM;
}

@end
