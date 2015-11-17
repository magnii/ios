//
//  AccountTool.h
//  weiboNew
//
//  Created by Kdeqhi on 15/8/11.
//  Copyright (c) 2015年 Kdeqhi. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Account;

@interface AccountTool : NSObject

+ (Account *)account:(NSString*)path;

+ (void)saveAccount:(Account *)account Path:(NSString*)path;

@end
