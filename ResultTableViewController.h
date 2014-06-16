//
//  ResultTableViewController.h
//  lev3-mobile
//
//  Created by Christof Luethi on 16.06.14.
//  Copyright (c) 2014 shaped.ch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultTableViewController : UITableViewController
@property (nonatomic,weak) NSString *query;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;
@end
