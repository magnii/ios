//
//  StuProfileHomeHeadView.h
//  yz-student
//
//  Created by 仲光磊 on 15/9/15.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StuProfileHomeHeadView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *headImg;
@property (weak, nonatomic) IBOutlet UILabel *headName;
@property (weak, nonatomic) IBOutlet UILabel *headScore;
@property (weak, nonatomic) IBOutlet UILabel *headInvites;
- (IBAction)headSignBtnClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *headSignDays;

@property (weak, nonatomic) IBOutlet UIImageView *headLevelImg;

@property (weak, nonatomic) IBOutlet UIButton *headSignBtn;

+(instancetype)viewFromNib;

@end
