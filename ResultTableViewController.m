//
//  ResultTableViewController.m
//  lev3-mobile
//
//  Created by Christof Luethi on 16.06.14.
//  Copyright (c) 2014 shaped.ch. All rights reserved.
//

// http://apps.vs.ch/le-api/v1/mandates/vs.mnd/documents?limit=10&fields=dossid,leid

#import "ResultTableViewController.h"
#import "ResultItem.h"
#import "ContentViewController.h"

NSString* const RESULT_API_CALL = @"/v1/mandates/vs.mnd/documents?limit=10&fields=dossid,dossnr,leid";

@interface ResultTableViewController ()

@end

@implementation ResultTableViewController {
    NSMutableArray* _resultList;
    NSUInteger _selectedIndex;
    UIActivityIndicatorView *activity;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGRect frame = CGRectMake (120.0, 185.0, 80, 80);
    
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
    
    NSString* baseUrl = [[NSUserDefaults standardUserDefaults] stringForKey:kSettingsApi];
    if(baseUrl == nil || [baseUrl length] == 0) {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Server not found"
                                                        message:@"No LEv3 Server found. Please configure a valid LEv3 search instance."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        
        [alert show];
    } else {
        [self runSearch];
    }

  
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _resultList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ResultCell"];
    
    ResultItem *result = [_resultList objectAtIndex:indexPath.row];
    cell.textLabel.text = result.dossNr;
    cell.detailTextLabel.text = result.leid;
    
    return cell;
}

-(void)runSearch {
    _resultList = [[NSMutableArray alloc] init];
    
    NSString* apiUrl = [[NSUserDefaults standardUserDefaults] stringForKey:kSettingsApi];
    NSString* searchCall = [NSString stringWithFormat:@"%@%@", apiUrl, RESULT_API_CALL];
    
    DLog(@"NetworkCall: %@", searchCall);
    [activity startAnimating];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:searchCall] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSError *jsonError = nil;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        DLog(@"%@", json);
        
        if (jsonError) {
            NSString* msg = [NSString stringWithFormat:@"Configured Server '%@' is no LEv3 instance or the server is currently not avaliable. Please try again later.", apiUrl];
            DLog(@"Error fetching JSON: %@", [jsonError localizedDescription]);
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Server error"
                                                            message:msg
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            
            [alert show];
            return;
        }
        
        // fill up new site
            NSMutableArray *rList = [json objectForKey:@"doclist"];
            for (NSDictionary *resultDict in rList) {
                NSString *dossnr = [resultDict objectForKey:@"dossnr"];
                NSString *dossid = [resultDict objectForKey:@"dossid"];
                NSString *leid = [resultDict objectForKey:@"leid"];
                ResultItem *ri = [[ResultItem alloc] initWithName:dossnr dossid:dossid dossnr:dossnr leid:leid];
                [_resultList addObject:ri];
            }
        
        /* dispatch async needed for displaying cells correctly - if not applied the cells are only refreshed if you scroll */
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            [activity stopAnimating];
        });
    }];
    
    [dataTask resume];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ShowContent"]) {
        ContentViewController *contentViewController = segue.destinationViewController;
        ResultItem *ri = [_resultList objectAtIndex:_selectedIndex];
        contentViewController.contentLink = [NSString stringWithFormat:@"https://apps.vs.ch/le/cache827/?dossid=%@#lehit", ri.dossId];
    }
}

@end
