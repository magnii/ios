//
//  StuSystemInfo.m
//  yz-student
//
//  Created by 仲光磊 on 15/9/15.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import "StuSystemInfo.h"
#import "StuConfig.h"

@implementation StuSystemInfo

+(NSArray*)getSystemInfoWithInfoType:(NSString *)infoType
{
    NSString *strUrl = [NSString stringWithFormat:@"%@/weChat/notice/findNoticeList?%@", serverIp, infoType];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:strUrl]] returningResponse:nil error:nil];
    NSArray *arry = [NSArray array];
    if (data.length != 0) {
        arry = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    }
    
    NSMutableArray *systemInfoArrayM = [NSMutableArray array];
    for (NSDictionary *dict in arry) {
        StuSystemInfo *systemInfo = [[StuSystemInfo alloc]init];
        systemInfo.infoId = dict[@"id"];
        systemInfo.createTime = dict[@"createTime"];
        systemInfo.isRead = dict[@"isRead"];
        systemInfo.content = dict[@"content"];
        
        [systemInfoArrayM addObject:systemInfo];
    }
    
    return systemInfoArrayM;
}

@end
