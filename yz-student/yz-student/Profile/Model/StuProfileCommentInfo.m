//
//  StuProfileCommentInfo.m
//  yz-student
//
//  Created by 仲光磊 on 15/10/13.
//  Copyright © 2015年 cdq. All rights reserved.
//

#import "StuProfileCommentInfo.h"
#import "StuConfig.h"

@implementation StuProfileCommentInfo

+ (instancetype)getMyCommentWithSessionId:(NSString*)sessionId JobId:(NSString*)jobId
{
    NSString *strUrl = [NSString stringWithFormat:@"%@/weChat/reviewsMemberToJob/findRecords?memberId=%@&jobId=%@", serverIp, sessionId, jobId];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:strUrl]] returningResponse:nil error:nil];
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    
    StuProfileCommentInfo *commentInfo = [[StuProfileCommentInfo alloc]init];
    if (dict != nil) {
        commentInfo.commentId = dict[@"id"];
        commentInfo.content = dict[@"content"];
        commentInfo.jobStars = [dict[@"jobStars"] intValue];
        commentInfo.salaryStars = [dict[@"salaryStars"] intValue];
        commentInfo.payTimeStars = [dict[@"payTimeStars"] intValue];
        commentInfo.attitudeStars = [dict[@"attitudeStars"] intValue];
        commentInfo.averageStars = (int)[dict[@"averageStars"] doubleValue];
    }
    return commentInfo;
}

+ (BOOL)commentsBtnClickWithCommentId:(NSString*)commentId JobStars:(NSString*)jobStars SalaryStars:(NSString*)salaryStars PayTimeStars:(NSString*)payTimeStars AttitudeStars:(NSString*)attitudeStars AverageStars:(NSString*)averageStars Content:(NSString*)content
{
    NSString *url = [NSString stringWithFormat:@"%@/weChat/reviewsMemberToJob/saveReviews", serverIp];
    
    NSURL *URL = [NSURL URLWithString:url];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:URL];
    request.timeoutInterval=5.0;//设置请求超时为5秒
    request.HTTPMethod=@"POST";//设置请求方法
    
    //设置请求体
    NSString *param=[NSString stringWithFormat:@"id=%@&jobStars=%@&salaryStars=%@&payTimeStars=%@&attitudeStars=%@&averageStars=%@&content=%@",commentId, jobStars, salaryStars, payTimeStars, attitudeStars, averageStars, content];
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
