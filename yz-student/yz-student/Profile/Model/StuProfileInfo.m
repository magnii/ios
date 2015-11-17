//
//  StuProfileInfo.m
//  yz-student
//
//  Created by 仲光磊 on 15/9/15.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import "StuProfileInfo.h"
#import "StuConfig.h"

@implementation StuProfileInfo

+ (instancetype)profileInfoWithUserMobile:(NSString *)mobile Passwd:(NSString *)passwd
{
    StuProfileInfo *profileInfo = [[StuProfileInfo alloc]init];
    
    NSString *strUrl = [NSString stringWithFormat:@"%@/weChat/member/loginForAndroid?mobile=%@&password=%@", serverIp, mobile, passwd];
    
    NSString *newIp = [strUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:newIp]] returningResponse:nil error:nil];
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    if (dict != nil) {
        profileInfo.points = [dict[@"points"] longValue];
        profileInfo.signInDays = [dict[@"signInDays"] longValue];
        profileInfo.invites = [dict[@"invites"] longValue];
        profileInfo.alipayNum = dict[@"alipayNum"];
        profileInfo.mobile = dict[@"mobile"];
        profileInfo.maxPoints = [dict[@"maxPoints"] longValue];
        
        NSString *signInDate = dict[@"signInTime"];
        
        //获取今天的日期
        NSString *nowDateUrl = [NSString stringWithFormat:@"%@/weChat/member/getNoWTime", serverIp];
        NSData *nowDateData = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:nowDateUrl]] returningResponse:nil error:nil];
        NSString *nowDateStr = [[NSString alloc]initWithData:nowDateData encoding:NSUTF8StringEncoding];
        
        NSString *nowDateStr2 = [[nowDateStr substringFromIndex:1]substringToIndex:10];
        
        if (signInDate != nil &&signInDate.length>=10 && [[signInDate substringToIndex:10] isEqualToString:nowDateStr2]) {
            profileInfo.isTodaySignIn = YES;
        }
        else
        {
            profileInfo.isTodaySignIn = NO;
        }
    }
    return profileInfo;
}

@end
