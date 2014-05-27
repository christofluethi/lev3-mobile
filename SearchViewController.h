//
//  SearchViewController.h
//  lev3-mobile
//
//  Created by Christof Luethi on 27.05.14.
//  Copyright (c) 2014 shaped.ch. All rights reserved.
//

#import "ViewController.h"

@interface SearchViewController : ViewController
@property (weak, nonatomic) IBOutlet UITextField *searchField;

- (IBAction)runSearch:(id)sender;

@end
