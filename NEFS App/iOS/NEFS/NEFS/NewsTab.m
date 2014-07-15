//
//  NewsTab.m
//  NEFS
//
//  Created by Stephen Sowole on 24/06/2014.
//  Copyright (c) 2014 Stephen Sowole. All rights reserved.
//

#import "NewsTab.h"

#define ROW_HEIGHT 108.0

@implementation NewsTab {
    
    UITableView *tableView;
    NSMutableArray *newsArray;
    UIRefreshControl *refresh;
    UILabel *noInternetLabel;
    
    NSMutableArray *newsRead;
}

- (void) viewDidLoad {
    
    [super viewDidLoad];
    
    [self getReadNewsArticles];
    
    [self removeBackButtonText];
    
    [self createTableView];
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
    
    if (newsArray.count > 0) {
        
        newsArray = NULL;
    }
    
    newsArray = [[NSMutableArray alloc] init];
    
    NSURL *url = [[NSURL alloc] initWithString:NEWS_URL];
    
    [NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:url] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {

        [refresh performSelectorOnMainThread:@selector(endRefreshing) withObject:nil waitUntilDone:NO];
        
        if (!error) {
            
            newsArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            newsArray = [newsArray valueForKey:NEWS_API_HEADER];
            
            if (newsArray.count) {
                
                [self refreshNews];
            }
        }
    }];
}

- (void) refreshNews {
    
    [self createNewsFromData];
    
    if (newsArray.count) {
        
        [noInternetLabel performSelectorOnMainThread:@selector(removeFromSuperview) withObject:nil waitUntilDone:NO];
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
    
    tableView.rowHeight = ROW_HEIGHT;
    
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self.view addSubview:tableView];
    
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    [tableView setSeparatorInset:UIEdgeInsetsZero];
    
    if (!newsArray.count) {
        
        [self createNoInternetLabel];
        
    } else {
        
        if (!refresh) {
            
            refresh = [[UIRefreshControl alloc] init];
            
            [refresh addTarget:self action:@selector(retrieveFromURL) forControlEvents:UIControlEventValueChanged];
            
            [tableView addSubview:refresh];
        }
    }
}

- (void) viewWillAppear:(BOOL)animated {

    if (!refresh) {
        
        refresh = [[UIRefreshControl alloc] init];
        
        [refresh addTarget:self action:@selector(retrieveFromURL) forControlEvents:UIControlEventValueChanged];
        
        [tableView addSubview:refresh];
    }
    
    if (!newsArray.count) {
        
        [self retrieveFromURL];
    }
    
    [tableView reloadData];
}

- (void) viewDidDisappear:(BOOL)animated {
    
    [refresh removeFromSuperview];
    refresh = NULL;
}

- (void) createNoInternetLabel {
    
    noInternetLabel = [[UILabel alloc] initWithFrame:CGRectMake(72.0, NO_ACCESS_LABEL_HEIGHT, 200.0, 45.0)];
    noInternetLabel.textAlignment = NSTextAlignmentLeft;
    noInternetLabel.textColor = [UIColor darkGrayColor];
    noInternetLabel.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:16];
    noInternetLabel.text = NO_NEWS_TEXT;
    
    [self.view addSubview:noInternetLabel];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return newsArray.count;
}

- (void) tableView:(UITableView *)table didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    News *newsObject = (News*)[newsArray objectAtIndex:((newsArray.count - 1) - indexPath.row)];
    
    [self goToMainSite:newsObject.nLink :newsObject.nTitle];
    
    [table deselectRowAtIndexPath:indexPath animated:YES];
    
    [newsRead addObject:newsObject._id];

    [[NSUserDefaults standardUserDefaults] setObject:newsRead forKey:NEWS];
    [[NSUserDefaults standardUserDefaults] synchronize];
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
