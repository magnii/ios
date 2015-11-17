//
//  StuIncomeInfo.m
//  yz-student
//
//  Created by 仲光磊 on 15/9/17.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import "StuIncomeInfo.h"
#import "StuConfig.h"

@implementation StuIncomeInfo

+ (NSArray *)incomeWithSessionId:(NSString *)sessionId DealType:(NSString *)dealType CurrentPage:(NSString *)currentPage PageSize:(NSString *)pageSize
{
    NSString *strUrl = [NSString stringWithFormat:@"%@/weChat/transfer/getListByMemberIdDealType?memberId=%@&dealType=%@&currentPage=%@&pageSize=%@", serverIp, sessionId, dealType, currentPage, pageSize];
    
//    NSString *newIp = [strUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:strUrl]] returningResponse:nil error:nil];
    
    NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    NSMutableArray *arrayM = [NSMutableArray array];
    if (array != nil)
    {
        for (NSDictionary *dict in array)
        {
            StuIncomeInfo *incomeInfo = [[StuIncomeInfo alloc]init];
            incomeInfo.createTime = dict[@"createTime"];
            incomeInfo.amount = dict[@"amount"];
            if ([dict[@"dealType"] isEqualToString:@"1"]) {
                incomeInfo.dealType = @"充值";
            }
            else if([dict[@"dealType"] isEqualToString:@"2"]) {
                incomeInfo.dealType = @"提现";
            }
            else if([dict[@"dealType"] isEqualToString:@"3"]) {
                incomeInfo.dealType = @"收入";
            }
            else if([dict[@"dealType"] isEqualToString:@"4"]) {
                incomeInfo.dealType = @"培训";
            }
            
            [arrayM addObject:incomeInfo];
        }
    }
    return arrayM;
}
@end
