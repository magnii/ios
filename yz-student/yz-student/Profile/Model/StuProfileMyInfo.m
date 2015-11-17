//
//  StuProfileMyInfo.m
//  yz-student
//
//  Created by 仲光磊 on 15/9/18.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import "StuProfileMyInfo.h"
#import "StuConfig.h"

@implementation StuProfileMyInfo

+(NSArray*)myInfoWithSessionId:(NSString *)sessionId
{
    NSString *strUrl = [NSString stringWithFormat:@"%@/weChat/notice/findNoticeList?reciverId=%@", serverIp, sessionId];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:strUrl]] returningResponse:nil error:nil];
    
    NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    NSMutableArray *arrayM = [NSMutableArray array];
    if (array != nil)
    {
        for (NSDictionary *dict in array)
        {
            StuProfileMyInfo *info = [[StuProfileMyInfo alloc]init];
            info.infoId = dict[@"id"];
            info.createTime = dict[@"createTime"];
            info.content = dict[@"content"];
            info.isRead = dict[@"isRead"];
            [arrayM addObject:info];
        }
    }
    return arrayM;
}

@end
