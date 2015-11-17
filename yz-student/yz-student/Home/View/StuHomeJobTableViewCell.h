//
//  StuHomeJobTableViewCell.h
//  yz-student
//
//  Created by 仲光磊 on 15/9/3.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StuHomeJobTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *jobTypeBtn;
@property (weak, nonatomic) IBOutlet UILabel *jobTitleL;
@property (weak, nonatomic) IBOutlet UIButton *jobAddrBtn;
@property (weak, nonatomic) IBOutlet UILabel *jobSalaryL;
@property (weak, nonatomic) IBOutlet UILabel *jobStartDateL;

@property (weak, nonatomic) IBOutlet UIImageView *baoBtn;

+ (instancetype)cellNibWithTableView:(UITableView*)tableView;

@end
