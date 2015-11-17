//
//  StuProfileBBOnePeopleDetail.m
//  yz-student
//
//  Created by 仲光磊 on 15/9/24.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import "StuProfileBBOnePeopleDetail.h"
#import "StuConfig.h"
#import "StuProfileBBOnePeopleDetailOne.h"
#import "StuProfileBBOnePeopleDetailOneOne.h"

@implementation StuProfileBBOnePeopleDetail

+(instancetype)bbOnePelpleDetailWithRelationId:(NSString*)relationId
{
    NSString *strUrl = [NSString stringWithFormat:@"%@/weChat/arrangedRecrod/getArrangedSignUp?relationId=%@", serverIp, relationId];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:strUrl]] returningResponse:nil error:nil];
    
    NSArray *arry = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    
    NSDictionary *dict = [arry firstObject];
    
    StuProfileBBOnePeopleDetail *detail = [[StuProfileBBOnePeopleDetail alloc]init];
    
    detail.enrolNum = dict[@"enrolNum"];
    detail.signUpDateId = dict[@"signUpDateId"];
    detail.relationId = dict[@"relationId"];
    NSArray *arryTmp = dict[@"signUpMember"];
    NSMutableArray *arryM = [NSMutableArray array];
    
    for (NSDictionary *dictTmp in arryTmp) {
        StuProfileBBOnePeopleDetailOne *one = [[StuProfileBBOnePeopleDetailOne alloc]init];
        one.memberId = dictTmp[@"memberId"];
        NSArray *arry = dictTmp[@"memberInfo"];
        StuProfileBBOnePeopleDetailOneOne *oneOne = [[StuProfileBBOnePeopleDetailOneOne alloc]init];
        oneOne.name = [arry objectAtIndex:0];
        oneOne.telephone = [arry objectAtIndex:1];
        oneOne.createDate = [arry objectAtIndex:2];
        oneOne.status = [arry objectAtIndex:3];
        one.oneOne = oneOne;
        [arryM addObject:one];
    }
    detail.oneArray = arryM;
    return detail;
}

@end
