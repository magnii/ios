//
//  SjCheckSignViewController.m
//  yz-student
//
//  Created by 仲光磊 on 15/11/6.
//  Copyright © 2015年 cdq. All rights reserved.
//

#import "SjCheckSignViewController.h"
#import "SjOneSignView.h"
#import "StuConfig.h"
#import "SjSignInfo.h"

@interface SjCheckSignViewController ()

@property(nonatomic, strong)SjOneSignView *oneSignView;

@end

@implementation SjCheckSignViewController

- (SjOneSignView *)oneSignView
{
    if (_oneSignView == nil) {
        _oneSignView = [SjOneSignView viewFromNib];
    }
    return _oneSignView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"查看签到";
    
    self.oneSignView.frame = CGRectMake(0, 64, screenFrame.size.width, 200);
    [self.view addSubview:self.oneSignView];
    
    self.oneSignView.dateL.text = [NSString stringWithFormat:@"    %@", self.signInfo.dateNow];
    self.oneSignView.signInDateL.text = self.signInfo.signInDate;
    self.oneSignView.signInAddrL.text = self.signInfo.signInAddr;
    self.oneSignView.signOutDateL.text = self.signInfo.signOutDate;
    self.oneSignView.signOutAddrL.text = self.signInfo.signOutAddr;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
