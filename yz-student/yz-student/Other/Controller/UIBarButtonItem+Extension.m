
#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)

+ itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highlightImage:(NSString*)highImg
{
    UIButton *btn = [[UIButton alloc] init];
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:highImg] forState:UIControlStateHighlighted];
    CGSize btnSize = btn.currentBackgroundImage.size;
    btn.frame = CGRectMake(btn.frame.origin.x, btn.frame.origin.y, btnSize.width, btnSize.height);
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    
    return barButtonItem;
}

@end
