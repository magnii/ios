//
//  StuTrainingModel.m
//  yz-student
//
//  Created by 仲光磊 on 15/9/10.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import "StuTrainingModel.h"
#import "StuConfig.h"

@implementation StuTrainingModel

+(NSArray*)trainingModelWithCityId:(NSString*)cityId CurrentPage:(NSString*)currentPage PageSize:(NSString*)pageSize Status:(NSString*)status Cond:(NSString*)cond Value:(NSString*)value

{
    NSString *strUrl = [NSString stringWithFormat:@"%@/weChat/training/findTrainingList?cityId=%@&currentPage=%@&pageSize=%@&trainingStatus=%@&cond=%@&value=%@", serverIp, cityId, currentPage, pageSize, status, cond, value];
    
    NSString *newIp = [strUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    NSData *data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:newIp]] returningResponse:nil error:nil];
    NSArray *arry = [NSArray array];
    if (data.length != 0) {
        arry = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    }
    
    NSMutableArray *arrayM = [NSMutableArray array];
    for (NSDictionary *dict in arry) {
        StuTrainingModel *oneTraning = [[StuTrainingModel alloc]init];
        oneTraning.name = dict[@"name"];
        oneTraning.imgName = @"ic_launcher";
        oneTraning.startDate = dict[@"startDate"];
        oneTraning.endDate = dict[@"endDate"];
        oneTraning.address = dict[@"address"];
        oneTraning.peoples = dict[@"number"];
        oneTraning.content = dict[@"content"];
        oneTraning.qq = dict[@"qq"];
        oneTraning.telephone = dict[@"telephone"];
        oneTraning.contactP = dict[@"contactP"];
        oneTraning.trainId = dict[@"id"];
        oneTraning.hasSignUp = dict[@"hasSignUp"];
        [arrayM addObject:oneTraning];
    }
    return arrayM;
}

+ (BOOL)trainingIWantWithSessionId:(NSString *)sessionId TrainingId:(NSString *)trainingId
{
    NSString *url = @"/weChat/training/registration";
    
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", serverIp, url]];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:URL];
    request.timeoutInterval=5.0;//设置请求超时为5秒
    request.HTTPMethod=@"POST";//设置请求方法
    
    //设置请求体
    NSString *param=[NSString stringWithFormat:@"trainingId=%@&memberId=%@",trainingId, sessionId];
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
