//
//  StuIncomePayTableViewCell.h
//  yz-student
//
//  Created by 仲光磊 on 15/9/17.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StuIncomePayTableViewCell : UITableViewCell

+(instancetype)cellFromNibWithTableView:(UITableView*)tableView;
@property (weak, nonatomic) IBOutlet UILabel *createTimeL;
@property (weak, nonatomic) IBOutlet UILabel *dealTypeL;
@property (weak, nonatomic) IBOutlet UILabel *moneyL;

@end
