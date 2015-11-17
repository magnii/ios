//
//  StuProfileMyBBSignUpsViewController.m
//  yz-student
//
//  Created by 仲光磊 on 15/10/2.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import "StuProfileMyBBSignUpsViewController.h"
#import "StuProfileMySignCell.h"
#import "StuProfileAllMySignInfo.h"
#import "StuConfig.h"

@interface StuProfileMyBBSignUpsViewController ()

@end

@implementation StuProfileMyBBSignUpsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    StuProfileMySignCell *signCell = [StuProfileMySignCell cellFromNib];
    signCell.nowL.textAlignment = NSTextAlignmentCenter;
    signCell.nowL.text = self.signInfo.date;
    signCell.signInDateL.text = self.signInfo.signInTime;
    signCell.signInAddr.text = self.signInfo.signInAddress;
    signCell.signOutDateL.text = self.signInfo.signOutTime;
    signCell.sinOutAddrL.text = self.signInfo.signOutAddress;
    
    signCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    signCell.frame = CGRectMake(0, 64, screenFrame.size.width, 500);
    [self.view addSubview:signCell];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
