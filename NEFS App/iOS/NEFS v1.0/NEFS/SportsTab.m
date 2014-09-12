//
//  SportsTab.m
//  NEFS
//
//  Created by Stephen Sowole on 24/06/2014.
//  Copyright (c) 2014 Stephen Sowole. All rights reserved.
//

#import "SportsTab.h"

@implementation SportsTab {
    
    NSMutableArray *sportsArray;
    
    UITableView *tableView;
    BOOL dataRetrieved;
}

- (void) viewDidLoad {
    
    [super viewDidLoad];
    
    dataRetrieved = NO;
    
    [self removeBackButtonText];
    
    [self getSportsData];
    
    if (!dataRetrieved) {
        
        [self refreshTable];
    }
    
    [self createTableView];
}

- (void) getSportsData {
    
    [self retrieveFromURL];
}

- (void) createTableView {
    
    CGRect window = [[UIScreen mainScreen] bounds];
    
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, window.size.width, window.size.height) style:UITableViewStylePlain];
    
    tableView.rowHeight = SPORTS_CELL_HEIGHT;
    
    tableView.delegate = self;
    
    tableView.dataSource = self;
    
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self.view addSubview:tableView];
    
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    tableView.backgroundColor = [UIColor colorWithRed:220.0/250.0 green:220.0/250.0 blue:220.0/250.0 alpha:1.0];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return sportsArray.count;
}

- (void) tableView:(UITableView *)table didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SportsTeam *object = (SportsTeam*)[sportsArray objectAtIndex:indexPath.row];
    
    [self goToMainSite:object.sLink :object.sName];
    
    [table deselectRowAtIndexPath:indexPath animated:YES];
}

- (void) goToMainSite:(NSString*)link :(NSString*)title {
    
    CustomWebView *web = [[CustomWebView alloc] init];
    
    [self.navigationController pushViewController:web animated:YES];
    
    web.title = title;
    
    web.websiteLink = link;
    
    [web loadWebsite];
}

- (void) tableView:(UITableView *)table moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    
    [table deselectRowAtIndexPath:sourceIndexPath animated:YES];
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self loadDataIntoTable:indexPath];
}

- (UITableViewCell*) loadDataIntoTable:(NSIndexPath *)index {
    
    [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    SportsCustomTVCell *cell = [[SportsCustomTVCell alloc] initWithFrame:CGRectZero];
    
    SportsTeam *team = (SportsTeam*)[sportsArray objectAtIndex:index.row];
    
    cell.team = team;
    
    [cell createTextData];
    
    return cell;
}

- (void) viewWillAppear:(BOOL)animated {
    
    if (!dataRetrieved) {
        
        [self retrieveFromURL];
        
    }
    
    if (tableView) {
        
        [tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
    }
}

- (void) retrieveFromURL {
    
    if (!dataRetrieved) {
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
        
        NSURL *url = [[NSURL alloc] initWithString:SPORTS_URL];
        
        [NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:url] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
            
            if (!error) {
                
                NSArray *sportsData = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                sportsData = [sportsData valueForKey:SPORTS_API_HEADER];
                
                if (sportsData && !dataRetrieved) {
                    
                    dataRetrieved = YES;
                    
                    [[NSUserDefaults standardUserDefaults] setObject:sportsData forKey:SPORTS];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    
                    [self refreshTable];
                    
                    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                }
                
            } else {
                
                [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            }
        }];
    }
}

- (void) refreshTable {
    
    [self createSportsFromData];
    
    [tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
}

- (void) createSportsFromData {
    
    if (sportsArray.count > 0) {
        
        sportsArray = NULL;
    }
    
    sportsArray = [[NSMutableArray alloc] init];
    
    NSMutableArray *tempArray = (NSMutableArray *)[[NSUserDefaults standardUserDefaults] objectForKey:SPORTS];
    
    
    for (NSDictionary *sport in tempArray) {
        
        SportsTeam *addSport = [[SportsTeam alloc] init];
        
        for (NSString *header in sport) {
            
            if ([addSport respondsToSelector:NSSelectorFromString(header)]) {

                if ([header isEqualToString:@"sDraw"] && [[sport valueForKey:header] isEqualToString:@"on"]) {
                    
                    [addSport setValue:@"" forKey:header];
                    
                } else {
                    
                    [addSport setValue:[sport valueForKey:header] forKey:header];
                }
            }
        }
        
        [sportsArray addObject:addSport];
    }
}

- (void) removeBackButtonText {
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backButtonItem];
}

- (void) didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

@end
