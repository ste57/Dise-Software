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

#define INFO_URL @"http://nefs.herokuapp.com/v1/api/infolist"
#define INFO_API_HEADER @"Info"

#define INFO_CATEGORIES [NSArray arrayWithObjects:@"Sponsors", @"Finance Societies", @"About NEFS", @"Send Feedback", VERSION ,nil]
#define FINANCE_SOCIETIES [NSArray arrayWithObjects:@"Corporate Finance", @"Equity Fund", @"Research", @"Women In Finance" ,nil]
#define SPONSOR_TYPES [NSArray arrayWithObjects:@"Platinum", @"Gold", @"Silver", @"Bronze", nil]

#define INFO_ROW_HEIGHT 60.0

// SPORTS TAB

#define SPORTS_URL @"http://nefs.herokuapp.com/v1/api/sportslist"
#define SPORTS_API_HEADER @"Sports"
#define SPORTS_CELL_HEIGHT 140

// NEWS TAB

#define NEWS_URL @"http://nefs.herokuapp.com/v1/api/newslist"
#define NEWS_API_HEADER @"News"
#define NO_NEWS_TEXT @"No Internet Connection"
#define SWIPE_TO_RETRY @"Swipe Down To Retry"
#define NEWS_ROW_HEIGHT 140.0
#define NEWS_ARTICLES @"NewsArticles"

// EVENTS TAB

#define EVENTS_CELL_HEIGHT 120
#define EVENTS_URL @"http://nefs.herokuapp.com/v1/api/eventlist"
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
#define OTHER_API_NAME @"Other"
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

#define ABOUT_NEFS_DESCRIPTION @"As a society we have three main aims and values to help maximise our members experience. These values are represented through all the activities we undertake.\n\nYour Interests. Your Career. Your Friends and Network.\n\nWith over 40 years of experience and a membership base in excess of 3,000 students we are the University of Nottingham’s leading Society."

#define COORP_FINANCE_DESC @"This division is tailored to aspiring investment bankers. Through weekly sessions, you will receive extensive training on how to pass the application process. This will range from CV and cover letter clinics to psychometric test practice and technical theory, not forgetting the M&A case studies and mock interviews. An emphasis will be placed on expanding your knowledge of both the sector and the career.\n\nIf you have any questions please email: Anomitro Ash at  aash@nefs.org.uk "

#define EQUITY_FUND_DESC @"The Equity Fund is a chance for students to gain real-world market experience. If selected for the team, you will become an analyst covering one of eight sectors where research will guide equity portfolio selection. These sectors include: Energy, Financials, Free Investments, Industrials, Pharmaceuticals, Retail, Small Cap and Technology. You have the chance to invest and make your own money if selected!\n\nIf you have any questions please email: Alexander John Fitzgerald at afitzgerald@nefs.org.uk"

#define RESEARCH_DESC @"The Research Division produces a weekly wrap of the global macro and financial markets, which you could help write! You'll have a particular focus, and be coached on how to research and write effectively. There are also exclusive socials and privileges from being involved!\n\nIf you have any questions please email: Josh Martin at jmartin@nefs.org.uk"

#define WOMEN_IN_FINANCE_DESC @"Our division aims to inform and educate our members about what it's like to work within the financial industry from a female perspective by holding a large number of events throughout the year. We aim to demystify any preconceptions about the financial industry and answer any questions you may have.\n\nIf you have any questions please email: Vicky James at vjames@nefs.org.uk  Alexis Owuadey at aowuadey@nefs.org.uk"

