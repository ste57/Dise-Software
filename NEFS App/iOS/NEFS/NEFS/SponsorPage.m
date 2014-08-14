//
//  SponsorPage.m
//  NEFS
//
//  Created by Stephen Sowole on 14/08/2014.
//  Copyright (c) 2014 Stephen Sowole. All rights reserved.
//

#import "SponsorPage.h"

@implementation SponsorPage {
    
    UITableView *tableView;
    
    NSMutableArray *sponsorArray;
    NSMutableDictionary *sections;
    
    BOOL dataRetrieved;
}

- (void) viewDidLoad {
    
    [super viewDidLoad];
    
    dataRetrieved = NO;
    
    [self removeBackButtonText];
    
    [self getSponsorData];
    
    if (!dataRetrieved) {
        
        [self refreshTable];
    }
    
    [self createTableView];
}

- (void) getSponsorData {
    
    [self retrieveFromURL];
}

- (void) retrieveFromURL {
    
    if (!dataRetrieved) {
        
        NSURL *url = [[NSURL alloc] initWithString:INFO_URL];
        
        [NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:url] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
            
            if (!error) {
                
                NSArray *sponsorData = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                sponsorData = [sponsorData valueForKey:INFO_API_HEADER];
                
                if (sponsorData && !dataRetrieved) {
                    
                    dataRetrieved = YES;
                    
                    [[NSUserDefaults standardUserDefaults] setObject:sponsorData forKey:INFO];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    
                    [self refreshTable];
                }
            }
        }];
    }
}

- (void) refreshTable {
    
    [self createSponsorsFromData];
    
    [tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
}

- (void) viewWillAppear:(BOOL)animated {
    
    if (!dataRetrieved) {
        
        [self retrieveFromURL];
    }
}

- (void) createSponsorsFromData {
    
    if (sponsorArray.count > 0) {
        
        sponsorArray = NULL;
    }
    
    sponsorArray = [[NSMutableArray alloc] init];
    
    NSMutableArray *tempArray = (NSMutableArray *)[[NSUserDefaults standardUserDefaults] objectForKey:INFO];
    
    for (NSDictionary *sponsor in tempArray) {
        
        Sponsor *addSponsor = [[Sponsor alloc] init];
        
        for (NSString *header in sponsor) {
            
            if ([addSponsor respondsToSelector:NSSelectorFromString(header)]) {
                
                [addSponsor setValue:[sponsor valueForKey:header] forKey:header];
            }
        }
        
        [sponsorArray addObject:addSponsor];
    }
    
    [self sortSponsorsIntoSections];
}

- (void) sortSponsorsIntoSections {
    
    sections = [NSMutableDictionary dictionary];
    
    for (Sponsor *sponsor in sponsorArray) {
        
        NSMutableArray *array = [sections objectForKey:sponsor.iType];
        
        if (array == nil) {
            
            array = [NSMutableArray array];
            
            [sections setObject:array forKey:sponsor.iType];
        }
        
        [array addObject:sponsor];
    }
}

- (void) removeBackButtonText {
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backButtonItem];
}

- (void) createTableView {
    
    CGRect window = [[UIScreen mainScreen] bounds];
    
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, window.size.width, window.size.height) style:UITableViewStylePlain];
    
    tableView.delegate = self;
    
    tableView.dataSource = self;
    
    tableView.rowHeight = INFO_ROW_HEIGHT;
    
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self.view addSubview:tableView];
    
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [tableView setSeparatorInset:UIEdgeInsetsZero];
    
    tableView.backgroundColor = [UIColor colorWithRed:220.0/250.0 green:220.0/250.0 blue:220.0/250.0 alpha:1.0];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSArray *sponsors = [sections objectForKey:[SPONSOR_TYPES objectAtIndex:section]];
    
    return [sponsors count];
}

- (void) tableView:(UITableView *)table didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [table deselectRowAtIndexPath:indexPath animated:YES];
    
    PlainDescriptionView *descView = [[PlainDescriptionView alloc] init];

    NSArray *sponsors = [sections objectForKey:[SPONSOR_TYPES objectAtIndex:indexPath.section]];
    Sponsor *sponsor = [sponsors objectAtIndex:indexPath.row];;
    
    descView.title = sponsor.iSponsor;
    [descView setText:sponsor.iDesc];
    
    [self.navigationController pushViewController:descView animated:YES];
}

- (void) tableView:(UITableView *)table moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    
    [table deselectRowAtIndexPath:sourceIndexPath animated:YES];
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self loadDataIntoTable:indexPath];
}

- (UITableViewCell*) loadDataIntoTable:(NSIndexPath *)index {
    
    [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    InfoCell *cell = [[InfoCell alloc] initWithFrame:CGRectZero];
    
    NSArray *sponsors = [sections objectForKey:[SPONSOR_TYPES objectAtIndex:index.section]];
    
    Sponsor *sponsor = [sponsors objectAtIndex:index.row];
    
    [cell setTitle:sponsor.iSponsor];
    
    [cell addArrow];
    
    return cell;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    
    return SPONSOR_TYPES.count;
}

- (UIView *) tableView:(UITableView *)table viewForHeaderInSection:(NSInteger)section {
    
    NSArray *sponsors = [sections objectForKey:[SPONSOR_TYPES objectAtIndex:section]];
    
    tableView.sectionHeaderHeight = 30;
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, table.bounds.size.width, 0)];
    
    if (sponsors.count) {
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 8, table.bounds.size.width, 24)];
        
        switch (section) {
                
            case 0:
                [view setBackgroundColor:[UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1.0]];
                break;
                
            case 1:
                [view setBackgroundColor:[UIColor colorWithRed:0.94 green:0.88 blue:0.74 alpha:1.0]];
                break;
                
            case 2:
                [view setBackgroundColor:[UIColor colorWithRed:0.83 green:0.83 blue:0.83 alpha:1.0]];
                break;
                
            case 3:
                [view setBackgroundColor:[UIColor colorWithRed:0.79 green:0.72 blue:0.61 alpha:1.0]];
                break;
                
            default:
                break;
        }
        
        [headerView addSubview:view];
        
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 8, tableView.bounds.size.width, 24)];
        
        label.text = [SPONSOR_TYPES objectAtIndex:section];
        
        label.textAlignment = NSTextAlignmentCenter;
        
        label.font = [UIFont fontWithName:@"AppleSDGothicNeo-Medium" size:DESCRIPTION_FONT_SIZE];
        
        label.textColor = [UIColor darkGrayColor];
        
        label.backgroundColor = [UIColor clearColor];
        
        [headerView addSubview:label];
        
    }
    
    return headerView;
}

@end
