//
//  SjCityAreas.h
//  yz-student
//
//  Created by 仲光磊 on 15/10/27.
//  Copyright © 2015年 cdq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SjCityAreas : NSObject

@property(nonatomic, strong)NSArray *jobTypeIdArry;
@property(nonatomic, strong)NSArray *jobTypeNameArry;

@property(nonatomic, strong)NSArray *cityArry;

+(instancetype)cityAreasWithNet;

@end
