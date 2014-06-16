//
//  SettingsTableViewController.m
//  lev3-mobile
//
//  Created by Christof Luethi on 16.06.14.
//  Copyright (c) 2014 shaped.ch. All rights reserved.
//

#import "SettingsTableViewController.h"

@interface SettingsTableViewController ()

@end

@implementation SettingsTableViewController {
    NSUserDefaults* defaults;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    defaults = [NSUserDefaults standardUserDefaults];
    
    [_apiUrl addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingDidEnd];
    
    _apiUrl.delegate = self;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSString* currentUrl = [defaults stringForKey:kSettingsApi];
    if([currentUrl length] > 0) {
        _apiUrl.text = currentUrl;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)textFieldChanged:(id)sender
{
    if(sender == _apiUrl) {
        [[NSUserDefaults standardUserDefaults] setObject:_apiUrl.text forKey:kSettingsApi];
        DLog(@"URL: %@", [[NSUserDefaults standardUserDefaults] stringForKey:kSettingsApi]);
    }
}

/* activate textfield even if not clicked inside textfield but inside cell */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        [_apiUrl becomeFirstResponder];
    }
}


@end
