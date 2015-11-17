//
//  SjRegStaffTableViewCell.h
//  yz-student
//
//  Created by 仲光磊 on 15/11/5.
//  Copyright © 2015年 cdq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SjRegStaffTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *dateL;
@property (weak, nonatomic) IBOutlet UIButton *detailBtn;

+(instancetype)cellWithTableView:(UITableView*)tableView;
@end
