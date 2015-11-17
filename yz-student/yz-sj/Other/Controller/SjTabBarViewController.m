//
//  SjTabBarViewController.m
//  yz-student
//
//  Created by 仲光磊 on 15/10/22.
//  Copyright © 2015年 cdq. All rights reserved.
//

#import "SjTabBarViewController.h"
#import "SjHomeViewController.h"
#import "SjInfoViewController.h"
#import "SjComposeJobViewController.h"
#import "SjProfileViewController.h"
#import "SjNavigationViewController.h"
#import "SjLoginViewController.h"

extern NSString *sjGlobalSessionId;

@interface SjTabBarViewController ()

@end

@implementation SjTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SjHomeViewController *homeVc = [[SjHomeViewController alloc]init];
    //SjComposeJobViewController *composeJobVc = [[SjComposeJobViewController alloc]init];
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"SjComposeJob" bundle:[NSBundle mainBundle]];
    SjComposeJobViewController *composeJobVc = [sb instantiateViewControllerWithIdentifier:@"SjComposeJob"];
    
    SjInfoViewController *infoVc = [[SjInfoViewController alloc]init];
    SjProfileViewController *profileVc = [[SjProfileViewController alloc]init];
    
    [self addChildVc:homeVc title:@"兼职管理" image:@"home_hover_nomal" selectedImage:@"home_hover"];
    [self addChildVc:composeJobVc title:@"发布兼职" image:@"parttime_hover_nomal" selectedImage:@"parttime_hover"];
    [self addChildVc:infoVc title:@"消息" image:@"fond_hover_nomal" selectedImage:@"fond_hover"];
    [self addChildVc:profileVc title:@"商家中心" image:@"user_hover_nomal" selectedImage:@"user_hover"];
    
//    if (sjGlobalSessionId == nil || sjGlobalSessionId.length == 0) {
//        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"SjLogin" bundle:[NSBundle mainBundle]];
//        SjLoginViewController *vc = [sb instantiateViewControllerWithIdentifier:@"SjLogin"];
//        
//        [self.navigationController pushViewController:vc animated:YES];
//    }
}

- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    childVc.title = title;
    childVc.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIImage *homeSelectedImage = [[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVc.tabBarItem.selectedImage = homeSelectedImage;
    
    
    SjNavigationViewController *nvc = [[SjNavigationViewController alloc]initWithRootViewController:childVc];
    
    [self addChildViewController:nvc];
}

@end
