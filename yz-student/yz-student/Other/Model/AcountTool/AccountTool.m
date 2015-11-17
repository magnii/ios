//
//  AccountTool.m
//  weiboNew
//
//  Created by Kdeqhi on 15/8/11.
//  Copyright (c) 2015年 Kdeqhi. All rights reserved.
//

#import "AccountTool.h"
#import "Account.h"

#define AccountPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.archive"]

@implementation AccountTool

+ (Account *)account:(NSString*)path
{
    NSString *archivePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:path];
    return [NSKeyedUnarchiver unarchiveObjectWithFile:archivePath];
}

+ (void)saveAccount:(Account *)account Path:(NSString*)path
{
    Account *localAccout = [AccountTool account:path];
    if (account.uid == nil || account.uid.length == 0) {
        account.uid = localAccout.uid;
    }
    if (account.name == nil || account.name.length == 0) {
        account.name = localAccout.name;
    }
    if (account.passwd == nil || account.passwd.length == 0) {
        account.passwd = localAccout.passwd;
    }
    
    NSString *archivePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:path];
    [NSKeyedArchiver archiveRootObject:account toFile:archivePath];
}

@end
