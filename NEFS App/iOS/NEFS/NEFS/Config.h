//
//  Config.h
//  NEFS
//
//  Created by Stephen Sowole on 24/06/2014.
//  Copyright (c) 2014 Stephen Sowole. All rights reserved.
//

#define VERSION @"Version: 1.0.0"

// Miscellaneous

#define NO_ACCESS_LABEL_HEIGHT 120.0
#define NO_ACCESS_LABEL_FONT_SIZE 16
#define LINE_SPACING 4.50

// INFO TAB

#define INFO_URL @"http://nefs.herokuapp.com/infolist"
#define INFO_API_HEADER @"Info"

#define INFO_CATEGORIES [NSArray arrayWithObjects:@"Sponsors", @"Finance Societies", @"About NEFS", @"Send Feedback", VERSION ,nil]
#define FINANCE_SOCIETIES [NSArray arrayWithObjects:@"Corporate Finance", @"Equity Fund", @"Research", @"Women In Finance" ,nil]
#define SPONSOR_TYPES [NSArray arrayWithObjects:@"Platinum", @"Gold", @"Silver", @"Bronze", nil]

#define INFO_ROW_HEIGHT 60.0

// SPORTS TAB

#define SPORTS_URL @"http://nefs.herokuapp.com/sportslist"
#define SPORTS_API_HEADER @"Sports"
#define SPORTS_CELL_HEIGHT 140

// NEWS TAB

#define NEWS_URL @"http://nefs.herokuapp.com/newslist"
#define NEWS_API_HEADER @"News"
#define NO_NEWS_TEXT @"No Internet Connection"
#define SWIPE_TO_RETRY @"Swipe Down To Retry"
#define NEWS_ROW_HEIGHT 140.0
#define NEWS_ARTICLES @"NewsArticles"

// EVENTS TAB

#define EVENTS_CELL_HEIGHT 120
#define EVENTS_URL @"http://nefs.herokuapp.com/eventlist"
#define EVENTS_API_HEADER @"Events"
#define SECTION_HEADER_DATE_FORMAT @"d MMM yyyy"
#define NO_EVENTS_TEXT @"No Upcoming Events"
#define SORT_EVENTS_BY @"eDate"
#define BACKGROUND_GREY_SHADE 220.0

#define EVENT_TYPE_WIDTH 100
#define EVENT_TYPE_HEIGHT 106
#define EVENT_DATE_HEIGHT 64

// Detail Event Page

#define DESCRIPTION_FONT_SIZE 14
#define DATE_FONT_SIZE 14
#define UNATTEND_STRING @"Remind Me"
#define ATTEND_STRING @"Reminder Set"

#define FIRST_NOTIFICATION_TIME_HOURS 3
#define FIRST_NOTIFICATION_TEXT @" is about to start at "

#define SECOND_NOTIFICATION_TIME_HOURS 168
#define SECOND_NOTIFICATION_TEXT @" - 1 week to go!"

// Names

#define NEFS_API_NAME @"NEFS"
#define VICTORIA_CENTRE_API_NAME @"Victoria Centre"
#define CAREERS_API_NAME @"Careers"
#define SOCIAL_API_NAME @"Social"
#define SPORTS_API_NAME @"Sports"

// Icon

#define MAIN_EVENT_TYPE_ICON @"EventButtonHighlight"
#define ATTEND_ICON @"Attend"

// Image Names

#define EVENTS_IMG @"Events"
#define NEWS_IMG @"News"
#define SPORTS_IMG @"Sports"
#define INFO_IMG @"Info"

// Tab Titles / NSUserDefaults Names

#define EVENTS @"Events"
#define NEWS @"News"
#define SPORTS @"Sports"
#define INFO @"Info"

// Tab Bar Colours

#define TAB_COLOUR_R 41.0
#define TAB_COLOUR_G 95.0
#define TAB_COLOUR_B 184.0

// Database

#define ATTENDING_EVENTS @"eventsAttending"

// Descriptions

#define ABOUT_NEFS_DESCRIPTION @"2 Oct 2013 - Mail is likely one of the first thing you set up on a fresh install of iOS, ... iOS 7 added the ability to open zip files natively, without the need for third-party apps. ... This is an alternative to tapping the back button at the top-right.by Jojo Yee - 22 Sep 2013 - Double-click your iPad's Home button to reveal the open apps on the ..... The iPad allows for adding multiple mail accounts including GMail,  ... "

#define COORP_FINANCE_DESC @"coorp finance"

#define EQUITY_FUND_DESC @"equity"

#define RESEARCH_DESC @"Research"

#define WOMEN_IN_FINANCE_DESC @"women"

