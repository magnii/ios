//
//  StuProfileCommentsTableViewCell.h
//  yz-student
//
//  Created by 仲光磊 on 15/9/20.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StuProfileCommentsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *commentsImg;
@property (weak, nonatomic) IBOutlet UILabel *commentsName;
@property (weak, nonatomic) IBOutlet UILabel *commentsDate;
@property (weak, nonatomic) IBOutlet UILabel *commentsContent;

+(instancetype)cellFromNibWithTableView:(UITableView*)tableView;
@end
