//
//  StuProfileAboutViewController.m
//  yz-student
//
//  Created by 仲光磊 on 15/9/26.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import "StuProfileAboutViewController.h"
#import "StuConfig.h"
#import "StuProfileAboutProtocolViewController.h"
#import "StuProfileAboutHelpViewController.h"
#import "StuProfileAboutOurViewController.h"

#define headImgH 50

@interface StuProfileAboutViewController ()<UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>
@property(nonatomic, strong)UIImageView *aboutImageView;

@property(nonatomic, strong)UITableView *aboutTableView;

@end

@implementation StuProfileAboutViewController

- (UIImageView *)aboutImageView
{
    if (_aboutImageView == nil) {
        _aboutImageView = [[UIImageView alloc]init];
    }
    return _aboutImageView;
}

- (UITableView *)aboutTableView
{
    if (_aboutTableView == nil) {
        _aboutTableView = [[UITableView alloc]init];
    }
    return _aboutTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.aboutImageView.image = [UIImage imageNamed:@"wx_me_toux"];
    self.aboutImageView.frame = CGRectMake(0, 64, headImgH, headImgH);
    self.aboutImageView.center = CGPointMake(screenFrame.size.width/2.0, 64+10+headImgH/2.0);
    [self.view addSubview:self.aboutImageView];
    
    self.aboutTableView.delegate = self;
    self.aboutTableView.dataSource = self;
    self.aboutTableView.frame = CGRectMake(0, CGRectGetMaxY(self.aboutImageView.frame), screenFrame.size.width, screenFrame.size.height-headImgH);
    [self.view addSubview:self.aboutTableView];
    
    UIView *view =[[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [self.aboutTableView setTableFooterView:view];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"StuAbout";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    if (indexPath.row == 0) {
        [cell.textLabel setText:@"用户协议"];
    }
    if (indexPath.row == 1) {
        [cell.textLabel setText:@"帮助手册"];
        
    }
    if (indexPath.row == 2) {
        [cell.textLabel setText:@"关于我们"];
    }
    if (indexPath.row == 3) {
        [cell.textLabel setText:@"检查新版本"];
    }
    
    [cell.textLabel setFont:[UIFont systemFontOfSize:14]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        StuProfileAboutProtocolViewController *vc = [[StuProfileAboutProtocolViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if(indexPath.row == 1)
    {
        StuProfileAboutHelpViewController *vc = [[StuProfileAboutHelpViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.row == 2)
    {
        StuProfileAboutOurViewController *vc = [[StuProfileAboutOurViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.row == 3)
    {
        [NSThread sleepForTimeInterval:0.5];
        UIAlertView *altView = [[UIAlertView alloc]initWithTitle:nil message:@"当前版本已经是最新版本" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [altView show];
    }
}

@end
