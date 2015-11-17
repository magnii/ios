//
//  StuPreSalaryContentTableViewCell.m
//  yz-student
//
//  Created by 仲光磊 on 15/10/8.
//  Copyright © 2015年 cdq. All rights reserved.
//

#import "StuPreSalaryContentTableViewCell.h"

@implementation StuPreSalaryContentTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"StuPreSalaryContentTableViewCell";
    
    StuPreSalaryContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"StuPreSalaryContentTableViewCell" owner:nil options:nil]lastObject];
    }
    return cell;
}

@end
