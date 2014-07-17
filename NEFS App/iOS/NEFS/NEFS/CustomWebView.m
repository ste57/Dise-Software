//
//  CustomWebView.m
//  NEFS
//
//  Created by Stephen Sowole on 10/07/2014.
//  Copyright (c) 2014 Stephen Sowole. All rights reserved.
//

#import "CustomWebView.h"

@implementation CustomWebView {
    
    UIActivityIndicatorView *loadIndicator;
}

@synthesize websiteLink;

- (void) viewDidLoad {
    
    [super viewDidLoad];
    
    [self removeBackButtonText];
}

- (void) removeBackButtonText {
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backButtonItem];
}

- (void) loadWebsite {
    
    NSURL *url = [NSURL URLWithString:websiteLink];
    
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:30];
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0,0,self.view.bounds.size.width,self.view.bounds.size.height)];
    
    [self.view addSubview:webView];
    
    webView.delegate = self;
    
    webView.scalesPageToFit = YES;
    
    [webView loadRequest:requestObj];
    
    [self setActivityIndicator];
    
    [self createNavigationBarTitle];
}

- (void) createNavigationBarTitle {
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 40)];
    label.text = self.navigationItem.title;
    
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont boldSystemFontOfSize:16];
    label.backgroundColor = [UIColor clearColor];
    
    label.adjustsFontSizeToFitWidth = YES;
    label.minimumScaleFactor = 0.7;
    
    label.textAlignment = NSTextAlignmentCenter;
    
    self.navigationItem.titleView = label;
}

- (void) setActivityIndicator {
    
    loadIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    loadIndicator.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2);
    
    [loadIndicator startAnimating];
    
    [self.view addSubview:loadIndicator];
}

- (void) webViewDidFinishLoad:(UIWebView *)webView {
    
    [loadIndicator removeFromSuperview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
