//
//  StuRedPacketTableViewCell.m
//  yz-student
//
//  Created by 仲光磊 on 15/9/17.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import "StuRedPacketTableViewCell.h"
#import "StuConfig.h"
#import "StuRedPackageInfo.h"
#import "MBProgressHUD+MJ.h"
#import "AFNetworking.h"

extern NSString *globalSessionId;

@implementation StuRedPacketTableViewCell

- (NSString *)redPackageId
{
    if (_redPackageId == nil) {
        _redPackageId = [NSString string];
    }
    return _redPackageId;
}

//StuRedPacketCell

- (IBAction)gotBtnClick:(UIButton *)sender {
    if ([self.gotBtn.titleLabel.text isEqualToString:@"领取红包"]) {
        [self openRedPackageWithSessionId:globalSessionId RedPackageId:self.redPackageId Money:self.redPackageBtn.titleLabel.text];
        [self.gotBtn setTitle:@"已领取" forState:UIControlStateNormal];
    }
    else
    {
        [MBProgressHUD showError:@"您已领取，请务重复领取"];
    }
    
}

+ (instancetype)cellFromNibWithTableView:(UITableView *)tableView
{
    static NSString* ID = @"StuRedPacketCell";
    StuRedPacketTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"StuRedPacketCell" owner:nil options:nil]lastObject];
    }
    return cell;
}

- (void)openRedPackageWithSessionId:(NSString *)sessionId RedPackageId:(NSString *)redPackageId Money:(NSString *)money
{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.requestSerializer = [AFHTTPRequestSerializer serializer];
    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 2.拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"memberId"] = sessionId;
    params[@"id"] = redPackageId;
    params[@"money"] = money;
    
    [mgr POST:[NSString stringWithFormat:@"%@/weChat/transfer/receivedRedPacket", serverIp] parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
    } success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [MBProgressHUD showError:@"红包打开失败"];
    }];
}
@end
