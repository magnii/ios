//
//  Account.h
//  weiboNew
//
//  Created by Kdeqhi on 15/8/11.
//  Copyright (c) 2015年 Kdeqhi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Account : NSObject <NSCoding>


@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *passwd;

+(instancetype)accountWithUid:(NSString*)uid Phone:(NSString*)phone Passwd:(NSString*)pwd;

@end
