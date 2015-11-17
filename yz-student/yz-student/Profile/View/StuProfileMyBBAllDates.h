//
//  StuProfileMyBBAllDates.h
//  yz-student
//
//  Created by 仲光磊 on 15/10/20.
//  Copyright © 2015年 cdq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StuProfileMyBBAllDates : UIView

@property(nonatomic, strong)UILabel *dateL;
@property(nonatomic, strong)UIView *timeView;
@property(nonatomic, strong)UILabel *timeL;
@property(nonatomic, strong)UILabel *hourL;
@property(nonatomic, strong)UILabel *minuteL;
@property(nonatomic, strong)UILabel *secondL;
@property(nonatomic, strong)UILabel *secondWordL;
@property(nonatomic, strong)UILabel *stateWordL;
@property(nonatomic, strong)UILabel *stateL;
@property(nonatomic, strong)UIButton *detailBtn;

@property(nonatomic, assign)int endTime;

+(instancetype)loadView;
- (void)restAllFrames;

@end
