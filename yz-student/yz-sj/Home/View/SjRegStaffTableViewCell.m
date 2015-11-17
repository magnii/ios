//
//  SjRegStaffTableViewCell.m
//  yz-student
//
//  Created by 仲光磊 on 15/11/5.
//  Copyright © 2015年 cdq. All rights reserved.
//

#import "SjRegStaffTableViewCell.h"

@implementation SjRegStaffTableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"SjRegStaffTableViewCell";
    SjRegStaffTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"SjRegStaffTableViewCell" owner:self options:nil]lastObject];
    }
    return cell;
}

@end
