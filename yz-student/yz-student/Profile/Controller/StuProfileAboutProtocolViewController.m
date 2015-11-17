//
//  StuProfileAboutProtocolViewController.m
//  yz-student
//
//  Created by 仲光磊 on 15/9/26.
//  Copyright (c) 2015年 cdq. All rights reserved.
//

#import "StuProfileAboutProtocolViewController.h"
#import "StuConfig.h"

@interface StuProfileAboutProtocolViewController ()

@property(nonatomic, strong)UIWebView *webView;

@end

@implementation StuProfileAboutProtocolViewController

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
    self.title = @"用户协议";
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, -50, screenFrame.size.width, screenFrame.size.height+50)];
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/wx-xieyi.html", serverIp]]];
    [self.view addSubview: self.webView];
    [self.webView loadRequest:request];
}

@end
