//
//  SjWeekSettleOne.m
//  yz-student
//
//  Created by 仲光磊 on 15/11/9.
//  Copyright © 2015年 cdq. All rights reserved.
//

#import "SjWeekSettleOne.h"
#import "StuConfig.h"

@implementation SjWeekSettleOne

+ (NSArray*)weekSettleOneWithJobId:(NSString *)jobId DateIds:(NSString *)dateIds SettleType:(SettleType)settleType
{
    NSString *httpIp = [NSString stringWithFormat:@"%@/web/signUp/getSettleListByDateIds4App?jobId=%@&dateIds=%@", sjIp, jobId, dateIds];
    NSData *data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:httpIp]] returningResponse:nil error:nil];
    
    NSDictionary *dict = [NSDictionary dictionary];
    NSMutableArray *arryM = [NSMutableArray array];
    if (data.length != 0) {
        dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        if (dict != nil && dict.count != 0) {
            
            NSArray *arry = [NSArray array];
            if (settleType == Settled) {
                arry = dict[@"settledList"];
                if (![arry isKindOfClass:[NSArray class]]) {
                    return @[];
                }
                for (NSDictionary *dict2 in arry) {
                    SjWeekSettleOne *weekOne = [[SjWeekSettleOne alloc]init];
                    weekOne.workDays = [dict2[@"workDays"] longLongValue];
                    weekOne.days = dict2[@"days"];
                    weekOne.name = dict2[@"name"];
                    weekOne.money = [dict2[@"money"] intValue];
                    weekOne.memberId = dict2[@"memberId"];
                    weekOne.mobile = dict2[@"mobile"];
                    
                    [arryM addObject:weekOne];
                }
            }
            else
            {
                arry = dict[@"unSettledList"];
                if (![arry isKindOfClass:[NSArray class]]) {
                    return @[];
                }
                for (NSDictionary *dict2 in arry) {
                    SjWeekSettleOne *weekOne = [[SjWeekSettleOne alloc]init];
                    weekOne.days = dict2[@"days"];
                    weekOne.name = dict2[@"name"];
                    weekOne.salary = [dict2[@"salary"] intValue];
                    weekOne.mobile = dict2[@"mobile"];
                    
                    [arryM addObject:weekOne];
                }
            }
            
        }
    }
    return arryM;
}

@end
