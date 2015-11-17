//
//  StuProfileAboutOurViewController.m
//  yz-student
//
//  Created by 仲光磊 on 15/9/26.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import "StuProfileAboutOurViewController.h"
#import "StuConfig.h"

@interface StuProfileAboutOurViewController ()
@property(nonatomic, strong)UIWebView *webView;
@end

@implementation StuProfileAboutOurViewController

- (UIWebView *)webView
{
    if (_webView == nil) {
        _webView = [[UIWebView alloc]init];
    }
    return _webView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"关于我们";
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, -57, screenFrame.size.width, screenFrame.size.height+57)];
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/wx-guanyuwomen.html", serverIp]]];
    [self.view addSubview: self.webView];
    [self.webView loadRequest:request];
}

@end
