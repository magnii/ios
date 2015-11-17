//
//  StuHomeFourBtnOne.h
//  yz-student
//
//  Created by 仲光磊 on 15/9/2.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StuHomeFourBtnOne : UIView

@property(nonatomic, strong) UIImageView *imgV;
@property(nonatomic, strong) UILabel *bottomL;

+ (instancetype) btnOneWithImg:(NSString*)img bottomL:(NSString*)bottomL;

@end
