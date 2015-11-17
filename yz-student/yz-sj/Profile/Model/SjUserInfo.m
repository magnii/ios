//
//  SjUserInfo.m
//  yz-student
//
//  Created by 仲光磊 on 15/10/29.
//  Copyright © 2015年 cdq. All rights reserved.
//

#import "SjUserInfo.h"
#import "StuConfig.h"

@implementation SjUserInfo

+ (instancetype)sjUserInfoWithSessionId:(NSString*)sessionId
{
    NSString *strUrl = [NSString stringWithFormat:@"%@/web/enterprise/getEnterpriseInfo?id=%@", sjIp, sessionId];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:strUrl]] returningResponse:nil error:nil];
    NSArray *arry = [NSArray array];
    SjUserInfo *info = [[SjUserInfo alloc]init];
    if (data.length != 0) {
        arry = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        
        if (arry.count != 0 ) {
            NSDictionary *dict = [arry firstObject];
            info.contactNumber = dict[@"contactNumber"];
            info.complete = dict[@"complete"];
            info.userName = dict[@"loginName"];
            info.companyName = dict[@"name"];
            info.points = [dict[@"points"] intValue];
            info.contactPerson = dict[@"contactPerson"];
        }
    }
    return info;
}

@end
