
#import "StuTabBarViewController.h"
#import "StuNavigationViewController.h"
#import "StuJobTableViewController.h"
#import "StuDiscoveryTableViewController.h"
#import "StuProfileViewController.h"
#import "StuHomeTableViewController.h"

@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    StuHomeTableViewController *homeVc = [[StuHomeTableViewController alloc]init];
    DiscoveryTableViewController *discoverVc = [[DiscoveryTableViewController alloc]init];
    JobTableViewController *jobVc = [[JobTableViewController alloc]init];
    StuProfileViewController *profileVc = [[StuProfileViewController alloc]init];
    
    [self addChildVc:homeVc title:@"首页" image:@"home_hover_nomal" selectedImage:@"home_hover"];
    [self addChildVc:jobVc title:@"兼职" image:@"parttime_hover_nomal" selectedImage:@"parttime_hover"];
    [self addChildVc:discoverVc title:@"发现" image:@"fond_hover_nomal" selectedImage:@"fond_hover"];
    [self addChildVc:profileVc title:@"我" image:@"user_hover_nomal" selectedImage:@"user_hover"];
}

- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
//    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//    dict[NSForegroundColorAttributeName] = [UIColor colorWithRed:123/255.0 green:123/255.0 blue:123/255.0 alpha:123/255.0];
    
//    NSMutableDictionary *dictSelected = [NSMutableDictionary dictionary];
//    dictSelected[NSForegroundColorAttributeName] = [UIColor orangeColor];
    
    //childVc.view.backgroundColor = MYrandColor;
    //    childVc.tabBarItem.title = title;
    childVc.title = title;
    //childVc.tabBarItem.image = [UIImage imageNamed:image];
    childVc.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //[childVc.tabBarItem setTitleTextAttributes:dict forState:UIControlStateNormal];
    //[childVc.tabBarItem setTitleTextAttributes:dictSelected forState:UIControlStateSelected];
    
    UIImage *homeSelectedImage = [[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVc.tabBarItem.selectedImage = homeSelectedImage;
    
    
    NavigationViewController *nvc = [[NavigationViewController alloc]initWithRootViewController:childVc];
    
    [self addChildViewController:nvc];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
