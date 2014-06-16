//
//  SearchViewController.m
//  lev3-mobile
//
//  Created by Christof Luethi on 27.05.14.
//  Copyright (c) 2014 shaped.ch. All rights reserved.
//

#import "SearchViewController.h"
#import "ResultTableViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ResultView"]) {
        ResultTableViewController *resultView = segue.destinationViewController;
        resultView.query = _searchField.text;
    }
}

- (IBAction)runSearch:(id)sender {
}

@end
