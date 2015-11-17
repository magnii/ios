//
//  StuLocalCityInfo.h
//  yz-student
//
//  Created by 仲光磊 on 15/9/4.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import <Foundation/Foundation.h>

@class StuLocation;

@interface StuLocationTool : NSObject

+ (void)saveLocation:(StuLocation *)location;

+ (StuLocation *)location;

@end

