//
//  SjOneRegStaffViewController.h
//  yz-student
//
//  Created by 仲光磊 on 15/11/6.
//  Copyright © 2015年 cdq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SjDaySettle.h"
@class SjDaySettle;

@interface SjOneRegStaffViewController : UIViewController

@property(nonatomic, strong)SjDaySettle *oneDaySettle;
@property(nonatomic, assign)SettleType settleType;

@end
