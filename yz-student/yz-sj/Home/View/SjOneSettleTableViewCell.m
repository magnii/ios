//
//  SjOneSettleTableViewCell.m
//  yz-student
//
//  Created by 仲光磊 on 15/11/6.
//  Copyright © 2015年 cdq. All rights reserved.
//

#import "SjOneSettleTableViewCell.h"

@implementation SjOneSettleTableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID=@"SjOneSettleTableViewCell";
    SjOneSettleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"SjOneSettleTableViewCell" owner:nil options:nil]lastObject];
    }
    return cell;
}
@end
