
#import "StuNavigationViewController.h"
#import "UIBarButtonItem+Extension.h"

@interface NavigationViewController ()

@end

@implementation NavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    if (self.viewControllers.count > 0) {
        
        viewController.hidesBottomBarWhenPushed = YES;
        //left
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(leftBack) image:@"dianpu_01" highlightImage:@"dianpu_01"];
        
        //right
        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(rightHome) image:@"navigationbar_more" highlightImage:@"navigationbar_more"];
    }
    [super pushViewController:viewController animated:animated];
}

- (void) leftBack
{
    [self popViewControllerAnimated:YES];
}
- (void) rightHome
{
    [self popToRootViewControllerAnimated:YES];
}

@end
