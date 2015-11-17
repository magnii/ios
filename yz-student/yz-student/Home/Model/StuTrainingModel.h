//
//  StuTrainingModel.h
//  yz-student
//
//  Created by 仲光磊 on 15/9/10.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StuTrainingModel : NSObject

@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSString *imgName;
@property(nonatomic, copy) NSString *startDate;
@property(nonatomic, copy) NSString *endDate;
@property(nonatomic, copy) NSString *address;
@property(nonatomic, copy) NSString *peoples;
@property(nonatomic, copy) NSString *content;
@property(nonatomic, copy) NSString *telephone;
@property(nonatomic, copy) NSString *qq;
@property(nonatomic, copy) NSString *contactP;
@property(nonatomic, copy) NSString *trainId;
@property(nonatomic, copy) NSString *hasSignUp;

+(NSArray*)trainingModelWithCityId:(NSString*)cityId CurrentPage:(NSString*)currentPage PageSize:(NSString*)pageSize Status:(NSString*)status Cond:(NSString*)cond Value:(NSString*)value;

+(BOOL)trainingIWantWithSessionId:(NSString*)sessionId TrainingId:(NSString*)trainingId;

@end
