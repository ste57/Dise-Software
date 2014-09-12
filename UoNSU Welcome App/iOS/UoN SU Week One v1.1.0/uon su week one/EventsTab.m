//
//  EventsTab.m
//  UoN SU Week One
//
//  Created by Stephen Sowole on 15/08/2014.
//  Copyright (c) 2014 Stephen Sowole. All rights reserved.
//

#import "LoadingView.h"
#import "EventsTab.h"

@implementation EventsTab {
    
    NSMutableArray *displayedEvents;
    NSMutableDictionary *allEvents;
    
    NSMutableString *title;
    NSMutableString *link;
    NSMutableString *description;
    NSMutableString *category;
    
    NSMutableArray *dataArray;
    
    NSString *element;
    
    Event *event;
    
    UITableView *tableView;
    
    UIScrollView *scrollView;
    
    UIButton *mainButton;
    
    LoadingView *loadingView;
    UILabel *loadingLabel;
}

- (void) viewDidLoad {
    
    [super viewDidLoad];
    
    [self setScreenName:@"Events Tab"];
    
    self.edgesForExtendedLayout = UIRectEdgeBottom;
    
    [self removeBackButtonText];
    
    [self createTableView];
    
    [self allocateMemoryToArrays];
    
    [self getEventsData];
    
    [self createHorizontalDateScroller];
    
    [self setFirstRunLoadIndicator];
}

- (void) viewWillAppear:(BOOL)animated {
    
    if (!allEvents.count&&![loadingView.shimmeringView isShimmering]&&![[UIApplication sharedApplication] isNetworkActivityIndicatorVisible]) {
        
        [self retrieveFromURL];
    }
    
    [tableView reloadData];
}

- (void) removeBackButtonText {
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backButtonItem];
}

- (void) setFirstRunLoadIndicator {
    
    if (allEvents.count != EVENT_DATES.count) {
        
        loadingView = [LoadingView new];
        [loadingView setTranslatesAutoresizingMaskIntoConstraints:false];
        [self.view addSubview:loadingView];
        
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:loadingView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
        
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:loadingView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:-25.0]];
        
        [self performSelector:@selector(unableToRetrieveData) withObject:nil afterDelay:LOAD_VIEW_TIMEOUT];
    }
}

- (void) unableToRetrieveData {
    
    loadingView.loadingLabel.text = LOADING_FAIL;
    loadingView.shimmeringView.shimmering = NO;
    loadingView.loadingLabel.textColor = [UIColor darkGrayColor];
}

- (void) allocateMemoryToArrays {
    
    [self.view setBackgroundColor:EVENTS_TABLE_BACKGROUND_COLOUR];
    
    displayedEvents = [[NSMutableArray alloc] init];
    allEvents = [[NSMutableDictionary alloc] init];
    
    title = [[NSMutableString alloc] init];
    link = [[NSMutableString alloc] init];
    description = [[NSMutableString alloc] init];
    category = [[NSMutableString alloc] init];
    
    [self setUpDataArray];
}

- (void) setUpDataArray {
    
    dataArray = [NSMutableArray array];
    
    for (int i = 0; i < EVENT_DATES.count; i++)
        [dataArray addObject:@""];
    
    int count = 0;
    
    for (NSData* data in [[NSUserDefaults standardUserDefaults] objectForKey:DATA_ARRAY]) {
        
        [dataArray replaceObjectAtIndex:count++ withObject:data];
    }
    
    [self convertXMLDataToEvents];
}

- (void) createHorizontalDateScroller {
    
    scrollView = [[UIScrollView alloc] init];
    scrollView.frame = CGRectMake(0, 0, self.view.frame.size.width, SCROLL_VIEW_HEIGHT - SEPARATOR_PADDING_SIZE);
    scrollView.backgroundColor = SCROLL_VIEW_BACKGROUND_COLOUR;
    scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [scrollView setShowsHorizontalScrollIndicator:NO];
    
    [self addDates];
    
    [self.view addSubview:scrollView];
}

- (void) addDates {
    
    UIButton *button;
    NSMutableArray *buttonArray = [[NSMutableArray alloc] init];
    
    int buttonNo = 0;
    
    for (NSString *date in EVENT_DATES) {
        
        button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        button.frame = CGRectMake(EVENT_DATE_BUTTON_RADIUS*buttonNo + EVENT_DATE_BUTTON_SPACING*(buttonNo+1), SCROLL_VIEW_HEIGHT/2 - EVENT_DATE_BUTTON_RADIUS/2 - SEPARATOR_PADDING_SIZE/2, EVENT_DATE_BUTTON_RADIUS, EVENT_DATE_BUTTON_RADIUS);
        
        [button setTitle:date forState:UIControlStateNormal];
        
        [button setTitle:date forState:UIControlStateHighlighted];
        [button setTitle:date forState:UIControlStateSelected | UIControlStateHighlighted];
        
        button.titleLabel.textAlignment = NSTextAlignmentLeft;
        
        [button setTitleColor:EVENT_DATE_BUTTON_TEXT_COLOUR forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateSelected];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        
        [[button layer] setBorderColor:[scrollView.backgroundColor CGColor]];
        [[button layer] setBorderWidth:2.0];
        
        button.titleLabel.font = [UIFont fontWithName:BUTTON_FONT size:20.0];
        
        button.layer.cornerRadius = EVENT_DATE_BUTTON_RADIUS/2;
        
        [button setBackgroundColor:EVENT_DATE_BUTTON_BACKGROUND_COLOUR];
        
        [scrollView addSubview:button];
        
        [button addTarget:self action:@selector(selectMainButton:) forControlEvents:UIControlEventTouchUpInside];
        
        buttonNo++;
        
        [buttonArray addObject:button];
    }
    
    [self setDefaultMainButton:buttonArray];
    
    scrollView.contentSize = CGSizeMake(button.frame.origin.x + EVENT_DATE_BUTTON_RADIUS + EVENT_DATE_BUTTON_SPACING, scrollView.frame.size.height);
}

- (void) setDefaultMainButton:(NSMutableArray*)buttonArray {
    
    NSDate *currentDate = [NSDate date];
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:currentDate];
    
    for (UIButton *button in buttonArray) {
        
        if ([button.titleLabel.text isEqualToString:[NSString stringWithFormat:@"%li",(long)[components day]]]) {
            
            [self selectMainButton:button];
        }
    }
    
    if (!mainButton) {
        
        [self selectMainButton:[buttonArray firstObject]];
    }
    
    scrollView.contentOffset = CGPointMake(mainButton.center.x - mainButton.frame.size.width - EVENT_DATE_BUTTON_SPACING,0);
}

- (void) selectMainButton:(UIButton*)button {
    
    if (!loadingView) {
        
        if (mainButton) {
            
            [[mainButton layer] setBorderColor:[scrollView.backgroundColor  CGColor]];
        }
        
        mainButton = button;
        
        [[mainButton layer] setBorderColor:[EVENT_DATE_BUTTON_BACKGROUND_COLOUR_SELECTED CGColor]];
        
        tableView.contentOffset = CGPointMake(0,0);
        
        [tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
    }
}

- (void) refreshTable {
    
    [self convertXMLDataToEvents];
}

- (void) getEventsData {
    
    if ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] == ReachableViaWiFi || [self needsDataUpdate]) {
        
        [self retrieveFromURL];
    }
}

- (BOOL) needsDataUpdate {
    
    int count = 0;
    
    for (NSData *data in dataArray) {
        
        if ([data isEqual:@""]) {
            
            count++;
        }
    }
    
    return count;
}

- (void) retrieveFromURL {
    
    int count = 0;
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [[UIApplication sharedApplication] performSelector:@selector(setNetworkActivityIndicatorVisible:) withObject:NO afterDelay:30.0];
    
    for (NSString *eventLink in EVENTS_FEED_URL_ARRAY) {
        
        NSURL *url = [NSURL URLWithString:eventLink];
        
        [NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:url] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
            
            if (!error) {
                
                if (data) {
                    
                    [dataArray replaceObjectAtIndex:count withObject:data];
                    
                    [[NSUserDefaults standardUserDefaults] setObject:dataArray forKey:DATA_ARRAY];
                }
                
                if (eventLink == [EVENTS_FEED_URL_ARRAY lastObject]) {
                    
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    
                    [self finalCheck];
                    
                    [self refreshTable];
                    
                    if (loadingView) {
                        
                        [loadingView performSelectorOnMainThread:@selector(removeFromSuperview) withObject:nil waitUntilDone:NO];
                        loadingView = NULL;
                    }
                }
            }
        }];
        
        count++;
    }
}

- (void) finalCheck {
    
    int count = 0;
    
    if (allEvents.count != EVENT_DATES.count) {
        
        for (NSString *eventLink in EVENTS_FEED_URL_ARRAY) {
            
            if ([[dataArray objectAtIndex:count] isEqual:@""]) {
                
                NSURL *url = [NSURL URLWithString:eventLink];
                
                NSURLRequest * urlRequest = [NSURLRequest requestWithURL:url];
                
                NSURLResponse * response = nil;
                NSError * error = nil;
                
                NSData * data = [NSURLConnection sendSynchronousRequest:urlRequest
                                                      returningResponse:&response
                                                                  error:&error];
                
                [dataArray replaceObjectAtIndex:count withObject:data];
                
                if (eventLink == [EVENTS_FEED_URL_ARRAY lastObject]) {
                    
                    [[NSUserDefaults standardUserDefaults] setObject:dataArray forKey:DATA_ARRAY];
                    
                    [[NSUserDefaults standardUserDefaults] synchronize];
                }
            }
            count++;
        }
    }
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

- (void) convertXMLDataToEvents {
    
    int count = 0;
    
    for (NSData *eventData in dataArray) {
        
        if ([eventData isEqual:@""]) {
            
            count++;
            continue;
        }
        
        //if (![allEvents objectForKey:[EVENT_DATES objectAtIndex:count]]) {
        
        NSXMLParser *parser = [[NSXMLParser alloc] initWithData:eventData];
        
        [parser setDelegate:self];
        [parser setShouldResolveExternalEntities:NO];
        [parser parse];
        
        [allEvents setObject:displayedEvents forKey:[EVENT_DATES objectAtIndex:count++]];
        
        displayedEvents = [[NSMutableArray alloc] init];
        // }
    }
    
    [tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
}

- (void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    element = elementName;
    
    if ([element isEqualToString:ITEM_XML_BRACKET]) {
        
        [title setString:@""];
        [link setString:@""];
        [description setString:@""];
        [category setString:@""];
        
        event = [[Event alloc] init];
    }
}

- (void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    if ([element isEqualToString:XML_TITLE]) {
        
        [title appendString:string];
        
    } else if ([element isEqualToString:XML_LINK]) {
        
        [link appendString:string];
        
    } else if ([element isEqualToString:XML_DESCRIPTION]) {
        
        [description appendString:string];
        
    } else if ([element isEqualToString:XML_CATEGORY]) {
        
        [category appendString:string];
    }
}

- (void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    
    if ([elementName isEqualToString:ITEM_XML_BRACKET]) {
        
        [self createEventFromParseData];
        
    } else if ([elementName isEqualToString:XML_CATEGORY]) {
        
        NSString *string;
        
        string = [category stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        string = [string stringByReplacingOccurrencesOfString:@"		" withString:@""];
        
        [event.categories addObject:string];
        category = [NSMutableString string];
    }
}

- (void) createEventFromParseData {
    
    event.title = [NSString stringWithString:title];
    
    event.link = [NSString stringWithString:link];
    
    NSMutableArray *descElements = [[NSMutableArray alloc] init];
    
    NSString *string;
    
    for (NSString* desc in [description componentsSeparatedByString: @"\n"]) {
        
        string = desc;
        
        NSRange r;
        
        while ((r = [string rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound) {
            
            string = [string stringByReplacingCharactersInRange:r withString:@""];
        }
        
        [descElements addObject:string];
    }
    
    [descElements removeObject:@""];
    
    event.time = [descElements firstObject];
    
    if (descElements.count > 3) {
        
        NSString *combinedDescription = @"";
        
        for (int i = 1; i < (descElements.count - 2); i++) {
            
            combinedDescription = [NSString stringWithFormat:@"%@%@\n", combinedDescription,[descElements objectAtIndex:i]];
        }
        
        event.eventDesc = combinedDescription;
        
        event.location = [descElements objectAtIndex:(descElements.count - 2)];
        
    } else {
        
        event.eventDesc = [descElements objectAtIndex:1];
        
        event.location = @"";
    }
    
    event.date = [event.categories objectAtIndex:0];
    
    [event.categories removeObject:event.date];
    
    event._id = [NSString stringWithFormat:@"%@%@%@", event.title, event.time, event.date];
    
    [displayedEvents addObject:event];
}

- (void) createTableView {
    
    CGRect window = [[UIScreen mainScreen] bounds];
    
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, SCROLL_VIEW_HEIGHT - SEPARATOR_PADDING_SIZE, window.size.width, window.size.height - SCROLL_VIEW_HEIGHT) style:UITableViewStylePlain];
    
    tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    
    tableView.rowHeight = EVENTS_CELL_HEIGHT;
    
    tableView.delegate = self;
    
    tableView.dataSource = self;
    
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self.view addSubview:tableView];
    
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    tableView.backgroundColor = EVENTS_TABLE_BACKGROUND_COLOUR;
    
    tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:TABLEVIEW_BACKGROUND_IMG]];
    
    tableView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, -SEPARATOR_PADDING_SIZE, 0);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSArray *events;
    
    events = [allEvents objectForKey:mainButton.titleLabel.text];
    
    return events.count;
}

- (void) tableView:(UITableView *)table didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [table deselectRowAtIndexPath:indexPath animated:YES];
    
    EventDetailPage *detailPage = [[EventDetailPage alloc] init];
    
    NSArray *eventArray = [allEvents objectForKey:mainButton.titleLabel.text];
    
    detailPage.event = [eventArray objectAtIndex:indexPath.row];
    
    [detailPage createTextData];
    
    [self.navigationController pushViewController:detailPage animated:YES];
}

- (void) tableView:(UITableView *)table moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    
    [table deselectRowAtIndexPath:sourceIndexPath animated:YES];
}

- (UITableViewCell*) tableView:(UITableView *)table cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [table dequeueReusableCellWithIdentifier:@"Cell"];
    
    EventsCustomTVCell *cell = [[EventsCustomTVCell alloc] initWithFrame:CGRectZero];
    
    NSArray *eventArray = [allEvents objectForKey:mainButton.titleLabel.text];
    
    cell.event = [eventArray objectAtIndex:indexPath.row];
    
    [cell createTextData];
    
    return cell;
}

- (void) didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

@end
