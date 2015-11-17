//
//  SjWeekSettle.m
//  yz-student
//
//  Created by 仲光磊 on 15/11/9.
//  Copyright © 2015年 cdq. All rights reserved.
//

#import "SjWeekSettle.h"
#import "StuConfig.h"

@implementation SjWeekSettle

+ (NSArray *)weekDateListWithJobId:(NSString *)jobId
{
    NSString *httpIp = [NSString stringWithFormat:@"%@/web/jobDates/getJobDatesListByJobId?jobId=%@", sjIp, jobId];
    NSData *data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:httpIp]] returningResponse:nil error:nil];
    
    NSArray *arry = [NSArray array];
    NSMutableArray *arryM = [NSMutableArray array];
    if (data.length != 0) {
        arry = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        if (arry != nil && arry.count != 0) {
            for (NSDictionary *dict in arry) {
                if ([dict isKindOfClass:[NSDictionary class]]) {
                    SjWeekSettle *weekDate = [[SjWeekSettle alloc]init];
                    weekDate.rangeDate = dict[@"rangeDate"];
                    weekDate.dateIds = dict[@"dateIds"];
                    [arryM addObject:weekDate];
                }
            }
        }
    }
    return arryM;
}

@end
