//
//  StuProfileMyInfoTableViewCell.m
//  yz-student
//
//  Created by 仲光磊 on 15/9/18.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import "StuProfileMyInfoTableViewCell.h"

@implementation StuProfileMyInfoTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellFromNibWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"StuProfileMyInfoCell";
    StuProfileMyInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"StuProfileMyInfoTableViewCell" owner:nil options:nil]lastObject];
    }
    return cell;
}

@end
