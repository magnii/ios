//
//  StuProfileMySignCell.m
//  yz-student
//
//  Created by 仲光磊 on 15/9/24.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import "StuProfileMySignCell.h"

@implementation StuProfileMySignCell

+ (instancetype)cellFromNibWithTableView:(UITableView*)tableView
{
    static NSString* ID = @"StuProfileMySignCell";
    StuProfileMySignCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"StuProfileMySignCell" owner:nil options:nil]lastObject];
    }
    
    return cell;
}

+(instancetype)cellFromNib
{
    StuProfileMySignCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"StuProfileMySignCell" owner:nil options:nil]lastObject];
    return cell;
}
@end
