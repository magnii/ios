//
//  StuJobDetailViewController.h
//  yz-student
//
//  Created by 仲光磊 on 15/9/6.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import <UIKit/UIKit.h>

@class StuHomeLocalJob;

@interface StuJobDetailViewController : UIViewController

@property(nonatomic, strong)StuHomeLocalJob *oneJob;

- (void)setUpJobDetailWithJob:(StuHomeLocalJob*)job;
@end
