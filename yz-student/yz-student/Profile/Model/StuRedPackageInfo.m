//
//  StuRedPackageInfo.m
//  yz-student
//
//  Created by 仲光磊 on 15/9/17.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import "StuRedPackageInfo.h"
#import "StuConfig.h"
#import "AFNetworking.h"
#import "MBProgressHUD+MJ.h"

@implementation StuRedPackageInfo

+ (NSArray *)redPackageWithSessionId:(NSString *)sessionId CurrentPage:(NSString *)currentPage PageSize:(NSString *)pageSize
{
    NSString *strUrl = [NSString stringWithFormat:@"%@/weChat/transfer/getRedPacketList?memberId=%@&currentPage=%@&pageSize=%@", serverIp, sessionId, currentPage, pageSize];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:strUrl]] returningResponse:nil error:nil];
    
    NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    NSMutableArray *arrayM = [NSMutableArray array];
    if (array != nil)
    {
        for (NSDictionary *dict in array)
        {
            StuRedPackageInfo *redPackage = [[StuRedPackageInfo alloc]init];
            redPackage.redPackageId = dict[@"id"];
            redPackage.createTime = dict[@"createTime"];
            redPackage.money = [dict[@"money"] intValue];
            redPackage.received = dict[@"received"];
            redPackage.desc = dict[@"description"];
            [arrayM addObject:redPackage];
        }
    }
    return arrayM;
}

@end