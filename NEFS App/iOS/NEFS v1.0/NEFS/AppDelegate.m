//
//  AppDelegate.m
//  NEFS
//
//  Created by Stephen Sowole on 24/06/2014.
//  Copyright (c) 2014 Stephen Sowole. All rights reserved.
//

#import "AppDelegate.h"

#import "EventsTab.h"
#import "InfoTab.h"
#import "SportsTab.h"
#import "NewsTab.h"

#import "Config.h"

@implementation AppDelegate {
    
    EventsTab *events;
    InfoTab *info;
    NewsTab *news;
    SportsTab *sports;
    
    UITabBarController *tabBar;
    NSMutableArray *tabArray;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    tabBar = [[UITabBarController alloc] init];
    tabArray = [[NSMutableArray alloc] init];
    
    UIColor *barColour = [UIColor colorWithRed:TAB_COLOUR_R/255.0 green:TAB_COLOUR_G/255.0 blue:TAB_COLOUR_B/255.0 alpha:1.0];
    
    // Add Tabs
    
    [self addEventsTab:barColour];
    
    [self addNewsTab:barColour];
    
    [self addSportsTab:barColour];
    
    [self addInfoTab:barColour];
    
    // Add Tab To Main Window
    
    tabBar.viewControllers = tabArray;

    [[UITabBar appearance] setBarTintColor:[UIColor blackColor]];
    
    [[UITabBar appearance] setTintColor:[UIColor whiteColor]];
    
    [self.window setRootViewController:tabBar];
    
    [self.window makeKeyAndVisible];

    application.applicationIconBadgeNumber = 0;
    
    return YES;
}

- (void) addEventsTab:(UIColor*)colour {
    
    events = [[EventsTab alloc] init];
    events.title = EVENTS;
    events.tabBarItem.image = [UIImage imageNamed:EVENTS_IMG];
    [self addNavigationBar:events withColour:colour];
}

- (void) addNewsTab:(UIColor*)colour {
    
    news = [[NewsTab alloc] init];
    news.title = NEWS;
    news.tabBarItem.image = [UIImage imageNamed:NEWS_IMG];
    [self addNavigationBar:news withColour:colour];
}

- (void) addSportsTab:(UIColor*)colour {
    
    sports = [[SportsTab alloc] init];
    sports.title = SPORTS;
    sports.tabBarItem.image = [UIImage imageNamed:SPORTS_IMG];
    [self addNavigationBar:sports withColour:colour];
}

- (void) addInfoTab:(UIColor*)colour {
    
    info = [[InfoTab alloc] init];
    info.title = INFO;
    info.tabBarItem.image = [UIImage imageNamed:INFO_IMG];
    [self addNavigationBar:info withColour:colour];
}

- (void) addNavigationBar:(UIViewController*)view withColour:(UIColor*)colour {
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:view];
    
    navController.navigationBar.barTintColor = colour;
    navController.navigationBar.tintColor = [UIColor whiteColor];
    navController.navigationBar.barStyle = UIBarStyleBlack;
    
    //navController.navigationBar.topItem.title = @"";
    
    [tabArray addObject:navController];
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {

    // Set icon badge number to zero
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
