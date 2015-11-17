//
//  SjDaySettle.m
//  yz-student
//
//  Created by 仲光磊 on 15/11/5.
//  Copyright © 2015年 cdq. All rights reserved.
//

#import "SjDaySettle.h"
#import "StuConfig.h"
#import "SjOneRegisMember.h"

@implementation SjDaySettle

+ (NSArray *)daySettleListWithJobId:(NSString *)jobId SettleType:(SettleType)settleType
{
    NSString *httpIp = [NSString stringWithFormat:@"%@/web/signUp/getDaySettleList4App?jobId=%@", sjIp, jobId];
    NSData *data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:httpIp]] returningResponse:nil error:nil];
    
    NSDictionary *dict = [NSDictionary dictionary];
    if (data.length != 0) {
        dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        
        NSArray *array = [NSArray array];
        NSMutableArray *arryM2 = [NSMutableArray array];
        if (settleType == Settled) {
            array = dict[@"settleInfo"];
        }
        else
        {
            array = dict[@"unSettleInfo"];
        }
        
        for (NSDictionary *dict1 in array) {
            SjDaySettle *daySettle = [[SjDaySettle alloc]init];
            daySettle.dayDateId = dict1[@"dateId"];
            daySettle.dayDateStr = dict1[@"date"];
            
            NSArray *arry2 = [NSArray array];
            if (settleType == Settled)
            {
                arry2 = dict1[@"settledList"];
            }
            else
            {
                arry2 = dict1[@"unSettledList"];
            }
            NSMutableArray *arryM = [NSMutableArray array];
            if ([arry2 isKindOfClass:[NSArray class]] && arry2.count != 0) {
                for (NSDictionary *dict3 in arry2) {
                    SjOneRegisMember *oneMember = [[SjOneRegisMember alloc]init];
                    oneMember.name = dict3[@"name"];
                    oneMember.memberId = dict3[@"memberId"];
                    oneMember.salary = [dict3[@"salary"] intValue];
                    oneMember.mobile = dict3[@"mobile"];
                    oneMember.signInTime = dict3[@"signInTime"];
                    oneMember.signInAddress = dict3[@"signInAddress"];
                    oneMember.signOutTime = dict3[@"signOutTime"];
                    oneMember.signOutAddress = dict3[@"signOutAddress"];
                    [arryM addObject:oneMember];
                }
            }
            daySettle.daySettleArry = arryM;
            [arryM2 addObject:daySettle];
        }
        return arryM2;
    }
    return @[];
}

@end
