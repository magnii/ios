//
//  SjWeekSettleOneWeekTableViewCell.m
//  yz-student
//
//  Created by 仲光磊 on 15/11/9.
//  Copyright © 2015年 cdq. All rights reserved.
//

#import "SjWeekSettleOneWeekTableViewCell.h"

@implementation SjWeekSettleOneWeekTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
//    static NSString *ID = @"SjWeekSettleOneWeekTableViewCell";
//    
//    SjWeekSettleOneWeekTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
//    if (cell == nil) {
        SjWeekSettleOneWeekTableViewCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"SjWeekSettleOneWeekTableViewCell" owner:nil options:nil]lastObject];
//    }
    return cell;
}

@end
