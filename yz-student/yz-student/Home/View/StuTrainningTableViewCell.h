//
//  StuTrainningTableViewCell.h
//  yz-student
//
//  Created by 仲光磊 on 15/9/10.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StuTrainningTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *trainingImageView;
@property (weak, nonatomic) IBOutlet UILabel *trainingTitle;
@property (weak, nonatomic) IBOutlet UILabel *trainingStartDate;
@property (weak, nonatomic) IBOutlet UILabel *trainingEndDate;
@property (weak, nonatomic) IBOutlet UILabel *trainingPeoples;
@property (weak, nonatomic) IBOutlet UILabel *trainingAddress;

+(instancetype)cellWithTableView:(UITableView*)tableView;

@end
