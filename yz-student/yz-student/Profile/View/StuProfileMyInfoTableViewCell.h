//
//  StuProfileMyInfoTableViewCell.h
//  yz-student
//
//  Created by 仲光磊 on 15/9/18.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StuProfileMyInfoTableViewCell : UITableViewCell

+(instancetype)cellFromNibWithTableView:(UITableView*)tableView;
@property (weak, nonatomic) IBOutlet UIButton *infoLeftBtn;
@property (weak, nonatomic) IBOutlet UIButton *infoMidBtn;
@property (weak, nonatomic) IBOutlet UITextView *infoRightTextView;

@end
