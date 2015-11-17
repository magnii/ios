//
//  StuWalletInfo.h
//  yz-student
//
//  Created by 仲光磊 on 15/9/16.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StuWalletInfo : NSObject

@property(nonatomic, copy)NSString *money;
@property(nonatomic, assign)long points;
@property(nonatomic, copy)NSString *alipayNum;
@property(nonatomic, assign)long maxPoints;

+(instancetype)remainMoneyWithSessionId:(NSString*)sessionId;
+(void)bindAlipayWithSessionId:(NSString*)sessionId AlipyNum:(NSString*)alipyNum;
+(void)toCashWithSessionId:(NSString*)sessionId DealType:(NSString*)dealType Amount:(NSString*)amount TradeNum:(NSString*)tradeNum;
+(void)exchangePointWithSessionId:(NSString*)sessionId Points:(NSString*)points;

@end
