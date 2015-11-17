//
//  StuLocation.h
//  yz-student
//
//  Created by 仲光磊 on 15/9/4.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StuLocation : NSObject <NSCoding>


@property(nonatomic, copy)NSString *provinceName;
@property(nonatomic, copy)NSString *cityName;
@property(nonatomic, copy)NSString *subCityName;
@property(nonatomic, copy)NSString *streatName;
@property(nonatomic, copy)NSString *longitude;
@property(nonatomic, copy)NSString *latitude;

+ (instancetype)locationWithProvince:(NSString *)province City:(NSString *)city SubCity:(id)subCity Streat:(NSString *)streat;

@end
