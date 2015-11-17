//
//  StuTrainningTableViewCell.m
//  yz-student
//
//  Created by 仲光磊 on 15/9/10.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import "StuTrainningTableViewCell.h"

@implementation StuTrainningTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(instancetype)cellWithTableView:(UITableView*)tableView
{
    static NSString *ID = @"StuTrainningTableViewCell";
    StuTrainningTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"StuTrainningTableViewCell" owner:nil options:nil]lastObject];
    }
    return cell;
    
}

@end
