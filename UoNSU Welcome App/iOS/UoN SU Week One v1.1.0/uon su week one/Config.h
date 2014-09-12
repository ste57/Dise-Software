//
//  Config.h
//  UoN SU Week One
//
//  Created by Stephen Sowole on 15/08/2014.
//  Copyright (c) 2014 Stephen Sowole. All rights reserved.
//

#define VERSION @"Version : 1.1.0"

#define WEEK_ONE_EVENTS_TITLE @"Week One Events"
#define EVENT_MONTH @"September"
#define MONTH @"09"
#define YEAR @"2014"

// INFO TAB

#define INFO_CATEGORIES [NSArray arrayWithObjects:@"University Map", @"Hopper Bus Timetable", @"Important Contacts", @"About UoNSU", @"Send Feedback", @"Created by UoN Students", nil]

#define MAPS [NSArray arrayWithObjects:@"University Park Campus", @"Jubilee Campus", @"Sutton Bonington Campus", nil]

#define UONSU_DESC @"The Students’ Union is a registered charity led by students for students. Although we often work together we’re completely separate from the University, and whether you’re after activities, representation, volunteering opportunities, employability, a place to hang out or just an ice-cold post-lecture pint."

#define CREDITS @"This app is brought to you by DiSE, a software development and consultancy company formed by our very own UoN computer science students, specialising in mobile applications. If you have any enquiries or if you would like to work with us, feel free to contact me :) stephensowole@hotmail.co.uk\n\nIf you're interested in programming, app design or technology check out @hacksoc, Nottingham's highly regarded tech society."

#define BUSES [NSArray arrayWithObjects:@"Jubilee", @"Sutton Bonington", @"King's Meadow", @"Royal Derby Hospital Centre", nil]

#define HOPPER_API_HEADERS  [NSArray arrayWithObjects:@"termTimes_Day", @"Saturdays", @"outofTermTimes", nil]

#define HOPPER_TABLE_HEIGHT 80
#define HOPPER_TABLE_HEIGHT_EXP 160

// TWITTER FEED TAB

#define TWITTER_ACCOUNT_KEY @"B4VPpnbx7Uz7S61XNsS316qxC"
#define TWITTER_ACCOUNT_SECRET @"skIOIJMZLrkBfJKIDL4CR6PjyoTYAHMEBb7KolzbszQ7FtBHcR"

#define TWITTER_ACCOUNT @"UoNFreshers"

#define TWITTER_LOADING_TEXT @"Retrieving Tweets..."

#define TWITTER_FEED_LOADING_FONT_SIZE 13.5

// EVENTS TAB

#define CAT_ICON_SEPARATION 3.65
#define CAT_ICON_WIDTH 4.9
#define CAT_ICON_PADDING 8.0

#define FIRST_NOTIFICATION_TIME_HOURS 1
#define FIRST_NOTIFICATION_TEXT @" is about to start"

#define SECOND_NOTIFICATION_TIME_HOURS 24
#define SECOND_NOTIFICATION_TEXT @" - 1 day to go!"


#define ATTENDING_EVENTS @"AttendingEvents"

#define CATEGORY_CIRCLE_RADIUS 26.0
#define CATEGORY_TITLE_FONT_SIZE 10.0

#define SET_REMINDER @"+ Remind Me      "
#define REMINDER_SET @"- Reminder Set "

#define BUTTON_FONT @"Primer"

#define WEBSITE_ICON_IMG @"WebsiteIcon"

#define DATA_ARRAY @"dataArray"

#define SEPARATOR_IMG @"Separator"
#define SEPARATOR_PADDING_SIZE 10

#define EVENTS_CELL_HEIGHT 120.0
#define SCROLL_VIEW_HEIGHT 66.0

#define EVENT_DATE_BUTTON_RADIUS 40.0
#define EVENT_DATE_BUTTON_BORDER_WIDTH 2.0
#define EVENT_DATE_BUTTON_SPACING 15.0

#define EVENT_LOADING_TEXT @"Downloading events..."

#define EVENT_DATES [NSArray arrayWithObjects:@"21", @"22", @"23", @"24", @"25", @"26", @"27", @"28", nil]

#define EVENTS_FEED_URL_ARRAY [NSArray arrayWithObjects:@"http://www.welcometonottingham2014.co.uk/category/sunday-21st/feed/", @"http://www.welcometonottingham2014.co.uk/category/monday-22nd/feed/", @"http://www.welcometonottingham2014.co.uk/category/tuesday-23rd/feed/", @"http://www.welcometonottingham2014.co.uk/category/wednesday-24th/feed/", @"http://www.welcometonottingham2014.co.uk/category/thursday-25th/feed/", @"http://www.welcometonottingham2014.co.uk/category/friday-26th/feed/", @"http://www.welcometonottingham2014.co.uk/category/saturday-27th/feed/", @"http://www.welcometonottingham2014.co.uk/category/sunday-28th/feed/", nil]

// xml feed
#define ITEM_XML_BRACKET @"item"
#define XML_TITLE @"title"
#define XML_LINK @"link"
#define XML_DESCRIPTION @"content:encoded"
#define XML_CATEGORY @"category"


// MAIN SYSTEM SETTINGS

#define EVENTS @"Events"
#define TWITTER @"Feed"
#define TWITTER_NAV_TITLE @"UoN Freshers"
#define INFO @"Info"
#define INFO_NAV_TITLE @"Information"

#define EVENTS_IMG @"EventsTabIcon"
#define TWITTER_IMG @"TwitterTabIcon"
#define INFO_IMG @"InfoTabIcon"

#define LOADING_VIEW_RADIUS 120
#define LOADING_VIEW_MINIMUM_FONT_SIZE 0.70
#define LOAD_VIEW_TIMEOUT 30
#define LOADING_FAIL @"Unable to retrieve data.\nPlease try again later."


// COLOUR/TRANSPARENCY SETTINGS

#define MAIN_COLOUR [UIColor colorWithRed:0.07 green:0.13 blue:0.18 alpha:1.0]

#define MAIN_COLOUR_2 [UIColor whiteColor]



#define NAV_BAR_COLOUR       MAIN_COLOUR

#define NAV_BAR_TRANSLUCENT YES



#define REMIND_ME_COLOUR      MAIN_COLOUR

#define REMINDER_TAG_COLOUR     [UIColor colorWithRed:0.40 green:0.40 blue:0.47 alpha:1.0]



#define EVENT_TITLE_LABEL_COLOUR [UIColor blackColor]

#define EVENT_INITIALS_LABEL_COLOUR [UIColor whiteColor]

#define EVENT_TIME_LABEL_COLOUR    MAIN_COLOUR_TONE_DOWN



#define TABLEVIEW_BACKGROUND_IMG @"TableViewBackground"



#define MAIN_COLOUR_TONE_DOWN     [UIColor colorWithRed:0.22 green:0.30 blue:0.44 alpha:1.0]



#define SCROLL_VIEW_BACKGROUND_COLOUR       [UIColor whiteColor]




#define TABS_TINT_COLOUR         MAIN_COLOUR

#define TAB_BAR_ALPHA 1.0

#define TAB_BAR_TRANSLUCENT YES

#define ICON_SELECT_COLOUR       [UIColor colorWithRed:0.94 green:0.89 blue:0.55 alpha:1.0]




#define EVENT_DATE_BUTTON_TEXT_COLOUR       MAIN_COLOUR


#define EVENT_DATE_BUTTON_BACKGROUND_COLOUR       SCROLL_VIEW_BACKGROUND_COLOUR

#define EVENT_DATE_BUTTON_BACKGROUND_COLOUR_SELECTED       [UIColor colorWithRed:0.40 green:0.40 blue:0.47 alpha:1.0]



#define EVENTS_TABLE_BACKGROUND_COLOUR       [UIColor clearColor]

#define EVENTS_TABLE_CELL_COLOUR        MAIN_COLOUR_2





