//
//  StuManualSelLocationTableViewController.h
//  yz-student
//
//  Created by 仲光磊 on 15/9/4.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol StuManualSelLocationDelegate <NSObject>

- (void)setLocationCity:(NSString*)cityName;

@end

@interface StuManualSelLocationTableViewController : UITableViewController

@property(nonatomic, assign)id <StuManualSelLocationDelegate> delegate;

@end
