//
//  StuProfileComments.m
//  yz-student
//
//  Created by 仲光磊 on 15/9/20.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import "StuProfileComments.h"
#import "StuConfig.h"
#import "AFNetworking.h"
#import "MBProgressHUD+MJ.h"

@implementation StuProfileComments

+ (NSArray *)loadCommentsWithJobId:(NSString *)jobId IsArranged:(NSString *)isArraged CurrentPage:(NSString *)currentPage PageSize:(NSString *)pageSize
{
    NSString *strUrl = [NSString stringWithFormat:@"%@/weChat/communication/getListByJobId?jobId=%@&isArraged=%@&currentPage=%@&pageSize=%@", serverIp, jobId, isArraged, currentPage, pageSize];
    
    NSError *error = [[NSError alloc]init];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:strUrl]] returningResponse:nil error:&error];
    
    NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    NSMutableArray *arrayM = [NSMutableArray array];
    if (array != nil)
    {
        for (NSDictionary *dict in array)
        {
            StuProfileComments *comment = [[StuProfileComments alloc]init];
            comment.commentsDate = dict[@"createTime"];
            comment.commentsContent = dict[@"content"];
            comment.commentsName = dict[@"commentName"];
            comment.commentsMemberId = dict[@"memberId"];
            
            [arrayM addObject:comment];
        }
    }
    return arrayM;
}

+(BOOL)pushCommentsWithSessionId:(NSString*)sessionId JobId:(NSString*)jobId Content:(NSString*)content MemberAttr:(NSString*)memberAttr
{
//    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
//    mgr.requestSerializer = [AFHTTPRequestSerializer serializer];
//    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
//    // 2.拼接请求参数
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    params[@"memberId"] = sessionId;
//    params[@"jobId"] = jobId;
//    params[@"content"] = content;
//    params[@"memberAttr"] = memberAttr;
//    [mgr POST:[NSString stringWithFormat:@"%@/weChat/communication/comment", serverIp] parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//    } success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
//        [MBProgressHUD showSuccess:@"评论提交成功"];
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//        [MBProgressHUD showError:@"评论提交失败"];
//    }];
    
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/weChat/communication/comment", serverIp]];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:URL];//默认为get请求
    request.timeoutInterval=5.0;//设置请求超时为5秒
    request.HTTPMethod=@"POST";//设置请求方法

    //设置请求体
    NSString *param=[NSString stringWithFormat:@"memberId=%@&jobId=%@&content=%@&memberAttr=%@",sessionId, jobId, content, memberAttr];
    //把拼接后的字符串转换为data，设置请求体
    request.HTTPBody=[param dataUsingEncoding:NSUTF8StringEncoding];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    return YES;
}

@end
