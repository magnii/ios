//
//  StuProfileHomeHeadView.m
//  yz-student
//
//  Created by 仲光磊 on 15/9/15.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import "StuProfileHomeHeadView.h"
#import "AFNetworking.h"
#import "StuConfig.h"
#import "MBProgressHUD+MJ.h"

extern NSString* globalSessionId;

@implementation StuProfileHomeHeadView

- (IBAction)headSignBtnClick:(UIButton *)sender {
    if (globalSessionId == nil || [globalSessionId isEqualToString:@""]) {
        [MBProgressHUD showError:@"您还没有登录"];
        return;
    }
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.requestSerializer = [AFHTTPRequestSerializer serializer];
    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 2.拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"id"] = globalSessionId;
    
    [mgr POST:[NSString stringWithFormat:@"%@/weChat/member/signIn", serverIp] parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
    } success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
//        [sender setEnabled:NO];
        sender.selected = YES;
        sender.backgroundColor = [UIColor grayColor];
        sender.userInteractionEnabled = NO;
        
        self.headSignDays.text = [NSString stringWithFormat:@"%lld", self.headSignDays.text.longLongValue+1];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
    
}

+(instancetype)viewFromNib
{
    StuProfileHomeHeadView *profileHeadView = [[[NSBundle mainBundle]loadNibNamed:@"StuProfileHomeHead" owner:nil options:nil]lastObject];
    
    return profileHeadView;
}

@end
