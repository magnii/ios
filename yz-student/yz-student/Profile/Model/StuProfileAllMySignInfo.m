//
//  StuProfileAllMySignInfo.m
//  yz-student
//
//  Created by 仲光磊 on 15/9/24.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import "StuProfileAllMySignInfo.h"
#import "StuConfig.h"

@implementation StuProfileAllMySignInfo

+(NSArray*)allMySignInfoWithSessionId:(NSString*)sessionId JobId:(NSString*)jobId IsAgent:(NSString*)isAgent
{
    NSString *url = [NSString string];
    if ([isAgent isEqualToString:@"1"]) {
        url=@"/weChat/arrangedSignUp/getMyArrSignIns";
    }
    else
    {
        url=@"/weChat/signUp/getMySignIns";
    }
    
    NSString *strUrl = [NSString stringWithFormat:@"%@%@?memberId=%@&jobId=%@", serverIp, url, sessionId, jobId];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:strUrl]] returningResponse:nil error:nil];
    
    NSArray *arry = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    NSMutableArray *arryM = [NSMutableArray array];
    for (NSDictionary *dict in arry) {
        StuProfileAllMySignInfo *info = [[StuProfileAllMySignInfo alloc]init];
        info.date = dict[@"date"];
        info.signInTime = dict[@"signInTime"];
        info.signInAddress = dict[@"signInAddress"];
        info.signOutTime = dict[@"signOutTime"];
        info.signOutAddress = dict[@"signOutAddress"];
        
        [arryM addObject:info];
    }
    
    return arryM;
}

+(BOOL)signInOutWithSessionId:(NSString*)sessionId DateId:(NSString*)dateId IsAgent:(NSString*)isAgent Address:(NSString*)address InOrOut:(NSString *)inOrOut
{
    NSString *url = [NSString string];
    if ([inOrOut isEqualToString:@"in"]) {
        url = @"/weChat/member/jobSignIn";
    }
    else
    {
        url = @"/weChat/member/jobSignOut";
    }
    
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", serverIp, url]];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:URL];
    request.timeoutInterval=5.0;//设置请求超时为5秒
    request.HTTPMethod=@"POST";//设置请求方法
    
    //设置请求体
    NSString *param=[NSString stringWithFormat:@"memberId=%@&dateId=%@&isAgent=%@&address=%@",sessionId, dateId, isAgent, address];
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


@end
