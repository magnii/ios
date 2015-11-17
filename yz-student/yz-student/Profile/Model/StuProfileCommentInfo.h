//
//  StuProfileCommentInfo.h
//  yz-student
//
//  Created by 仲光磊 on 15/10/13.
//  Copyright © 2015年 cdq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StuProfileCommentInfo : NSObject
@property(nonatomic, copy)NSString *commentId;
@property(nonatomic, assign)int jobStars;
@property(nonatomic, assign)int salaryStars;
@property(nonatomic, assign)int payTimeStars;
@property(nonatomic, assign)int attitudeStars;
@property(nonatomic, assign)int averageStars;
@property(nonatomic, copy)NSString *content;

+ (instancetype)getMyCommentWithSessionId:(NSString*)sessionId JobId:(NSString*)jobId;
+ (BOOL)commentsBtnClickWithCommentId:(NSString*)commentId JobStars:(NSString*)jobStars SalaryStars:(NSString*)salaryStars PayTimeStars:(NSString*)payTimeStars AttitudeStars:(NSString*)attitudeStars AverageStars:(NSString*)averageStars Content:(NSString*)content;

@end
