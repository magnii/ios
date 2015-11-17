//
//  StuProfileHomeTableViewCell.h
//  yz-student
//
//  Created by 仲光磊 on 15/9/14.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StuProfileHomeTableViewCell : UITableViewCell

+(instancetype)cellWithNibWithTableView:(UITableView*)tableView;

@property (weak, nonatomic) IBOutlet UIImageView *cellImageView;
@property (weak, nonatomic) IBOutlet UILabel *cellLabel;


@end
