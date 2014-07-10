//
//  Config.h
//  NEFS
//
//  Created by Stephen Sowole on 24/06/2014.
//  Copyright (c) 2014 Stephen Sowole. All rights reserved.
//

// EVENTS TAB

#define CELL_HEIGHT 120//80
#define EVENTS_URL @"http://nefs.herokuapp.com/eventlist"
#define EVENTS_API_HEADER @"Events"
#define SECTION_HEADER_DATE_FORMAT @"d MMM yyyy"//@"EEEE, d MMM";
#define ATTENDING_EVENTS @"eventsAttending"
#define NO_EVENTS_TEXT @"No Upcoming Events"

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


/*#ifdef __IPHONE_6_0 // iOS6 and later
#   define UITextAlignmentCenter    NSTextAlignmentCenter
#   define UITextAlignmentLeft      NSTextAlignmentLeft
#   define UITextAlignmentRight     NSTextAlignmentRight
#   define UILineBreakModeTailTruncation     NSLineBreakByTruncatingTail
#   define UILineBreakModeMiddleTruncation   NSLineBreakByTruncatingMiddle
#endif*/

