//
//  StuIncomePayTableViewCell.m
//  yz-student
//
//  Created by 仲光磊 on 15/9/17.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import "StuIncomePayTableViewCell.h"

@implementation StuIncomePayTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellFromNibWithTableView:(UITableView *)tableView
{
    StuIncomePayTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StuIncomPayCell"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"StuIncomePayTableViewCell" owner:nil options:nil]lastObject];
    }
    return cell;
}

@end
