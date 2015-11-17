//
//  StuProfileCompanyInfoTableViewCell.h
//  yz-student
//
//  Created by 仲光磊 on 15/9/26.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StuProfileCompanyInfoTableViewCell : UITableViewCell

+(instancetype)cellFromNibWitTableView:(UITableView *)tableView;
@property (weak, nonatomic) IBOutlet UILabel *companyNameL;
@property (weak, nonatomic) IBOutlet UILabel *companyAddressL;

@end
