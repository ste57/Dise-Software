//
//  CampusHopper.m
//  UoNSU Welcome App
//
//  Created by Stephen Sowole on 02/09/2014.
//  Copyright (c) 2014 Stephen Sowole. All rights reserved.
//

#import "CampusHopper.h"

#define LOADING_TEXT @"Retrieving Times..."

#define CELL_FONT @"GillSans"
#define CELL_FONT_SIZE 16.0

@implementation CampusHopper {
    
    NSString *hopper;
    NSArray *hopperTimes;
    
    UIView *loadingView;
    UILabel *loadingLabel;
    
    UIActivityIndicatorView *activityView;
    
    int selectedIndex;
    
    UITableViewCell *customCell;
    
    UILabel *timeLabel;
}

- (void) showFullTimes:(NSMutableDictionary*)times {
    
    AllTimesForBus *alltimes = [[AllTimesForBus alloc] init];
    [alltimes setTitle:[self title]];
    alltimes.times = times;
    [self.navigationController pushViewController:alltimes animated:YES];
}

- (void) viewDidLoad {
    
    [super viewDidLoad];
    
    [self.tableView setScrollEnabled:NO];
    
    selectedIndex = -1;
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [self removeBackButtonText];
}

- (void) setFirstRunLoadIndicator {
    
    if (!hopperTimes) {
        
        loadingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, LOADING_VIEW_RADIUS*2, LOADING_VIEW_RADIUS)];
        loadingView.center = CGPointMake(self.view.frame.size.width/2.0, self.view.frame.size.height/2.6);
        loadingView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        loadingView.clipsToBounds = YES;
        loadingView.layer.cornerRadius = 10.0;
        
        activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        activityView.frame = CGRectMake(0, 0, activityView.bounds.size.width, activityView.bounds.size.height);
        activityView.center = CGPointMake(loadingView.frame.size.width/2.0, loadingView.frame.size.height/2.6);
        [loadingView addSubview:activityView];
        
        loadingLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, loadingView.frame.size.width, loadingView.frame.size.height/3.0)];
        loadingLabel.center = CGPointMake(loadingView.frame.size.width/2.0, loadingView.frame.size.height/1.4);
        loadingLabel.backgroundColor = [UIColor clearColor];
        loadingLabel.textColor = [UIColor grayColor];
        loadingLabel.adjustsFontSizeToFitWidth = YES;
        loadingLabel.font = [UIFont systemFontOfSize:TWITTER_FEED_LOADING_FONT_SIZE];
        loadingLabel.minimumScaleFactor = LOADING_VIEW_MINIMUM_FONT_SIZE;
        loadingLabel.numberOfLines = 3;
        loadingLabel.textAlignment = NSTextAlignmentCenter;
        loadingLabel.text = LOADING_TEXT;
        [loadingView addSubview:loadingLabel];
        
        [self performSelector:@selector(unableToRetrieveData) withObject:nil afterDelay:LOAD_VIEW_TIMEOUT];
        
        [self.view addSubview:loadingView];
        [activityView startAnimating];
        
        if ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] == NotReachable) {
            
            [self unableToRetrieveData];
        }
    }
}

- (void) unableToRetrieveData {
    
    loadingLabel.text = LOADING_FAIL;
    
    [activityView stopAnimating];
    
    [[UIApplication sharedApplication] performSelector:@selector(setNetworkActivityIndicatorVisible:) withObject:NO];
}

- (void) removeBackButtonText {
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backButtonItem];
}

- (void) getBusTimes:(NSString *)bus {
    
    hopper = bus;
    
    NSError *error;
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:hopper]) {
    
        hopperTimes = [NSJSONSerialization JSONObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:hopper] options:
                   NSJSONReadingMutableContainers error:&error];
        
        [self.tableView setScrollEnabled:YES];
        
        [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    }
    
    if ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] == ReachableViaWiFi || [self needsDataUpdate]) {
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
        [[UIApplication sharedApplication] performSelector:@selector(setNetworkActivityIndicatorVisible:) withObject:NO afterDelay:30.0];
        
        NSURL *url = [NSURL URLWithString:bus];
        
        [NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:url] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
            
            if (!error) {
                
                if (data) {
                    
                    [[NSUserDefaults standardUserDefaults] setObject:data forKey:hopper];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    
                    hopperTimes = [NSJSONSerialization JSONObjectWithData:data options:
                                   NSJSONReadingMutableContainers error:&error];
                    
                    [loadingView performSelectorOnMainThread:@selector(removeFromSuperview) withObject:nil waitUntilDone:NO];
                    
                    [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
                    
                    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
                    
                    [self.tableView setScrollEnabled:YES];
                    
                    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                }
            }
        }];
    }
    
    [self setFirstRunLoadIndicator];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return hopperTimes.count;
}

- (BOOL) needsDataUpdate {
    
    return !hopperTimes.count;
}

- (UITableViewCell *)tableView:(UITableView *)table cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [table dequeueReusableCellWithIdentifier:@"Cell"];
    
    CustomCell *cell = [[CustomCell alloc] initWithFrame:CGRectZero];
    
    cell.busStops = [hopperTimes objectAtIndex:indexPath.row];
    
    [cell createSections];
    
    cell.clipsToBounds = YES;
    
    cell.separatorInset = UIEdgeInsetsZero;
    
    cell.delegate = self;
    
    if (selectedIndex == indexPath.row) {
        
        [self getThreeNextTimes:cell :indexPath.row :YES];
        
    } else {
        
        [cell removeExpandedCell];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.row == selectedIndex) {
        
        return HOPPER_TABLE_HEIGHT_EXP;
    }
    
    return HOPPER_TABLE_HEIGHT;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    if (selectedIndex == indexPath.row) {
        
        selectedIndex = -1;
        timeLabel = NULL;
        
    } else {
        
        timeLabel = NULL;
    
        selectedIndex = (int)indexPath.row;
        
        UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
        
        [self getThreeNextTimes:(CustomCell*)selectedCell :indexPath.row :NO];
    }
    
    [tableView beginUpdates];
    
    [tableView endUpdates];
}

- (void) getThreeNextTimes:(CustomCell*)cell :(NSInteger)row :(BOOL)background {
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(115.0, HOPPER_TABLE_HEIGHT+5.0, self.view.frame.size.width - 30.0, 40)];
    label.font = [UIFont fontWithName:CELL_FONT size:CELL_FONT_SIZE];
    label.textColor = [UIColor grayColor];
    label.text = @"Next bus times:";
    label.textAlignment = NSTextAlignmentLeft;
    
    [cell addSubview:label];
    
    timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0, HOPPER_TABLE_HEIGHT+30.0, self.view.frame.size.width - 30.0, 40)];
    timeLabel.font = [UIFont fontWithName:CELL_FONT size:CELL_FONT_SIZE];
    timeLabel.textColor = [UIColor darkGrayColor];

    if (!timeLabel.text) {

        if(![[self getCurrentDay] isEqual: @"Saturday"] && ![[self getCurrentDay] isEqual: @"Sunday"]){
            
            timeLabel.text = [self getNextThreeTimes:[[hopperTimes objectAtIndex:row] valueForKey:[HOPPER_API_HEADERS objectAtIndex:0]]];
            
        } else if ([[self getCurrentDay] isEqual: @"Saturday"]) {
            
            timeLabel.text = [self getNextThreeTimes:[[hopperTimes objectAtIndex:row] valueForKey:[HOPPER_API_HEADERS objectAtIndex:1]]];
            
        } else {
            
            timeLabel.text = @"No buses";
        }
    }
    
    timeLabel.textAlignment = NSTextAlignmentCenter;

    [cell addSubview:timeLabel];
}

- (NSString *)getCurrentDay {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEEE"];
    
    return [dateFormatter stringFromDate:[NSDate date]];
}

- (NSString *) getNextThreeTimes:(NSArray *)times {
    
    int amountDiscovered = 0;
    
    NSMutableString *appendedTimes = [NSMutableString string];
    // get current date/time
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // display in 12HR/24HR (i.e. 11:25PM or 23:25) format according to User Settings
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"HH:mm"];
    NSString *currentTime = [dateFormatter stringFromDate:today];
    currentTime = [currentTime stringByReplacingOccurrencesOfString:@"PM" withString:@""];
    
    for (int time = 0; time < [times count]; time++) {
        
        if (amountDiscovered == 3) {
            break;
        }
        
        NSString *selectedTime;
        
        selectedTime = [[times objectAtIndex:time] stringByReplacingOccurrencesOfString:@"." withString:@":"];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"HH:mm"];
        
        NSDate *date1= [formatter dateFromString:currentTime];
        NSDate *date2 = [formatter dateFromString:selectedTime];
        
        NSComparisonResult result = [date1 compare:date2];
        
        if (result == NSOrderedDescending) {
            //NSLog(@"date1 is later than date2");
            
        } else if (result == NSOrderedAscending) {
            //Gets in here when the current time is less than the hovering time indicating a suitable take of time()
            amountDiscovered++;
            [appendedTimes appendString:[NSString stringWithFormat:@"%@    ",[times objectAtIndex:time]]];
            
        } else {
            //NSLog(@"date1 is equal to date2");
        }
    }
    
    if (!amountDiscovered) {
        
        return @"No buses";
    }
    
    return appendedTimes;
}

- (void) didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

@end
