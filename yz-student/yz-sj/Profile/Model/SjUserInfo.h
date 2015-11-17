//
//  SjUserInfo.h
//  yz-student
//
//  Created by 仲光磊 on 15/10/29.
//  Copyright © 2015年 cdq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SjUserInfo : NSObject

@property(nonatomic, copy)NSString *contactNumber;
@property(nonatomic, copy)NSString *complete;
@property(nonatomic, copy)NSString *userName;
@property(nonatomic, copy)NSString *companyName;
@property(nonatomic, assign)int points;
@property(nonatomic, copy)NSString *contactPerson;

+(instancetype)sjUserInfoWithSessionId:(NSString*)sessionId;

@end
