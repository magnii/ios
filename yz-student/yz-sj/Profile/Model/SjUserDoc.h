//
//  SjUserDoc.h
//  yz-student
//
//  Created by 仲光磊 on 15/10/30.
//  Copyright © 2015年 cdq. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SjCardIdPath;

@interface SjUserDoc : NSObject

@property(nonatomic, copy)NSString *name;
@property(nonatomic, copy)NSString *contactPerson;
@property(nonatomic, copy)NSString *industry;
@property(nonatomic, copy)NSString *scale;
@property(nonatomic, copy)NSString *address;
@property(nonatomic, copy)NSString *type;//enterprise
@property(nonatomic, copy)NSString *contactNumber;
@property(nonatomic, copy)NSString *attribute;//4
@property(nonatomic, copy)NSString *email;
@property(nonatomic, copy)NSString *licenseIdStatus;
@property(nonatomic, copy)NSString *cardIdStatus;
@property(nonatomic, copy)NSString *brifIntrodution;
@property(nonatomic, copy)NSString *licenseImage;
@property(nonatomic, strong)SjCardIdPath *cardOne;
@property(nonatomic, strong)SjCardIdPath *cardTwo;
@property(nonatomic, copy)NSString *logoImage;
@property(nonatomic, copy)NSString *licenseImageId;
@property(nonatomic, copy)NSString *logoImageId;
@property(nonatomic, copy)NSString *homePage;
@property(nonatomic, strong)NSArray *labelsArry;
@property(nonatomic, copy)NSString *complete;

+(instancetype)sjUserDocWithSessionId:(NSString*)sessionId;

@end