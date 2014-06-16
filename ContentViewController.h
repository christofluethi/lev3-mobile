//
//  ContentViewController.h
//  lev3-mobile
//
//  Created by Christof Luethi on 16.06.14.
//  Copyright (c) 2014 shaped.ch. All rights reserved.
//

#import "ViewController.h"

@interface ContentViewController : UIViewController<UIWebViewDelegate>
@property (nonatomic, strong) NSString *contentLink;
@property (strong, nonatomic) IBOutlet UIWebView *webView;

@end
