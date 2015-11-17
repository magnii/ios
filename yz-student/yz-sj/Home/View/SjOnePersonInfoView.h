//
//  SjOnePersonInfoView.h
//  yz-student
//
//  Created by 仲光磊 on 15/11/5.
//  Copyright © 2015年 cdq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SjOnePersonInfoView : UIView
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *phoneL;
@property (weak, nonatomic) IBOutlet UIButton *hiredBtn;
@property (weak, nonatomic) IBOutlet UIButton *checkSignBtn;

+(instancetype)onePersonFromNib;

@end
