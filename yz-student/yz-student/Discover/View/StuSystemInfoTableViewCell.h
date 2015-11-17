//
//  StuSystemInfoTableViewCell.h
//  yz-student
//
//  Created by 仲光磊 on 15/9/14.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StuSystemInfoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *cellBtn;
@property (weak, nonatomic) IBOutlet UILabel *cellTimeL;
@property (weak, nonatomic) IBOutlet UILabel *cellReadL;
@property (weak, nonatomic) IBOutlet UILabel *cellContentL;




+(instancetype)cellFromNibWithTableView:(UITableView*)tableView;

@end
