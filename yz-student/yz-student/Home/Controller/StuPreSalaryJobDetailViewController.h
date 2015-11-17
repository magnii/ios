//
//  StuPreSalaryJobDetailViewController.h
//  yz-student
//
//  Created by 仲光磊 on 15/10/5.
//  Copyright © 2015年 cdq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class StuHomeLocalJob;

@interface StuPreSalaryJobDetailViewController : UIViewController

@property(nonatomic, strong)StuHomeLocalJob *oneJob;

- (void)setUpJobDetailWithJob:(StuHomeLocalJob*)job;

@end
