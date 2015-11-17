//
//  StuProfileInfo.h
//  yz-student
//
//  Created by 仲光磊 on 15/9/15.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StuProfileInfo : NSObject

@property(nonatomic, copy)NSString *headPicImg;
@property(nonatomic, assign)long points;
@property(nonatomic, assign)long signInDays;
@property(nonatomic, assign)long invites;
@property(nonatomic, copy)NSString *alipayNum;
@property(nonatomic, assign)BOOL isTodaySignIn;
@property(nonatomic, copy)NSString *mobile;
@property(nonatomic, assign)long maxPoints;

+(instancetype)profileInfoWithUserMobile:(NSString*)mobile Passwd:(NSString*)passwd;

@end
