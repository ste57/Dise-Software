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
#import "CustomTableViewCell.h"
#import "EventsDetailPage.h"

@implementation EventsTab {
    
    UITableView *tableView;
    
    NSMutableArray *eventsArray, *days, *eventsAttending;
    NSDictionary *groupedEvents;
}

- (void) viewDidLoad {
    
    [super viewDidLoad];
    
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
    days = [[NSMutableArray alloc] init];
    groupedEvents = [NSMutableDictionary dictionary];
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

- (void) viewDidAppear:(BOOL)animated {
    
    [self retrieveAttendingEvents];
}

- (void) retrieveFromURL {
    
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
            
            if (events) {
                
                [[NSUserDefaults standardUserDefaults] setObject:events forKey:EVENTS];
                //[[NSUserDefaults standardUserDefaults] setObject:upcomingEvents forKey:EVENTS];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
        }
    }];
}

- (void) createEventsFromData {
    
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
    
    [tableView reloadData];
    
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
    
    // Sort events by time
    
    NSSortDescriptor *sortDescriptor;
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"eStart"
                                                 ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    eventsArray = (NSMutableArray*)[eventsArray sortedArrayUsingDescriptors:sortDescriptors];
    
    // sort events by day
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-d"];
    
    for (Event *event in eventsArray) {
        
        NSDate *date = [dateFormat dateFromString:event.eDate];
        
        if (![days containsObject:date]) {
            
            [days addObject:date];
            [groupedEvents setValue:[NSMutableArray arrayWithObject:event] forKey:(NSString*)date];
            
        } else {
            
            [((NSMutableArray*)[groupedEvents objectForKey:date]) addObject:event];
        }
    }
    
    days = [[days sortedArrayUsingSelector:@selector(compare:)] mutableCopy];
}

- (void) createTableView {
    
    CGRect window = [[UIScreen mainScreen] bounds];
    
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, window.size.width, window.size.height) style:UITableViewStylePlain];
    
    tableView.delegate = self;
    
    tableView.dataSource = self;
    
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self.view addSubview:tableView];
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    
    return days.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    NSDate *key = [days objectAtIndex:section];
    NSMutableArray* events = [groupedEvents objectForKey:key];
    return events.count;
}

- (void) tableView:(UITableView *)table didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [table deselectRowAtIndexPath:indexPath animated:YES];
    
    EventsDetailPage *detailPage = [[EventsDetailPage alloc] init];
    
    CustomTableViewCell *cell = (CustomTableViewCell*)[table cellForRowAtIndexPath:indexPath];
    
    Event *event = cell.event;
    
    detailPage.view.backgroundColor = [UIColor whiteColor];
    
    detailPage.title = event.eTitle;
    detailPage.event = event;
    
    [detailPage createTextData];
    
    [self.navigationController pushViewController:detailPage animated:YES];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = SECTION_HEADER_DATE_FORMAT;
    NSString *dateAsString = [formatter stringFromDate:[days objectAtIndex:section]];

    return dateAsString;
}

- (void) tableView:(UITableView *)table moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    
    [table deselectRowAtIndexPath:sourceIndexPath animated:YES];
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self loadDataIntoTable:indexPath];
}

- (UITableViewCell*) loadDataIntoTable:(NSIndexPath *)index {
    
    [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    NSDate *date = [days objectAtIndex:index.section];
    
    NSMutableArray* events = [groupedEvents objectForKey:date];
    
    CustomTableViewCell *cell = [[CustomTableViewCell alloc] initWithFrame:CGRectZero];
    
    Event *event = (Event*)[events objectAtIndex:index.row];
    
    cell.event = event;
    
    [cell createTextData];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return CELL_HEIGHT;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
