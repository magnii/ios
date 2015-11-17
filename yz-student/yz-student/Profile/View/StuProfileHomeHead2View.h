//
//  StuProfileHomeHead2View.h
//  yz-student
//
//  Created by 仲光磊 on 15/10/3.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StuProfileHomeHead2View : UIView
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;

+(instancetype)headViewFromNib;

@end
