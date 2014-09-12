//
//  TwitterTab.m
//  UoN SU Week One
//
//  Created by Stephen Sowole on 15/08/2014.
//  Copyright (c) 2014 Stephen Sowole. All rights reserved.
//

#import "TwitterTab.h"

#define PADDING 15.0
#define CELL_FONT @"GillSans"
#define CELL_FONT_SIZE 14.0

#define TWITTER_CELL_HEIGHT 120

#define DESCRIPTION_COLOUR [UIColor colorWithRed:0.31 green:0.31 blue:0.38 alpha:1.0]

@implementation TwitterTab {
    
    NSArray *twitterData;
    
    UIRefreshControl *refreshControl;
    
    UITableView *tableView;
    
    UIActivityIndicatorView *activityView, *tableFooterActivityView;
    UIView *loadingView;
    UILabel *loadingLabel;
    
    int tweetRequests;
}

- (void) viewDidLoad {
    
    [super viewDidLoad];
    
    [self setScreenName:@"Twitter Tab"];
    
    twitterData = [[NSArray alloc] init];
    
    tweetRequests = (int)(self.view.frame.size.height/TWITTER_CELL_HEIGHT)*2;
    
    [self removeBackButtonText];
    
    [self getMoreTweets:tweetRequests];
    
    [self createTableView];
    
    [self addLoadingIndicator];
}

- (void) removeBackButtonText {
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backButtonItem];
}

- (void) viewWillAppear:(BOOL)animated {
    
    [self resetActivityControl];
    
    if (![twitterData count] && [[Reachability reachabilityForInternetConnection] currentReachabilityStatus]) {
        
        [self getMoreTweets:0];
    }
}

- (void) addLoadingIndicator {
    
    if (![twitterData count]) {
        
        loadingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, LOADING_VIEW_RADIUS*2, LOADING_VIEW_RADIUS)];
        loadingView.center = CGPointMake(self.view.frame.size.width/2.0, self.view.frame.size.height * (2.3/5.0));
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
        loadingLabel.text = TWITTER_LOADING_TEXT;
        [loadingView addSubview:loadingLabel];
        
        [self performSelector:@selector(unableToRetrieveData) withObject:nil afterDelay:LOAD_VIEW_TIMEOUT];
        
        [self.view addSubview:loadingView];
        [activityView startAnimating];
        
        if ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] == NotReachable) {
            
            [self unableToRetrieveData];
        }
    }
    
    tableFooterActivityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    tableFooterActivityView.frame = CGRectMake(0, 0, self.view.frame.size.width/2, 50);
    tableView.tableFooterView = tableFooterActivityView;
}

- (void) unableToRetrieveData {
    
    loadingLabel.text = LOADING_FAIL;
    
    [activityView stopAnimating];
}

- (void) createTableView {
    
    CGRect window = [[UIScreen mainScreen] bounds];
    
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, window.size.width, window.size.height) style:UITableViewStylePlain];
    
    tableView.rowHeight = TWITTER_CELL_HEIGHT;
    
    tableView.delegate = self;
    
    tableView.dataSource = self;
    
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    [self.view addSubview:tableView];
    
    tableView.hidden = YES;
}

- (void) addRefreshButton {
    
    if (!refreshControl) {
        
        refreshControl = [[UIRefreshControl alloc] init];
        
        [refreshControl addTarget:self action:@selector(refreshFeed) forControlEvents:UIControlEventValueChanged];
        
        [tableView addSubview:refreshControl];
    }
}

- (void) refreshFeed {
    
    [self getMoreTweets:0];
    
    [refreshControl endRefreshing];
}

- (void) resetActivityControl {
    
    if (refreshControl.isRefreshing) {
        
        [refreshControl performSelectorOnMainThread:@selector(endRefreshing) withObject:nil waitUntilDone:NO];
    }
    
    [refreshControl performSelectorOnMainThread:@selector(removeFromSuperview) withObject:nil waitUntilDone:NO];
    
    refreshControl = NULL;
    
    refreshControl = [[UIRefreshControl alloc] init];
    
    [refreshControl addTarget:self action:@selector(refreshFeed) forControlEvents:UIControlEventValueChanged];
    
    [tableView addSubview:refreshControl];
}

- (void) getMoreTweets:(int)extraNumberOfTweets {
    
    if ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus]) {
        
        if ([twitterData count])
            [tableFooterActivityView startAnimating];
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    }
    
    STTwitterAPI *twitter = [STTwitterAPI twitterAPIAppOnlyWithConsumerKey:TWITTER_ACCOUNT_KEY consumerSecret:TWITTER_ACCOUNT_SECRET];
    
    [twitter verifyCredentialsWithSuccessBlock:^(NSString *bearerToken) {
        
        [twitter getUserTimelineWithScreenName:TWITTER_ACCOUNT count:(twitterData.count + extraNumberOfTweets) successBlock:^(NSArray *statuses) {
            
            twitterData = statuses;
            
            [tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
            
            if ([twitterData count]) {
                
                tableView.hidden = NO;
                
                [self addRefreshButton];
                
                [loadingView performSelectorOnMainThread:@selector(removeFromSuperview) withObject:nil waitUntilDone:NO];
            }
            
            [self stopAnimatingActivityControls];
            
        } errorBlock:^(NSError *error){ [self unableToRetrieveData]; [self stopAnimatingActivityControls];}];
        
    } errorBlock:^(NSError *error){ [self unableToRetrieveData]; [self stopAnimatingActivityControls];}];
}

- (void) stopAnimatingActivityControls {
    
    [activityView stopAnimating];
    [tableFooterActivityView stopAnimating];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

- (void) scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    NSInteger currentOffset = scrollView.contentOffset.y;
    NSInteger maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height;
    
    if (maximumOffset - currentOffset <= 0) {
        
        [self getMoreTweets:tweetRequests];
    }
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [twitterData count];
}

- (UITableViewCell*) tableView:(UITableView *)table cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [table dequeueReusableCellWithIdentifier:@"Cell"];
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithFrame:CGRectZero];
    
    [cell addSubview:[self addDescriptionLabel:[[twitterData objectAtIndex:indexPath.row] valueForKey:@"text"] :cell]];
    
    [cell addSubview:[self addTwitterAccountLabel:[NSString stringWithFormat:@"#%@",TWITTER_ACCOUNT] :cell]];
    
    [cell addSubview:[self addTimeLabel:[[twitterData objectAtIndex:indexPath.row] valueForKey:@"created_at"] :cell]];
    
    return cell;
}

- (void) tableView:(UITableView *)table didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CustomWebView *web = [[CustomWebView alloc] init];
    
    [self.navigationController pushViewController:web animated:YES];
    
    web.title = [[[twitterData objectAtIndex:indexPath.row] valueForKey:@"user"] valueForKey:@"name"];
    
    NSArray *array = [[[[twitterData objectAtIndex:indexPath.row] valueForKey:@"entities"] valueForKey:@"urls"] valueForKey:@"url"];
    
    if (array.count) {
        
        web.websiteLink = [array firstObject];
        
    } else {
        
        array = [[[[twitterData objectAtIndex:indexPath.row] valueForKey:@"entities"] valueForKey:@"media"] valueForKey:@"url"];
        
        if (array.count) {
            
            web.websiteLink = [array firstObject];
            
        } else {
            
            web.websiteLink = [[[twitterData objectAtIndex:indexPath.row] valueForKey:@"user"] valueForKey:@"url"];
        }
    }
    
    [web loadWebsite];
    
    [table deselectRowAtIndexPath:indexPath animated:YES];
}

- (UILabel*) addDescriptionLabel:(NSString*)text :(UITableViewCell*)cell {
    
    UILabel *descLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width - PADDING*2, TWITTER_CELL_HEIGHT - PADDING*2)];
    
    descLabel.center = CGPointMake(cell.frame.size.width/2, TWITTER_CELL_HEIGHT/3*1.8);
    
    descLabel.text = text;
    
    descLabel.font = [UIFont fontWithName:CELL_FONT size:CELL_FONT_SIZE];
    
    descLabel.textColor = DESCRIPTION_COLOUR;
    
    descLabel.numberOfLines = 4;
    
    return descLabel;
}

- (UILabel*) addTwitterAccountLabel:(NSString*)text :(UITableViewCell*)cell {
    
    UILabel *twitterLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width - PADDING*2, TWITTER_CELL_HEIGHT - PADDING*2)];
    
    twitterLabel.center = CGPointMake(cell.frame.size.width/2, TWITTER_CELL_HEIGHT/5);
    
    twitterLabel.font = [UIFont fontWithName:CELL_FONT size:CELL_FONT_SIZE];
    
    twitterLabel.textColor = [UIColor grayColor];
    
    twitterLabel.text = text;
    
    twitterLabel.textAlignment = NSTextAlignmentLeft;
    
    return twitterLabel;
}

- (UILabel*) addTimeLabel:(NSString*)text :(UITableViewCell*)cell {
    
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width - PADDING*2, TWITTER_CELL_HEIGHT - PADDING*2)];
    
    timeLabel.center = CGPointMake(cell.frame.size.width/2, TWITTER_CELL_HEIGHT/5);
    
    timeLabel.font = [UIFont fontWithName:CELL_FONT size:CELL_FONT_SIZE];
    
    timeLabel.textColor = [UIColor grayColor];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    
    [dateFormat setDateFormat:@"EEE MMM dd HH:mm:ss +0000 yyyy"];
    
    NSDate *date = [dateFormat dateFromString:text];
    
    [dateFormat setDateFormat:@"yyyy/MM/dd"];
    
    
    
    NSTimeInterval timeInterval  = [[NSDate date] timeIntervalSinceDate:date];
    
    int minutes = floor(timeInterval/60) - 60;
    int hours = (minutes / 60);
    
    if (hours < 24) {
        
        if (hours < 1) {
            
            timeLabel.text = [NSString stringWithFormat:@"%im", minutes];
            
        } else {
            
            timeLabel.text = [NSString stringWithFormat:@"%ih", hours];
        }
        
    } else {
        
        [dateFormat setDateFormat:@"dd MMM"];
        
        timeLabel.text = [NSString stringWithFormat:@"%@", [dateFormat stringFromDate:date]];
    }
    
    
    
    timeLabel.textAlignment = NSTextAlignmentRight;
    
    return timeLabel;
}

- (void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
