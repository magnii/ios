//
//  StuProfileComments.h
//  yz-student
//
//  Created by 仲光磊 on 15/9/20.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StuProfileComments : NSObject

@property(nonatomic, copy)NSString *commentsImg;
@property(nonatomic, copy)NSString *commentsName;
@property(nonatomic, copy)NSString *commentsDate;
@property(nonatomic, copy)NSString *commentsContent;
@property(nonatomic, copy)NSString *commentsMemberId;

+(NSArray*)loadCommentsWithJobId:(NSString*)jobId IsArranged:(NSString*)isArraged CurrentPage:(NSString*)currentPage PageSize:(NSString*)pageSize;
+(BOOL)pushCommentsWithSessionId:(NSString*)sessionId JobId:(NSString*)jobId Content:(NSString*)content MemberAttr:(NSString*)memberAttr;
@end
