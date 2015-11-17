//
//  StuLocation.m
//  yz-student
//
//  Created by 仲光磊 on 15/9/4.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import "StuLocation.h"

@implementation StuLocation

+ (instancetype)locationWithProvince:(NSString *)province City:(NSString *)city SubCity:(id)subCity Streat:(NSString *)streat
{
    StuLocation *location = [[StuLocation alloc]init];
    location.cityName = city;
    location.provinceName = province;
    location.subCityName = subCity;
    location.streatName = streat;
    return location;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.cityName forKey:@"cityName"];
    [encoder encodeObject:self.provinceName forKey:@"provinceName"];
    [encoder encodeObject:self.subCityName forKey:@"subCityName"];
    [encoder encodeObject:self.streatName forKey:@"streatName"];
    [encoder encodeObject:self.longitude forKey:@"longitude"];
    [encoder encodeObject:self.latitude forKey:@"latitude"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        self.cityName = [decoder decodeObjectForKey:@"cityName"];
        self.provinceName = [decoder decodeObjectForKey:@"provinceName"];
        self.subCityName = [decoder decodeObjectForKey:@"subCityName"];
        self.streatName = [decoder decodeObjectForKey:@"streatName"];
        self.latitude = [decoder decodeObjectForKey:@"latitude"];
        self.longitude = [decoder decodeObjectForKey:@"longitude"];
    }
    return self;
}

@end
