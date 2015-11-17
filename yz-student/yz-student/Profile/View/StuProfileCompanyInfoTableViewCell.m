//
//  StuProfileCompanyInfoTableViewCell.m
//  yz-student
//
//  Created by 仲光磊 on 15/9/26.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import "StuProfileCompanyInfoTableViewCell.h"

@implementation StuProfileCompanyInfoTableViewCell

+ (instancetype)cellFromNibWitTableView:(UITableView *)tableView
{
    static NSString *ID = @"StuProfileCompanyInfoCell";
    StuProfileCompanyInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"StuProfileCompanyInfoTableViewCell" owner:nil options:nil]lastObject];
    }
    return cell;
}
@end
