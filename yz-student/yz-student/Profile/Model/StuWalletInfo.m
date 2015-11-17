//
//  StuWalletInfo.m
//  yz-student
//
//  Created by 仲光磊 on 15/9/16.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import "StuWalletInfo.h"
#import "StuConfig.h"
#import "AFNetworking.h"
#import "MBProgressHUD+MJ.h"

@implementation StuWalletInfo

+(instancetype)remainMoneyWithSessionId:(NSString *)sessionId
{
    StuWalletInfo *walletInfo = [[StuWalletInfo alloc]init];
    
    NSString *strUrl = [NSString stringWithFormat:@"%@/weChat/member/getByIdForqianbao?memberId=%@", serverIp, sessionId];
    
    NSString *newIp = [strUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:newIp]] returningResponse:nil error:nil];
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    if (dict != nil) {
        walletInfo.money = dict[@"money"];
        walletInfo.points = [dict[@"points"] longLongValue];
        walletInfo.alipayNum = dict[@"alipayNum"];
        walletInfo.maxPoints = [dict[@"maxPoints"]intValue];
    }
    return walletInfo;
}

+(void)bindAlipayWithSessionId:(NSString *)sessionId AlipyNum:(NSString *)alipyNum
{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.requestSerializer = [AFHTTPRequestSerializer serializer];
    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 2.拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"id"] = sessionId;
    params[@"alipayNum"] = alipyNum;
    [mgr POST:[NSString stringWithFormat:@"%@/weChat/member/bindAlipayNum", serverIp] parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
    } success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [MBProgressHUD showError:@"支付宝绑定失败"];
    }];
}

+ (void)toCashWithSessionId:(NSString *)sessionId DealType:(NSString *)dealType Amount:(NSString *)amount TradeNum:(NSString *)tradeNum
{
    long recordTime = [[NSDate date] timeIntervalSince1970]*1000;
    tradeNum = [NSString stringWithFormat:@"%ld%d%d%d%d%d%d", recordTime, arc4random() % 10, arc4random() % 10, arc4random() % 10, arc4random() % 10, arc4random() % 10, arc4random() % 10];
    
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.requestSerializer = [AFHTTPRequestSerializer serializer];
    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 2.拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"memberId"] = sessionId;
    params[@"dealType"] = dealType;
    params[@"amount"] = amount;
    params[@"tradeNo"] = tradeNum;
    
    [mgr POST:[NSString stringWithFormat:@"%@/weChat/transfer/toCash", serverIp] parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
    } success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        [MBProgressHUD showSuccess:@"提现成功"];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [MBProgressHUD showError:@"提现失败"];
    }];
}

+(void)exchangePointWithSessionId:(NSString*)sessionId Points:(NSString*)points
{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.requestSerializer = [AFHTTPRequestSerializer serializer];
    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 2.拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"id"] = sessionId;
    params[@"points"] = points;
    [mgr POST:[NSString stringWithFormat:@"%@/weChat/transfer/exchangePoints", serverIp] parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
    } success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [MBProgressHUD showError:@"积分兑换失败"];
    }];
}

@end
