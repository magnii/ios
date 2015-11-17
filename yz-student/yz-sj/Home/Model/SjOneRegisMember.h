//
//  SjOneRegisMember.h
//  yz-student
//
//  Created by 仲光磊 on 15/11/5.
//  Copyright © 2015年 cdq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SjOneRegisMember : NSObject

@property(nonatomic, copy)NSString *name;
@property(nonatomic, copy)NSString *memberId;
@property(nonatomic, assign)int salary;
@property(nonatomic, copy)NSString *mobile;
@property(nonatomic, copy)NSString *signInTime;
@property(nonatomic, copy)NSString *signInAddress;
@property(nonatomic, copy)NSString *signOutTime;
@property(nonatomic, copy)NSString *signOutAddress;

@end
