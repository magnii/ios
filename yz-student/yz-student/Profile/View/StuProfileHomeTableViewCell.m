//
//  StuProfileHomeTableViewCell.m
//  yz-student
//
//  Created by 仲光磊 on 15/9/14.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import "StuProfileHomeTableViewCell.h"

@implementation StuProfileHomeTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWithNibWithTableView:(UITableView *)tableView
{
    StuProfileHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StuProfileHomeCell"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"StuProfileHome" owner:nil options:nil]lastObject];
    }
    return cell;
}

@end
