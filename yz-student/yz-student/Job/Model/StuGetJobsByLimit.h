//
//  StuGetJobsByLimit.h
//  yz-student
//
//  Created by 仲光磊 on 15/9/13.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StuGetJobsByLimit : NSObject

@property(nonatomic, strong) NSArray *cityareas;
@property(nonatomic, strong) NSArray *jobTypes;

+ (instancetype)getCityAreasJobTypeWithCityId:(NSString*)cityId;

@end
