//
//  StuPreSalaryContentTableViewCell.h
//  yz-student
//
//  Created by 仲光磊 on 15/10/8.
//  Copyright © 2015年 cdq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StuPreSalaryContentTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *dateL;
@property (weak, nonatomic) IBOutlet UILabel *moneyL;
@property (weak, nonatomic) IBOutlet UILabel *stateL;

+(instancetype)cellWithTableView:(UITableView*)tableView;

@end
