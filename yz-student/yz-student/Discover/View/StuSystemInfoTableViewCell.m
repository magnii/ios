//
//  StuSystemInfoTableViewCell.m
//  yz-student
//
//  Created by 仲光磊 on 15/9/14.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import "StuSystemInfoTableViewCell.h"

@implementation StuSystemInfoTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(instancetype)cellFromNibWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"StuSystemInfoCell";
    StuSystemInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"StuSystemInfoTableViewCell" owner:nil options:nil]lastObject];
    }
    
    return cell;
}

@end
