//
//  AppDelegate.m
//  UoN SU Week One
//
//  Created by Stephen Sowole on 15/08/2014.
//  Copyright (c) 2014 Stephen Sowole. All rights reserved.
//

#import "GAI.h"
#import "GAIFields.h"
#import "AppDelegate.h"

@implementation AppDelegate {
    
    EventsTab *events;
    TwitterTab *twitterFeed;
    InfoTab *info;
    
    UITabBarController *tabBar;
    NSMutableArray *tabArray;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];

    [[UINavigationBar appearance] setTitleTextAttributes: @{NSFontAttributeName:[UIFont fontWithName:@"Montserrat" size:16.0f],
                                                            NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    tabBar = [[UITabBarController alloc] init];
    tabArray = [[NSMutableArray alloc] init];
    
    // Add Tabs
    
    [self addEventsTab];
    
    [self addTwitterTab];
    
    [self addInfoTab];
    
    // Add Tab To Main Window
    
    tabBar.viewControllers = tabArray;
    
    [[UITabBar appearance] setBarTintColor:TABS_TINT_COLOUR];
    
    [[UITabBar appearance] setTintColor:ICON_SELECT_COLOUR];
    
    [[UITabBar appearance] setAlpha:TAB_BAR_ALPHA];
    
    tabBar.tabBar.translucent = TAB_BAR_TRANSLUCENT;
    
    // Set Start View
    
    [self.window setRootViewController:tabBar];
    
    [self.window makeKeyAndVisible];
    
    application.applicationIconBadgeNumber = 0;

    // Analytics Tracking

    [GAI sharedInstance].trackUncaughtExceptions = YES;
    [GAI sharedInstance].dispatchInterval = 20;
    [[[GAI sharedInstance] logger] setLogLevel:kGAILogLevelVerbose];
    [[GAI sharedInstance] trackerWithTrackingId:@"UA-46757742-7"];
    
    return YES;
}

- (void) addEventsTab {
    
    events = [[EventsTab alloc] init];
    events.title = EVENTS;
    events.tabBarItem.image = [UIImage imageNamed:EVENTS_IMG];
    events.navigationItem.title = WEEK_ONE_EVENTS_TITLE;
    
    [self addNavigationBar:events];
}

- (void) addTwitterTab {
    
    twitterFeed = [[TwitterTab alloc] init];
    twitterFeed.title = TWITTER;
    twitterFeed.tabBarItem.image = [UIImage imageNamed:TWITTER_IMG];
    twitterFeed.navigationItem.title = TWITTER_NAV_TITLE;
    
    [self addNavigationBar:twitterFeed];
}

- (void) addInfoTab {
    
    info = [[InfoTab alloc] init];
    info.title = INFO;
    info.tabBarItem.image = [UIImage imageNamed:INFO_IMG];
    info.navigationItem.title = INFO_NAV_TITLE;
    
    [self addNavigationBar:info];
}

- (void) addNavigationBar:(UIViewController*)view {
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:view];
    
    navController.navigationBar.barTintColor = NAV_BAR_COLOUR;
    navController.navigationBar.tintColor = [UIColor whiteColor];
    navController.navigationBar.barStyle = UIBarStyleBlack;
    navController.navigationBar.translucent = NAV_BAR_TRANSLUCENT;
    
    [tabArray addObject:navController];
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {

    application.applicationIconBadgeNumber = 0;
}

- (void)applicationWillResignActive:(UIApplication *)application {

}

- (void)applicationDidEnterBackground:(UIApplication *)application {

    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {

}

- (void)applicationDidBecomeActive:(UIApplication *)application {

}

- (void)applicationWillTerminate:(UIApplication *)application {
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
