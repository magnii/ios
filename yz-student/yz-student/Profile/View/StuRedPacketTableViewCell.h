//
//  StuRedPacketTableViewCell.h
//  yz-student
//
//  Created by 仲光磊 on 15/9/17.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StuRedPacketTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *timeL;
@property (weak, nonatomic) IBOutlet UILabel *contentL;
- (IBAction)gotBtnClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *gotBtn;

@property (weak, nonatomic) IBOutlet UIButton *redPackageBtn;
+(instancetype)cellFromNibWithTableView:(UITableView*)tableView;

@property(nonatomic, copy)NSString *redPackageId;

@end
