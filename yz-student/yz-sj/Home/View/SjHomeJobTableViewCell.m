//
//  SjHomeJobTableViewCell.m
//  yz-student
//
//  Created by 仲光磊 on 15/10/22.
//  Copyright © 2015年 cdq. All rights reserved.
//

#import "SjHomeJobTableViewCell.h"

@implementation SjHomeJobTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellFromNibWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"SjHomeJobTableViewCell";
    SjHomeJobTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"SjHomeJobTableViewCell" owner:nil options:nil]lastObject];
    }
    return cell;
}

@end
