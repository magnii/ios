//
//  HomeFourBtnView.h
//  yz-student
//
//  Created by 仲光磊 on 15/9/2.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class StuHomeFourBtnOne;

@interface HomeFourBtnView : UIView

@property (strong, nonatomic) StuHomeFourBtnOne *highSalaryView;
@property (strong, nonatomic) StuHomeFourBtnOne *jobBBView;
@property (strong, nonatomic) StuHomeFourBtnOne *trainView;
@property (strong, nonatomic) StuHomeFourBtnOne *preSalaryView;

+ (instancetype)fourBtnInstance;

- (void)setAllFrames;
@end
