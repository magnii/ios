//
//  Account.m
//  weiboNew
//
//  Created by Kdeqhi on 15/8/11.
//  Copyright (c) 2015年 Kdeqhi. All rights reserved.
//

#import "Account.h"

@implementation Account

+(instancetype)accountWithUid:(NSString *)uid Phone:(NSString *)phone Passwd:(NSString *)pwd
{
    Account *account = [[Account alloc]init];
    account.uid = uid;
    account.name = phone;
    account.passwd = pwd;
    return account;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.name forKey:@"name"];
    [encoder encodeObject:self.passwd forKey:@"passwd"];
    [encoder encodeObject:self.uid forKey:@"uid"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        self.name = [decoder decodeObjectForKey:@"name"];
        self.passwd = [decoder decodeObjectForKey:@"passwd"];
        self.uid = [decoder decodeObjectForKey:@"uid"];
    }
    return self;
}

@end
