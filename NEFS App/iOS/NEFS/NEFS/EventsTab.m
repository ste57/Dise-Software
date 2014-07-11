//
//  EventsTab.m
//  NEFS
//
//  Created by Stephen Sowole on 24/06/2014.
//  Copyright (c) 2014 Stephen Sowole. All rights reserved.
//

#import "EventsTab.h"
#import "Config.h"
#import "Event.h"
#import "EventsCustomTVCell.h"
#import "EventsDetailPage.h"

@implementation EventsTab {
    
    UITableView *tableView;
    
    NSMutableArray *eventsArray, *eventsAttending;
    
    BOOL dataRetrieved;
    UILabel *noEventsLabel;
}

- (void) viewDidLoad {
    
    [super viewDidLoad];
    
    dataRetrieved = NO;
    
    [self removeBackButtonText];
    
    [self getEventsData];
    
    [self createTableView];
}

- (void) removeBackButtonText {
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backButtonItem];
}

- (void) getEventsData {
    
    eventsArray = [[NSMutableArray alloc] init];
    eventsAttending = [[NSMutableArray alloc] init];
    
    [self retrieveAttendingEvents];
    
    [self retrieveFromURL];
    
    [self createEventsFromData];
    
    [self sortDataIntoSections];
}

- (void) retrieveAttendingEvents {
    
    NSMutableArray *tempArray = (NSMutableArray *)[[NSUserDefaults standardUserDefaults] objectForKey:ATTENDING_EVENTS];
    
    for (NSString *eId in tempArray) {
        
        [eventsAttending addObject:eId];
    }
}

- (void) retrieveFromURL {
    
    if (!dataRetrieved) {
        
        NSURL *url = [[NSURL alloc] initWithString:EVENTS_URL];
        
        [NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:url] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
            
            if (!error) {

                NSMutableArray *upcomingEvents = [[NSMutableArray alloc] init];
                NSArray *events = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                events = [events valueForKey:EVENTS_API_HEADER];
                
                // Remove events in the past
                
                for (NSObject *event in events) {
                    
                    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
                    [dateFormat setDateFormat:@"yyyy-MM-d"];
                    
                    NSDate *date = [dateFormat dateFromString:[event valueForKey:@"eDate"]];
                    
                    NSDate *today = [dateFormat dateFromString:[dateFormat stringFromDate:[NSDate date]]];
                    
                    if([date compare:today] != NSOrderedAscending) {
                        
                        [upcomingEvents addObject:event];
                    }
                }
                
                if (events && !dataRetrieved) {
                    
                    dataRetrieved = YES;
                    
                    //[[NSUserDefaults standardUserDefaults] setObject:events forKey:EVENTS];
                    [[NSUserDefaults standardUserDefaults] setObject:upcomingEvents forKey:EVENTS];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    
                    [self refreshTable];
                }
            }
        }];
    }
}

- (void) viewWillAppear:(BOOL)animated {
    
    if (!dataRetrieved) {
    
        [self retrieveFromURL];
        
    }
    
    if (tableView) {

        [tableView reloadData];
    }
}

- (void) refreshTable {
    
    [self retrieveAttendingEvents];

    [self createEventsFromData];
    
    [self sortDataIntoSections];

    [noEventsLabel performSelectorOnMainThread:@selector(removeFromSuperview) withObject:nil waitUntilDone:NO];
    [tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
}

- (void) createNoEventsLabel {
    
    noEventsLabel = [[UILabel alloc] initWithFrame:CGRectMake(85.0, NO_ACCESS_LABEL_HEIGHT, 200.0, 45.0)];
    noEventsLabel.textAlignment = NSTextAlignmentLeft;
    noEventsLabel.textColor = [UIColor darkGrayColor];
    noEventsLabel.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:16];
    noEventsLabel.text = NO_EVENTS_TEXT;
    
    [self.view addSubview:noEventsLabel];
}

- (void) createEventsFromData {
    
    if (eventsArray.count > 0) {
        
        eventsArray = NULL;
    }
    
    eventsArray = [[NSMutableArray alloc] init];
    
    NSMutableArray *tempArray = (NSMutableArray *)[[NSUserDefaults standardUserDefaults] objectForKey:EVENTS];
    
    for (NSDictionary *event in tempArray) {
        
        Event *addEvent = [[Event alloc] init];
        
        for (NSString *header in event) {
            
            if ([addEvent respondsToSelector:NSSelectorFromString(header)]) {
                
                [addEvent setValue:[event valueForKey:header] forKey:header];
            }
        }
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"HH:mm";
        
        NSDate *eStart = [dateFormatter dateFromString:addEvent.eStart];
        NSDate *eEnd = [dateFormatter dateFromString:addEvent.eEnd];
        
        dateFormatter.dateFormat = @"hh:mm a";
        
        addEvent.eStart = [dateFormatter stringFromDate:eStart];
        addEvent.eEnd = [dateFormatter stringFromDate:eEnd];
        
        [eventsArray addObject:addEvent];
    }
    
    [self removeOldAttendingDates];
}

- (void) removeOldAttendingDates {
    
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    
    for (NSString *eId in eventsAttending) {
        
        for (Event *event in eventsArray) {
            
            if ([eId isEqualToString:event._id]) {
                
                [tempArray addObject:eId];
            }
        }
    }
    
    eventsAttending = tempArray;
    
    [[NSUserDefaults standardUserDefaults] setObject:eventsAttending forKey:ATTENDING_EVENTS];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void) sortDataIntoSections {
    
    NSSortDescriptor *sortDescriptor;
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"eDate"
                                                 ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    eventsArray = (NSMutableArray*)[eventsArray sortedArrayUsingDescriptors:sortDescriptors];
}

- (void) createTableView {
    
    CGRect window = [[UIScreen mainScreen] bounds];
    
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, window.size.width, window.size.height) style:UITableViewStylePlain];
    
    tableView.rowHeight = CELL_HEIGHT;
    
    tableView.delegate = self;
    
    tableView.dataSource = self;
    
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self.view addSubview:tableView];
    
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = [UIColor colorWithRed:220.0/250.0 green:220.0/250.0 blue:220.0/250.0 alpha:1.0];
    
    if (!eventsArray.count) {
        
        [self createNoEventsLabel];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return eventsArray.count;
}

- (void) tableView:(UITableView *)table didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [table deselectRowAtIndexPath:indexPath animated:YES];
    
    EventsDetailPage *detailPage = [[EventsDetailPage alloc] init];
    
    EventsCustomTVCell *cell = (EventsCustomTVCell*)[table cellForRowAtIndexPath:indexPath];
    
    Event *event = cell.event;
    
    detailPage.view.backgroundColor = [UIColor whiteColor];
    
    detailPage.title = event.eTitle;
    detailPage.event = event;
    
    [detailPage createTextData];
    
    [self.navigationController pushViewController:detailPage animated:YES];
}

- (void) tableView:(UITableView *)table moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    
    [table deselectRowAtIndexPath:sourceIndexPath animated:YES];
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self loadDataIntoTable:indexPath];
}

- (UITableViewCell*) loadDataIntoTable:(NSIndexPath *)index {
    
    [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    NSMutableArray* events = eventsArray;
    
    EventsCustomTVCell *cell = [[EventsCustomTVCell alloc] initWithFrame:CGRectZero];
    
    Event *event = (Event*)[events objectAtIndex:index.row];
    
    cell.event = event;
    
    [cell createTextData];
    
    return cell;
}

- (void) didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

@end
