//
//  SjCityAreas.m
//  yz-student
//
//  Created by 仲光磊 on 15/10/27.
//  Copyright © 2015年 cdq. All rights reserved.
//

#import "SjCityAreas.h"
#import "StuConfig.h"
#import "SjCity.h"
#import "SjCities.h"
#import "Sjarea.h"

@implementation SjCityAreas

+ (instancetype)cityAreasWithNet
{
    SjCityAreas *cityAreas = [[SjCityAreas alloc]init];
    
    NSString *httpIp = [NSString stringWithFormat:@"%@/web/city/getAllCityAndJobType", sjIp];
    NSData *data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:httpIp]] returningResponse:nil error:nil];
    NSArray *array = [NSArray array];
    if (data.length != 0) {
        array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    }
    
    NSDictionary *dict = array.firstObject;
    NSDictionary *dict2 = dict[@"jobtypes"];
    cityAreas.jobTypeNameArry = dict2[@"jobTypeNames"];
    cityAreas.jobTypeIdArry = dict2[@"jobTypeIds"];
    
    NSArray *arry1 = dict[@"city"];
    NSMutableArray *arryM1 = [NSMutableArray array];
    for (NSDictionary *dict3 in arry1) {
        SjCity *city = [[SjCity alloc]init];
        city.provinceId = dict3[@"id"];
        city.provinceName = dict3[@"name"];
        NSMutableArray *arryM2 = [NSMutableArray array];
        for (NSDictionary *dict4 in dict3[@"citys"]) {
            SjCities *cities = [[SjCities alloc]init];
            cities.cityId = dict4[@"id"];
            cities.cityName = dict4[@"name"];
            NSMutableArray *arryM3 = [NSMutableArray array];
            for (NSDictionary *dict5 in dict4[@"areas"]) {
                Sjarea *area = [[Sjarea alloc]init];
                area.areaId = dict5[@"id"];
                area.areaName = dict5[@"name"];
                [arryM3 addObject:area];
            }
            cities.cityAreaArry = arryM3;
            [arryM2 addObject:cities];
        }
        city.citiesArry = arryM2;
        [arryM1 addObject:city];
    }
    cityAreas.cityArry = arryM1;
    
    return cityAreas;
}

@end
