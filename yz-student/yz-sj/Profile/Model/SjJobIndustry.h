//
//  SjJobIndustry.h
//  yz-student
//
//  Created by 仲光磊 on 15/11/3.
//  Copyright © 2015年 cdq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SjJobIndustry : NSObject

@property(nonatomic, strong)NSString *industryId;
@property(nonatomic, strong)NSString *industryName;

+(NSArray*)jobIndustryFromNet;

@end
