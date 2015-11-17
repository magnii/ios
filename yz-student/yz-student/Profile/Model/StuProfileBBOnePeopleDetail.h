//
//  StuProfileBBOnePeopleDetail.h
//  yz-student
//
//  Created by 仲光磊 on 15/9/24.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import <Foundation/Foundation.h>

@class StuProfileBBMemberInfoOne;

@interface StuProfileBBOnePeopleDetail : NSObject

@property(nonatomic, copy)NSString *signUpDateId;
@property(nonatomic, copy)NSString *relationId;
@property(nonatomic, copy)NSArray *oneArray;
@property(nonatomic, copy)NSString *enrolNum;

+(instancetype)bbOnePelpleDetailWithRelationId:(NSString*)relationId;

@end
