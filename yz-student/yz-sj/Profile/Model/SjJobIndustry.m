//
//  SjJobIndustry.m
//  yz-student
//
//  Created by 仲光磊 on 15/11/3.
//  Copyright © 2015年 cdq. All rights reserved.
//

#import "SjJobIndustry.h"
#import "StuConfig.h"

@implementation SjJobIndustry

+ (NSArray *)jobIndustryFromNet
{
    NSString *strUrl = [NSString stringWithFormat:@"%@/web/enterprise/getIndustryCategory4App", sjIp];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:strUrl]] returningResponse:nil error:nil];
    NSArray *arry = [NSArray array];
    NSMutableArray *arryM = [NSMutableArray array];
    
    if (data.length != 0) {
        arry = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        for (NSDictionary *dict in arry) {
            SjJobIndustry *industry = [[SjJobIndustry alloc]init];
            industry.industryId = dict[@"id"];
            industry.industryName = dict[@"name"];
            [arryM addObject:industry];
        }
    }
    return arryM;
}

@end
