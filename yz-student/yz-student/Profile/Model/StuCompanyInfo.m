//
//  StuCompanyInfo.m
//  yz-student
//
//  Created by 仲光磊 on 15/9/26.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import "StuCompanyInfo.h"
#import "StuConfig.h"

@implementation StuCompanyInfo

+ (NSArray *)companyInfosWithSessionId:(NSString *)sessionId CurrentPage:(NSString *)currentPage PageSize:(NSString *)pageSize
{
    ///weChat/companyStoreRecords/getListByMemberId
    
    NSString *strUrl = [NSString stringWithFormat:@"%@/weChat/companyStoreRecords/getListByMemberId?memberId=%@&currentPage=%@&pageSize=%@", serverIp, sessionId, currentPage, pageSize];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:strUrl]] returningResponse:nil error:nil];
    NSArray *arry = [NSArray array];
    if (data.length != 0) {
        arry = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    }
    NSMutableArray *arryM = [NSMutableArray array];
    
    if (arry != nil && arry.count != 0) {
        for (NSDictionary *dict in arry)
        {
            StuCompanyInfo *compayInfo = [[StuCompanyInfo alloc]init];
            compayInfo.createTime = dict[@"createTime"];
            compayInfo.name = dict[@"name"];
            compayInfo.contactNumber = dict[@"contactNumber"];
            compayInfo.contactPerson = dict[@"contactPerson"];
            compayInfo.companyId = dict[@"id"];
            compayInfo.gender = dict[@"gender"];
            compayInfo.loginName = dict[@"loginName"];
            compayInfo.industry = dict[@"industry"];
            compayInfo.homePage = dict[@"homePage"];
            compayInfo.points = dict[@"points"];
            compayInfo.logoId = dict[@"logoId"];
            compayInfo.cardId = dict[@"cardId"];
            compayInfo.licenseId = dict[@"licenseId"];
            compayInfo.type = dict[@"type"];
            compayInfo.attribute = dict[@"attribute"];
            compayInfo.scale = dict[@"scale"];
            compayInfo.email = dict[@"email"];
            compayInfo.address = dict[@"address"];
            compayInfo.brifIntrodution = dict[@"brifIntrodution"];
            compayInfo.cardIdStatus = dict[@"cardIdStatus"];
            compayInfo.licenseIdStatus = dict[@"licenseIdStatus"];
            compayInfo.complete = dict[@"complete"];
            
            [arryM addObject:compayInfo];
        }
    }
    return arryM;
}

@end
