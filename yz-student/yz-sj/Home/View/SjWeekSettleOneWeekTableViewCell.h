//
//  SjWeekSettleOneWeekTableViewCell.h
//  yz-student
//
//  Created by 仲光磊 on 15/11/9.
//  Copyright © 2015年 cdq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SjWeekSettleOneWeekTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *phoneL;
@property (weak, nonatomic) IBOutlet UILabel *daysL;
@property (weak, nonatomic) IBOutlet UIButton *signBtn;
@property (weak, nonatomic) IBOutlet UILabel *salaryL;
@property (weak, nonatomic) IBOutlet UITextField *workDayTF;
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;

+(instancetype)cellWithTableView:(UITableView*)tableView;

@end
