//
//  SjUserDoc.m
//  yz-student
//
//  Created by 仲光磊 on 15/10/30.
//  Copyright © 2015年 cdq. All rights reserved.
//

#import "SjUserDoc.h"
#import "StuConfig.h"
#import "SjCardIdPath.h"

@implementation SjUserDoc

+(instancetype)sjUserDocWithSessionId:(NSString *)sessionId
{
    NSString *strUrl = [NSString stringWithFormat:@"%@/web/enterprise/getDetailsById4App?id=%@", sjIp, sessionId];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:strUrl]] returningResponse:nil error:nil];
    NSDictionary *dict = [NSDictionary dictionary];
    SjUserDoc *doc = [[SjUserDoc alloc]init];
    if (data.length != 0) {
        dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        
        if (dict.count != 0 ) {
            doc.name = dict[@"name"];
            doc.contactPerson = dict[@"contactPerson"];
            doc.industry = dict[@"industryName"];
            doc.scale = dict[@"scale"];
            if ([dict[@"type"] isEqualToString:@"personnal"]) {
                doc.type = @"个人";
            }
            else
            {
                doc.type = @"公司";
            }
            doc.contactNumber = dict[@"contactNumber"];
            NSString *attrStr = dict[@"attribute"];
            if ([attrStr isEqualToString:@"1"]) {
                doc.attribute = @"国有企业";
            }
            else if ([attrStr isEqualToString:@"2"])
            {
                doc.attribute = @"合资企业";
            }
            else if ([attrStr isEqualToString:@"3"])
            {
                doc.attribute = @"集体企业";
            }
            else if ([attrStr isEqualToString:@"4"])
            {
                doc.attribute = @"私营企业";
            }
            NSString *licenseStr = dict[@"licenseIdStatus"];
            if ([licenseStr isEqualToString:@"0"]) {
                doc.licenseIdStatus = @"未认证";
            }
            else if ([licenseStr isEqualToString:@"1"])
            {
                doc.licenseIdStatus = @"待认证";
            }
            else if ([licenseStr isEqualToString:@"2"])
            {
                doc.licenseIdStatus = @"已认证";
            }
            
            NSString *cardStr = dict[@"cardIdStatus"];
            if ([cardStr isEqualToString:@"0"]) {
                doc.cardIdStatus = @"未认证";
            }
            else if ([cardStr isEqualToString:@"1"])
            {
                doc.cardIdStatus = @"待认证";
            }
            else if ([cardStr isEqualToString:@"2"])
            {
                doc.cardIdStatus = @"已认证";
            }
            NSString *brifStr = dict[@"brifIntrodution"];
            doc.brifIntrodution = [NSString stringWithFormat:@"        %@",[brifStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
//            doc.brifIntrodution = dict[@"brifIntrodution"];
            
            NSString *licenseImgStr = dict[@"licenseImage"];
            if (licenseImgStr != nil && licenseImgStr.length != 0) {
                doc.licenseImage = [NSString stringWithFormat:@"%@%@", sjOnlyIp, licenseImgStr];
            }
            
            NSArray *cardImageArry = [NSArray array];
            if ([dict[@"cardImage"] isKindOfClass:[NSArray class]]) {
                cardImageArry = dict[@"cardImage"];
                if (cardImageArry.count == 1) {
                    NSDictionary *dict = cardImageArry.firstObject;
                    doc.cardOne.cardImagePath = dict[@"cardImage"];
                    doc.cardOne.cardImageDocId = dict[@"cardImageDocId"];
                    doc.cardOne.cardImageId = dict[@"cardImageId"];
                }
                if (cardImageArry.count == 2) {
                    NSDictionary *dict = cardImageArry.lastObject;
                    doc.cardTwo.cardImagePath = dict[@"cardImage"];
                    doc.cardTwo.cardImageDocId = dict[@"cardImageDocId"];
                    doc.cardTwo.cardImageId = dict[@"cardImageId"];
                }
            }
            
            NSString *logoImgStr = dict[@"logoImage"];
            if (logoImgStr != nil && logoImgStr.length != 0) {
                doc.logoImage = [NSString stringWithFormat:@"%@%@", sjOnlyIp, logoImgStr];
            }
            
            doc.licenseImageId = dict[@"licenseImageId"];
            doc.logoImageId = dict[@"logoImageId"];
            doc.homePage = dict[@"homePage"];
            doc.address = dict[@"address"];
            doc.email = dict[@"email"];
            doc.complete = dict[@"complete"];
            
            NSString *labelStr = dict[@"labels"];
            doc.labelsArry = [labelStr componentsSeparatedByString:@","];
        }
    }
    return doc;
}

@end
