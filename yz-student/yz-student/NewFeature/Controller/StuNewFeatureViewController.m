//
//  NewFeatureViewController.m
//  yz
//
//  Created by 仲光磊 on 15/8/26.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import "StuNewFeatureViewController.h"
#import "StuStartPageViewController.h"
#import "StuTabBarViewController.h"

#define NewFeatureCount 4

@interface NewFeatureViewController ()<UIScrollViewDelegate>

@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) UIPageControl *pageControl;

@end

@implementation NewFeatureViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    CGRect scrollViewFrame = self.view.bounds;
    scrollView.frame = scrollViewFrame;
    [self.view addSubview:scrollView];
    _scrollView = scrollView;
    
    CGFloat scrollWidth = self.scrollView.frame.size.width;
    CGFloat scrollHeight = self.scrollView.frame.size.height;
    
    for (int i=0; i<NewFeatureCount; i++) {
        UIImageView *imgView = [[UIImageView alloc]init];
        imgView.frame = CGRectMake(i*scrollWidth, 0, scrollWidth, scrollHeight);
        NSString *imgName = [NSString stringWithFormat:@"banner_%d", i+1];
        imgView.image = [UIImage imageNamed:imgName];
        [self.scrollView addSubview:imgView];
        
        if (i == NewFeatureCount - 1) {
            [self setupLastImageView:imgView];
        }
    }
    
    self.scrollView.contentSize = CGSizeMake(NewFeatureCount*self.view.bounds.size.width, self.view.bounds.size.height);
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.bounces = NO;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    
    UIPageControl *pageControl = [[UIPageControl alloc]init];
    pageControl.numberOfPages = NewFeatureCount;
    pageControl.backgroundColor = [UIColor redColor];
    pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:253/255.0 green:98/255.0 blue:42/255.0 alpha:1.0f];
    pageControl.pageIndicatorTintColor = [UIColor colorWithRed:198/255.0 green:198/255.0 blue:198/255.0 alpha:1.0f];
    
    CGPoint pageControlCenter = CGPointMake(self.view.bounds.size.width*0.5, self.view.bounds.size.height*0.9);
    pageControl.center = pageControlCenter;
    _pageControl = pageControl;
    
    [self.view addSubview:pageControl];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    float page = scrollView.contentOffset.x/scrollView.bounds.size.width;
    self.pageControl.currentPage = (int)(page+0.5);
}

- (void)setupLastImageView:(UIImageView*)imgView
{
    imgView.userInteractionEnabled = YES;
    
    CGRect screenRect = [UIScreen mainScreen].bounds;
    
    UIButton *startBtn = [[UIButton alloc]init];
    [startBtn setBackgroundImage:[UIImage imageNamed:@"tuoyuan_1"] forState:UIControlStateNormal];
    [startBtn setTitle:@"立即体验" forState:UIControlStateNormal];
    [startBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    startBtn.titleLabel.font = [UIFont systemFontOfSize:17.0f];
    //startBtn.titleLabel.font = [UIFont fontWithName:@"Zapfino" size:17.0f];
    startBtn.frame = CGRectMake(0, 0, 100, 30);
    //startBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    
    CGPoint center = CGPointMake(screenRect.size.width*0.5, screenRect.size.height*0.8);
    [startBtn setCenter:center];
    [imgView addSubview:startBtn];
    
    [startBtn addTarget:self action:@selector(startClick) forControlEvents:UIControlEventTouchDown];

}

- (void) startClick
{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    StartPageViewController *startPageVc = [[StartPageViewController alloc]init];
    window.rootViewController = startPageVc;
//    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
//    TabBarViewController *tabVc = [[TabBarViewController alloc]init];
//    window.rootViewController = tabVc;
}

@end
