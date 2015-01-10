//
//  ContentViewController.m
//  lev3-mobile
//
//  Created by Christof Luethi on 16.06.14.
//  Copyright (c) 2014 shaped.ch. All rights reserved.
//

#import "ContentViewController.h"
#import "resultItem.h"

@interface ContentViewController ()

@end

@implementation ContentViewController {
    ResultItem *resultItem;
    NSString *link;
    UIActivityIndicatorView *activity;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

   /* CGRect frame = CGRectMake (120.0, 185.0, 80, 80);
    activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [activity setFrame:frame];
    
    activity.hidesWhenStopped = YES;
    
    activity.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin |
    UIViewAutoresizingFlexibleHeight |
    UIViewAutoresizingFlexibleLeftMargin |
    UIViewAutoresizingFlexibleRightMargin |
    UIViewAutoresizingFlexibleTopMargin |
    UIViewAutoresizingFlexibleWidth;
    
    [self.view addSubview:activity];
    
    [activity startAnimating];*/
    _webView.delegate = self;
    DLog("Content URL: %@", _contentLink);
    // NSURL *url = [NSURL URLWithString:_contentLink];
    NSURL *url = [NSURL URLWithString:_contentLink];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:requestObj];
    
}

- (void)webViewDidFinishLoad:webView {
   /* [activity stopAnimating];*/
}
@end
