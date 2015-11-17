//
//  StuHomeJobTableViewCell.m
//  yz-student
//
//  Created by 仲光磊 on 15/9/3.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import "StuHomeJobTableViewCell.h"

@implementation StuHomeJobTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellNibWithTableView:(UITableView*)tableView
{
    static NSString *ID = @"StuHomeJobTableViewCell";
    StuHomeJobTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"StuHomeJobCell" owner:nil options:nil]lastObject];
    }
    
    return cell;
}

@end
