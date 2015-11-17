//
//  StartPageViewController.m
//  yz
//
//  Created by 仲光磊 on 15/8/26.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import "StuStartPageViewController.h"
#import "StuTabBarViewController.h"
#import "StuConfig.h"
#import "SjTabBarViewController.h"
#import "SjNavigationViewController.h"
#import "SjLoginViewController.h"

extern NSString *sjGlobalSessionId;

@interface StartPageViewController ()

@property(nonatomic, strong) UIImageView *startImgView;

@end

@implementation StartPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadStartPage];
}

- (UIImageView *)startImgView
{
    if (_startImgView == nil) {
        _startImgView = [[UIImageView alloc]init];
    }
    return _startImgView;
}

- (void)loadStartPage
{
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:screenFrame];
    imgView.image = [UIImage imageNamed:@"hy"];
    imgView.userInteractionEnabled = YES;
    self.startImgView = imgView;
    
    [self addStuBtn];
    [self addSjBtn];

    [self.view addSubview:self.startImgView];
}

- (void)addStuBtn
{
    UIButton *btn = [[UIButton alloc]init];
    [btn setBackgroundImage: [UIImage imageNamed:@"tuoyuan_1"] forState:UIControlStateNormal];
    [btn setTitle:@"我是学生" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:17.0f];
    
    CGFloat stuBtnX = 20;
    CGFloat stuBtnY = screenFrame.size.height*0.75;
    CGFloat stuBtnW = (screenFrame.size.width - stuBtnX*2 -10)*0.5;
    CGFloat stuBtnH = 40;
    btn.frame = CGRectMake(stuBtnX, stuBtnY, stuBtnW, stuBtnH);
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [btn addTarget:self action:@selector(stuBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.startImgView addSubview:btn];
}

- (void)addSjBtn
{
    UIButton *btn = [[UIButton alloc]init];
    [btn setBackgroundImage: [UIImage imageNamed:@"tuoyuan_1"] forState:UIControlStateNormal];
    [btn setTitle:@"我是商家" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:17.0f];
    
    CGFloat sjBtnY = screenFrame.size.height*0.75;
    CGFloat sjBtnW = (screenFrame.size.width - 20*2 -10)*0.5;
    CGFloat sjBtnH = 40;
    CGFloat sjBtnX = 20+sjBtnW+10;
    btn.frame = CGRectMake(sjBtnX, sjBtnY, sjBtnW, sjBtnH);
    [btn.titleLabel setTextAlignment:NSTextAlignmentCenter];
    
    [btn addTarget:self action:@selector(sjBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.startImgView addSubview:btn];
}

- (void)stuBtnClick
{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    TabBarViewController *tabVc = [[TabBarViewController alloc]init];
    window.rootViewController = tabVc;
}

- (void)sjBtnClick
{
//    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
//    SjTabBarViewController *tabVc = [[SjTabBarViewController alloc]init];
//    window.rootViewController = tabVc;
    
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"SjLogin" bundle:[NSBundle mainBundle]];
    SjLoginViewController *vc = [sb instantiateViewControllerWithIdentifier:@"SjLogin"];
    window.rootViewController = vc;
}



@end
