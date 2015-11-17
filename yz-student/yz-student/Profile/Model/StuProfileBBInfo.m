//
//  StuProfileBBInfo.m
//  yz-student
//
//  Created by 仲光磊 on 15/9/20.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import "StuProfileBBInfo.h"
#import "StuConfig.h"
#import "StuProfileBBOnePeople.h"

@implementation StuProfileBBInfo

+ (instancetype)bbJobsWithSessionId:(NSString *)sessionId JobId:(NSString *)jobId
{
    NSString *strUrl = [NSString stringWithFormat:@"%@/weChat/arrangedRecrod/getMyArrangedRecordDates?memberId=%@&jobId=%@", serverIp, sessionId, jobId];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:strUrl]] returningResponse:nil error:nil];
    
    StuProfileBBInfo *bbInfo = [[StuProfileBBInfo alloc]init];
    
    if (data == nil || data.length == 0) {
        return bbInfo;
    }
    
    NSArray *arr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    
    NSDictionary *dict = [arr firstObject];
    
    bbInfo.recordId = dict[@"recordId"];
    bbInfo.command = dict[@"command"];
    
    NSArray *arry = dict[@"recordDates"];
    NSMutableArray *arryM = [NSMutableArray array];
    for (NSDictionary *arryDict in arry) {
        StuProfileBBOnePeople *one = [[StuProfileBBOnePeople alloc]init];
        one.status = arryDict[@"status"];
        int endTimeInt = [arryDict[@"endTime"] intValue];
        one.endTime = [NSString stringWithFormat:@"%d", endTimeInt/1000];
        one.date = arryDict[@"date"];
        one.relationId = arryDict[@"relationId"];
        
        [arryM addObject:one];
    }
    
    bbInfo.recordDatesArry = arryM;

    return bbInfo;
}

@end
