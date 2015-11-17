//
//  StuProfileCommentsTableViewCell.m
//  yz-student
//
//  Created by 仲光磊 on 15/9/20.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import "StuProfileCommentsTableViewCell.h"

@implementation StuProfileCommentsTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

+ (instancetype)cellFromNibWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"StuProfileCommentsCell";
    StuProfileCommentsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"StuProfileCommentsTableViewCell" owner:nil options:nil]lastObject];
    }
    return cell;
}
@end
