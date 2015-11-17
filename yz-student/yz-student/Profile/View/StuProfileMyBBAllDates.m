//
//  StuProfileMyBBAllDates.m
//  yz-student
//
//  Created by 仲光磊 on 15/10/20.
//  Copyright © 2015年 cdq. All rights reserved.
//

#import "StuProfileMyBBAllDates.h"
#import "StuConfig.h"


#define paddingX 10
#define labelW 100
#define labelH 15
#define myYellowColor [UIColor colorWithRed:240/255.0 green:143/255.0 blue:2/255.0 alpha:1.0]
#define myBlueColor [UIColor colorWithRed:28/255.0 green:141/255.0 blue:213/255.0 alpha:1.0]
#define textSize 14

@implementation StuProfileMyBBAllDates

- (UILabel *)dateL
{
    if (_dateL == nil) {
        _dateL = [[UILabel alloc]init];
        [_dateL setTextColor:myYellowColor];
        _dateL.font = [UIFont boldSystemFontOfSize:textSize];
    }
    return _dateL;
}

- (UIView *)timeView
{
    if (_timeView == nil) {
        _timeView = [[UIView alloc]init];
    }
    
    [_timeView addSubview:self.timeL];
    [_timeView addSubview:self.hourL];
    [_timeView addSubview:self.minuteL];
    [_timeView addSubview:self.secondL];
    [_timeView addSubview:self.secondWordL];
    
    self.timeL.frame = CGRectMake(0, 0, 60, labelH);
    [self.timeL setText:@"倒计时："];
    self.hourL.frame = CGRectMake(CGRectGetMaxX(self.timeL.frame), 0, 30, labelH);
    //[self.hourL setText:@"2时"];
    self.minuteL.frame = CGRectMake(CGRectGetMaxX(self.hourL.frame), 0, 30, labelH);
    //[self.minuteL setText:@"59分"];
    self.secondL.frame = CGRectMake(CGRectGetMaxX(self.minuteL.frame), 0, 17, labelH);
    //[self.secondL setText:@"49"];
    self.secondWordL.frame = CGRectMake(CGRectGetMaxX(self.secondL.frame), 0, 15, labelH);
    [self.secondWordL setText:@"秒"];
    return _timeView;
}

- (UILabel *)timeL
{
    if (_timeL == nil) {
        _timeL = [[UILabel alloc]init];
        _timeL.font = [UIFont boldSystemFontOfSize:textSize];
    }
    return _timeL;
}
- (UILabel *)hourL
{
    if (_hourL == nil) {
        _hourL = [[UILabel alloc]init];
        _hourL.font = [UIFont boldSystemFontOfSize:textSize];
    }
    return _hourL;
}
- (UILabel *)minuteL
{
    if (_minuteL == nil) {
        _minuteL = [[UILabel alloc]init];
        _minuteL.font = [UIFont boldSystemFontOfSize:textSize];
    }
    return _minuteL;
}
- (UILabel *)secondL
{
    if (_secondL == nil) {
        _secondL = [[UILabel alloc]init];
        _secondL.font = [UIFont boldSystemFontOfSize:textSize];
    }
    return _secondL;
}
- (UILabel *)secondWordL
{
    if (_secondWordL == nil) {
        _secondWordL = [[UILabel alloc]init];
        _secondWordL.font = [UIFont boldSystemFontOfSize:textSize];
    }
    return _secondWordL;
}
- (UILabel *)stateWordL
{
    if (_stateWordL == nil) {
        _stateWordL = [[UILabel alloc]init];
        _stateWordL.font = [UIFont boldSystemFontOfSize:textSize];
        _stateWordL.text = @"状态：";
    }
    return _stateWordL;
}
- (UILabel *)stateL
{
    if (_stateL == nil) {
        _stateL = [[UILabel alloc]init];
        _stateL.font = [UIFont boldSystemFontOfSize:textSize];
    }
    return _stateL;
}
- (UIButton *)detailBtn
{
    if (_detailBtn == nil) {
        _detailBtn = [[UIButton alloc]init];
        _detailBtn.titleLabel.font = [UIFont boldSystemFontOfSize:textSize];
        [_detailBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_detailBtn setTitle:@"查看详情" forState:UIControlStateNormal];
        [_detailBtn setBackgroundColor:myBlueColor];
        _detailBtn.layer.cornerRadius = 3.0;
    }
    return _detailBtn;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.dateL];
        [self addSubview:self.timeView];
        [self addSubview:self.stateL];
        [self addSubview:self.stateWordL];
        [self addSubview:self.detailBtn];
    }
    return self;
}

+ (instancetype)loadView
{
    StuProfileMyBBAllDates *view = [[StuProfileMyBBAllDates alloc]init];
    view.dateL.frame = CGRectMake(paddingX, paddingX, labelW, labelH);
    view.timeView.frame = CGRectMake(paddingX, CGRectGetMaxY(view.dateL.frame)+paddingX, labelW, labelH);
    view.stateWordL.frame = CGRectMake(paddingX, CGRectGetMaxY(view.timeView.frame)+paddingX, 43, labelH);
    view.stateL.frame = CGRectMake(CGRectGetMaxX(view.stateWordL.frame), CGRectGetMaxY(view.timeView.frame)+paddingX, labelW, labelH);
    view.detailBtn.frame = CGRectMake(30, CGRectGetMaxY(view.stateL.frame)+paddingX, screenFrame.size.width-60, 30);
    return view;
}

- (void)restAllFrames
{
    if ([self.stateL.text isEqualToString:@"成功"] || [self.stateL.text isEqualToString:@"失败"] || [self.stateL.text isEqualToString:@"完工"] || [self.stateL.text isEqualToString:@"已结算"]) {
        if (self.timeView.hidden == NO) {
            self.timeView.hidden = YES;
            self.stateWordL.frame = CGRectMake(paddingX, CGRectGetMaxY(self.dateL.frame)+paddingX, 43, labelH);
            self.stateL.frame = CGRectMake(CGRectGetMaxX(self.stateWordL.frame), CGRectGetMaxY(self.dateL.frame)+paddingX, labelW, labelH);
            self.detailBtn.frame = CGRectMake(30, CGRectGetMaxY(self.stateL.frame)+paddingX, screenFrame.size.width-60, 30);
        }
    }
}


@end
