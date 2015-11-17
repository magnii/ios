//
//  StuPreSalaryInfo.m
//  yz-student
//
//  Created by 仲光磊 on 15/10/8.
//  Copyright © 2015年 cdq. All rights reserved.
//

#import "StuPreSalaryInfo.h"
#import "StuConfig.h"

@implementation StuPreSalaryInfo

+ (NSArray *)preSalaryInfoWithSessionId:(NSString *)sessionId
{
    NSString *strUrl = [NSString stringWithFormat:@"%@/weChat/advance/getMyAdvance?memberId=%@", serverIp, sessionId];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:strUrl]] returningResponse:nil error:nil];
    NSArray *arry = [NSArray array];
    if (data.length != 0) {
        arry = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    }
    NSMutableArray *arryM = [NSMutableArray array];
    
    if (arry != nil && arry.count != 0) {
        for (NSDictionary *dict in arry)
        {
            StuPreSalaryInfo *preSalaryInfo = [[StuPreSalaryInfo alloc]init];
            preSalaryInfo.date = dict[@"createTime"];
            preSalaryInfo.money = [dict[@"money"] doubleValue];
            preSalaryInfo.status = dict[@"state"];
            
            [arryM addObject:preSalaryInfo];
        }
    }
    return arryM;

}

@end
