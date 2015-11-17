//
//  SjHomeJobTableViewCell.h
//  yz-student
//
//  Created by 仲光磊 on 15/10/22.
//  Copyright © 2015年 cdq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SjHomeJobTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *jobTypeBtn;
@property (weak, nonatomic) IBOutlet UILabel *jobNameL;
@property (weak, nonatomic) IBOutlet UILabel *jobDateL;
@property (weak, nonatomic) IBOutlet UIImageView *imgBao;

+(instancetype)cellFromNibWithTableView:(UITableView*)tableView;
@end
