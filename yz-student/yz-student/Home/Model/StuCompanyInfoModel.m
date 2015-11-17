//
//  StuCompanyInfo.m
//  yz-student
//
//  Created by 仲光磊 on 15/9/9.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import "StuCompanyInfoModel.h"
#import "StuConfig.h"

@implementation StuCompanyInfoModel

+ (instancetype)companyDetailCheckWithCompanyId:(NSString*)companyId
{
    
    NSString *strUrl = [NSString stringWithFormat:@"%@/weChat/enterprise/getDetails4Job?id=%@", serverIp, companyId];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:strUrl]] returningResponse:nil error:nil];
    NSDictionary *dict = [NSDictionary dictionary];
    if (data!=nil && data.length != 0) {
        dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    }
    
    StuCompanyInfoModel *companyInfo = [[StuCompanyInfoModel alloc]init];
    companyInfo.companyId = dict[@"id"];
    companyInfo.name = dict[@"name"];
    companyInfo.contactNumber = dict[@"contactNumber"];
    companyInfo.contactPerson = dict[@"contactPerson"];
    companyInfo.logoImage = [NSString stringWithFormat:@"%@%@", serverIpOnlyIp, dict[@"logoPath"]];
    companyInfo.jobs = dict[@"jobs"];
    companyInfo.jobsNumber = [dict[@"jobsNumber"] intValue];
    companyInfo.concernedCounts = [dict[@"concernedCounts"] intValue];
    companyInfo.createTime = dict[@"createTime"];
    companyInfo.brifIntrodution = dict[@"brifIntrodution"];
    
    return companyInfo;
}


+ (BOOL)companyAttentionWithCompanyId:(NSString *)companyId MemberId:(NSString*)memberId
{
    NSString *url = @"/weChat/companyStoreRecords/saveCompanyStoreRecords";
    
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", serverIp, url]];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:URL];
    request.timeoutInterval=5.0;//设置请求超时为5秒
    request.HTTPMethod=@"POST";//设置请求方法
    
    //设置请求体
    NSString *param=[NSString stringWithFormat:@"companyId=%@&memberId=%@",companyId, memberId];
    //把拼接后的字符串转换为data，设置请求体
    request.HTTPBody=[param dataUsingEncoding:NSUTF8StringEncoding];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    if ([str isEqual:@"\"success\""]) {
        return YES;
    }
    else
    {
        return NO;
    }
}

+ (double)companyScoreCheckWithCompanyId:(NSString*)companyId
{
    NSString *strUrl = [NSString stringWithFormat:@"%@/weChat/signUpRecords/findCompanyRecords?companyId=%@", serverIp, companyId];
    
//    NSData *data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:strUrl]] returningResponse:nil error:nil];
    
    NSString *dataStr = [NSString stringWithContentsOfURL:[NSURL URLWithString:strUrl] encoding:NSUTF8StringEncoding error:nil];
    
//    NSDictionary *dict = [NSDictionary dictionary];
//    if (data!=nil && data.length != 0) {
//        dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
//    }
    return dataStr.doubleValue;
}

+(BOOL)isAttentionWithCompanyId:(NSString*)companyId SessionId:(NSString*)sessionId
{
    NSString *strUrl = [NSString stringWithFormat:@"%@/weChat/companyStoreRecords/findCompanyStoreByCond?memberId=%@&companyId=%@", serverIp, sessionId, companyId];
    
    NSString *dataStr = [NSString stringWithContentsOfURL:[NSURL URLWithString:strUrl] encoding:NSUTF8StringEncoding error:nil];
    
    
    if ([dataStr isEqualToString:@"\"success\""]) {
        return  YES;
    }
    else
    {
        return NO;
    }
}


@end
