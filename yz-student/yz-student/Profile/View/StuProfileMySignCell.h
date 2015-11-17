//
//  StuProfileMySignCell.h
//  yz-student
//
//  Created by 仲光磊 on 15/9/24.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StuProfileMySignCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nowL;
@property (weak, nonatomic) IBOutlet UILabel *signInDateL;
@property (weak, nonatomic) IBOutlet UILabel *signInAddr;
@property (weak, nonatomic) IBOutlet UILabel *signOutDateL;
@property (weak, nonatomic) IBOutlet UILabel *sinOutAddrL;

+ (instancetype)cellFromNibWithTableView:(UITableView*)tableView;

+ (instancetype)cellFromNib;

@end
