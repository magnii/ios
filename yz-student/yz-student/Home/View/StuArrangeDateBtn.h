//
//  StuArrangeDateBtn.h
//  yz-student
//
//  Created by 仲光磊 on 15/9/11.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StuArrangeDateBtn : UIView
@property (weak, nonatomic) IBOutlet UIButton *arrangeViewBtn;
@property (weak, nonatomic) IBOutlet UIImageView *arrangeViewImg;

+(instancetype)buttonWithNib;

@end
