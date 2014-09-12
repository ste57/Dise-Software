//
//  NewsTab.m
//  NEFS
//
//  Created by Stephen Sowole on 24/06/2014.
//  Copyright (c) 2014 Stephen Sowole. All rights reserved.
//

#import "NewsTab.h"

@implementation NewsTab {
    
    UITableView *tableView;
    NSMutableArray *newsArray;
    UIRefreshControl *refresh;
    UILabel *noInternetLabel, *retryLabel;
    
    NSMutableArray *newsRead;
}

- (void) viewDidLoad {
    
    [super viewDidLoad];
    
    [self retrieveFromURL];
    
    [self getReadNewsArticles];
    
    [self removeBackButtonText];
    
    [self getCachedNewsArticles];
    
    [self createTableView];
}

- (void) getCachedNewsArticles {
    
    newsArray = (NSMutableArray*)[[NSUserDefaults standardUserDefaults] objectForKey:NEWS_ARTICLES];
    
    if (newsArray.count) {
        
        [self createNewsFromData];
        
    }
}

- (void) getReadNewsArticles {
    
    newsRead = [[NSMutableArray alloc] init];
    
    NSMutableArray *tempArray = (NSMutableArray *)[[NSUserDefaults standardUserDefaults] objectForKey:NEWS];
    
    for (NSString *_id in tempArray) {
        
        [newsRead addObject:_id];
    }
}

- (void) removeBackButtonText {
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backButtonItem];
}

- (void) retrieveFromURL {
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    NSURL *url = [[NSURL alloc] initWithString:NEWS_URL];
    
    [NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:url] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        [refresh performSelectorOnMainThread:@selector(endRefreshing) withObject:nil waitUntilDone:NO];
        
        if (!error) {
            
            NSArray *news = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            news = [news valueForKey:NEWS_API_HEADER];
            
            if (news) {
                
                [[NSUserDefaults standardUserDefaults] setObject:news forKey:NEWS_ARTICLES];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                newsArray = (NSMutableArray*)news;
                
                [self refreshNews];
                
                [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            }
            
        } else {
            
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        }
    }];
}

- (void) refreshNews {
    
    [self createNewsFromData];
    
    if (newsArray.count) {
        
        [noInternetLabel performSelectorOnMainThread:@selector(removeFromSuperview) withObject:nil waitUntilDone:NO];
        [retryLabel performSelectorOnMainThread:@selector(removeFromSuperview) withObject:nil waitUntilDone:NO];
    }
    
    [tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
}

- (void) createNewsFromData {
    
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    
    for (NSDictionary *newsObject in newsArray) {
        
        News *addNews = [[News alloc] init];
        
        for (NSString *header in newsObject) {
            
            if ([addNews respondsToSelector:NSSelectorFromString(header)]) {
                
                [addNews setValue:[newsObject valueForKey:header] forKey:header];
            }
        }
        
        [tempArray addObject:addNews];
    }
    
    newsArray = tempArray;
}

- (void) createTableView {
    
    CGRect window = [[UIScreen mainScreen] bounds];
    
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, window.size.width, window.size.height) style:UITableViewStylePlain];
    
    tableView.delegate = self;
    
    tableView.dataSource = self;
    
    tableView.rowHeight = NEWS_ROW_HEIGHT;
    
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self.view addSubview:tableView];
    
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [tableView setSeparatorInset:UIEdgeInsetsZero];
    
    tableView.backgroundColor = [UIColor colorWithRed:BACKGROUND_GREY_SHADE/250.0 green:BACKGROUND_GREY_SHADE/250.0 blue:BACKGROUND_GREY_SHADE/250.0 alpha:1.0];
    
    if (newsArray.count) {
        
        if (!refresh) {
            
            refresh = [[UIRefreshControl alloc] init];
            
            [refresh addTarget:self action:@selector(retrieveFromURL) forControlEvents:UIControlEventValueChanged];
            
            [tableView addSubview:refresh];
        }
        
    } else {
        
        [self createNoInternetLabel];
    }
}

- (void) viewWillAppear:(BOOL)animated {
    
    [self resetPullToRefresh];
    
    if (!newsArray.count) {
        
        [self retrieveFromURL];
    }
    
    [tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
}

- (void) resetPullToRefresh {
    
    if (refresh.isRefreshing) {
        
        [refresh performSelectorOnMainThread:@selector(endRefreshing) withObject:nil waitUntilDone:NO];
    }
    
    [refresh performSelectorOnMainThread:@selector(removeFromSuperview) withObject:nil waitUntilDone:NO];
    
    refresh = NULL;
    
    refresh = [[UIRefreshControl alloc] init];
    
    [refresh addTarget:self action:@selector(retrieveFromURL) forControlEvents:UIControlEventValueChanged];
    
    [tableView addSubview:refresh];
}

- (void) createNoInternetLabel {
    
    noInternetLabel = [[UILabel alloc] initWithFrame:CGRectMake(72.0, NO_ACCESS_LABEL_HEIGHT, 200.0, 45.0)];
    noInternetLabel.textAlignment = NSTextAlignmentLeft;
    noInternetLabel.textColor = [UIColor darkGrayColor];
    noInternetLabel.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:16];
    noInternetLabel.text = NO_NEWS_TEXT;
    
    [self.view addSubview:noInternetLabel];
    
    retryLabel = [[UILabel alloc] initWithFrame:CGRectMake(92.0, NO_ACCESS_LABEL_HEIGHT+50.0, 200.0, 40.0)];
    retryLabel.textAlignment = NSTextAlignmentLeft;
    retryLabel.textColor = [UIColor darkGrayColor];
    retryLabel.font = [UIFont fontWithName:@"TrebuchetMS" size:14];
    retryLabel.text = SWIPE_TO_RETRY;
    
    [self.view addSubview:retryLabel];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return newsArray.count;
}

- (void) tableView:(UITableView *)table didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [table deselectRowAtIndexPath:indexPath animated:YES];
    
    NewsDetailPage *newsDetail = [[NewsDetailPage alloc] init];
    
    NewsCell *cell = (NewsCell*) [table cellForRowAtIndexPath:indexPath];
    
    News *news = cell.news;
    
    newsDetail.view.backgroundColor = [UIColor whiteColor];
    
    newsDetail.title = news.nTitle;
    newsDetail.news = news;
    
    [newsDetail createTextData];
    
    [self.navigationController pushViewController:newsDetail animated:YES];
    
    News *newsObject = (News*)[newsArray objectAtIndex:((newsArray.count - 1) - indexPath.row)];
    
    if (![newsRead containsObject:newsObject._id]) {
        
        [newsRead addObject:newsObject._id];
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:newsRead forKey:NEWS];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void) tableView:(UITableView *)table moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    
    [table deselectRowAtIndexPath:sourceIndexPath animated:YES];
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self loadDataIntoTable:indexPath];
}

- (UITableViewCell*) loadDataIntoTable:(NSIndexPath *)index {
    
    [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    NewsCell *cell = [[NewsCell alloc] initWithFrame:CGRectZero];
    
    News *newsObject = (News*)[newsArray objectAtIndex:((newsArray.count - 1) - index.row)];
    
    cell.news = newsObject;
    
    [cell createTextData];
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

@end
