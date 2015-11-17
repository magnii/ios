//
//  StuProfileMyBBDetailDetailDetailTableCell.h
//  yz-student
//
//  Created by 仲光磊 on 15/10/21.
//  Copyright © 2015年 cdq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StuProfileMyBBDetailDetailDetailTableCell : UITableViewCell

@property(nonatomic, strong)UILabel *peopleL;
@property(nonatomic, strong)UILabel *telephoneL;
@property(nonatomic, strong)UILabel *signUpDateL;
@property(nonatomic, strong)UIButton *hiredBtn;
@property(nonatomic, strong)UIButton *checkSignUpBtn;

+ (instancetype)cellWithTableView:(UITableView*)tableView;

@end
