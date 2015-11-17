//
//  StuProfileAboutHelpViewController.m
//  yz-student
//
//  Created by 仲光磊 on 15/9/26.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import "StuProfileAboutHelpViewController.h"
#import "StuConfig.h"

@interface StuProfileAboutHelpViewController ()

@property(nonatomic, strong)UIWebView *webView;

@end

@implementation StuProfileAboutHelpViewController

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
    self.title = @"帮助手册";
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, -57, screenFrame.size.width, screenFrame.size.height+57)];
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/wx-bangzhushouce.html", serverIp]]];
    [self.view addSubview: self.webView];
    [self.webView loadRequest:request];
}

@end
