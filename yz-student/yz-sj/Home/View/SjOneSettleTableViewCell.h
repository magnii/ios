//
//  SjOneSettleTableViewCell.h
//  yz-student
//
//  Created by 仲光磊 on 15/11/6.
//  Copyright © 2015年 cdq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SjOneSettleTableViewCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView*)tableView;
@property (weak, nonatomic) IBOutlet UIButton *nameBtn;
@property (weak, nonatomic) IBOutlet UILabel *telephoneL;
@property (weak, nonatomic) IBOutlet UILabel *salaryL;
@property (weak, nonatomic) IBOutlet UIButton *checkSignBtn;

@end
