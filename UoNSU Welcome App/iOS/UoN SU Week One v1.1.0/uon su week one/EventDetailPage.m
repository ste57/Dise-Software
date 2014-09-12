//
//  EventDetailPage.m
//  UoN SU Week One
//
//  Created by Stephen Sowole on 19/08/2014.
//  Copyright (c) 2014 Stephen Sowole. All rights reserved.
//

#import "EventDetailPage.h"

#define PADDING 10.0

#define DESCRIPTION_SIZE 14.0
#define TIME_SIZE 14.0
#define TIME_FONT @"Mockup"

#define REMIND_BUTTON_FONT @"Mockup"
#define REMIND_BUTTON_SIZE 16.0

#define CIRCLE_SPACING 34.0

@implementation EventDetailPage {
    
    UIScrollView *scrollView;
    
    UITextView *descriptionView;
    
    UILabel *locationLabel, *timeLabel;
    
    NSMutableArray *eventsAttending;
}

@synthesize event;

- (void) viewDidLoad {
    
    [super viewDidLoad];
    
    [self retrieveAttendingEvents];
    
    [self removeBackButtonText];
    
    [self createDisplay];
}

- (void) retrieveAttendingEvents {
    
    eventsAttending = [[NSMutableArray alloc] init];
    
    NSMutableArray *tempArray = (NSMutableArray *)[[NSUserDefaults standardUserDefaults] objectForKey:ATTENDING_EVENTS];
    
    for (NSString *_id in tempArray) {
        
        [eventsAttending addObject:_id];
    }
}

- (void) removeBackButtonText {
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backButtonItem];
}

- (void) createDisplay {
    
    [self createSiteButton];
    
    [self createDescription];
}

- (void) createDescription {
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    [self.view setBackgroundColor:MAIN_COLOUR_2];
    
    [self.view addSubview:scrollView];
    
    [self createTimeLabel];
}

- (void) setDescription {
    
    descriptionView = [[UITextView alloc] initWithFrame:CGRectMake(PADDING, 0, self.view.frame.size.width - PADDING*2, 20)];
    
    [scrollView addSubview:descriptionView];
    
    descriptionView.textAlignment = NSTextAlignmentCenter;
    
    descriptionView.editable = NO;
    
    descriptionView.textColor = [UIColor colorWithRed:0.45 green:0.45 blue:0.45 alpha:1.0];
    
    descriptionView.font = [UIFont fontWithName:TIME_FONT size:DESCRIPTION_SIZE];
    
    descriptionView.text = event.eventDesc;
    
    [descriptionView sizeToFit];
    
    [descriptionView layoutIfNeeded];
    
    descriptionView.scrollEnabled = NO;
    
    descriptionView.center = CGPointMake(self.view.frame.size.width/2, timeLabel.frame.size.height + 55);
    
    descriptionView.layer.anchorPoint = CGPointMake(0.5, 0);
}

- (void) createTimeLabel {
    
    timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(PADDING, 0, self.view.frame.size.width - PADDING*2, 10)];
    
    timeLabel.text = [NSString stringWithFormat:@"%@ %@ %@", event.date, EVENT_MONTH ,event.time];
    
    timeLabel.textColor = MAIN_COLOUR_TONE_DOWN;

    timeLabel.font = [UIFont fontWithName:TIME_FONT size:TIME_SIZE];
    
    timeLabel.numberOfLines = 10;
    
    [timeLabel layoutIfNeeded];
    
    [timeLabel sizeToFit];
    
    timeLabel.center = CGPointMake(self.view.frame.size.width/2, 55.0);
    
    timeLabel.layer.anchorPoint = CGPointMake(0.5, 0);
    
    timeLabel.textAlignment = NSTextAlignmentCenter;
    
    [scrollView addSubview:timeLabel];
}

- (void) setLocationLabel {
    
    locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(PADDING, 0, self.view.frame.size.width - PADDING*2, 20)];
    
    locationLabel.text = event.location;
    
    locationLabel.textColor = MAIN_COLOUR_TONE_DOWN;
    
    locationLabel.font = descriptionView.font;
    
    locationLabel.numberOfLines = 10;
    
    [locationLabel layoutIfNeeded];
    
    [locationLabel sizeToFit];
    
    locationLabel.center = CGPointMake(self.view.frame.size.width/2, descriptionView.frame.size.height + timeLabel.frame.size.height + 30);//55);
    
    locationLabel.layer.anchorPoint = CGPointMake(0.5, 0);

    locationLabel.textAlignment = NSTextAlignmentCenter;
    
    [scrollView addSubview:locationLabel];
}

- (void) setReminderButton {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    button.frame = CGRectMake(PADDING, 16.0, self.view.frame.size.width, 30);
    
    [button setTitle:SET_REMINDER forState:UIControlStateNormal];
    
    [button setTitle:REMINDER_SET forState:UIControlStateHighlighted];
    [button setTitle:REMINDER_SET forState:UIControlStateSelected];
    
    [button setTitleColor:REMIND_ME_COLOUR forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    
    button.titleLabel.font = [UIFont fontWithName:REMIND_BUTTON_FONT size:REMIND_BUTTON_SIZE];

    button.center = CGPointMake(self.view.frame.size.width/2, button.center.y);
    
    [scrollView addSubview:button];
    
    [button addTarget:self action:@selector(reminderButton:) forControlEvents:UIControlEventTouchUpInside];
    
    if ([eventsAttending containsObject:event._id]) {

        [self reminderButton:button];
    }
}

- (void) reminderButton:(UIButton*)button {
    
    if (button.selected) {
        
        [button setTintColor:[UIColor clearColor]];
        [button setSelected:NO];
        [self localNotification:NO];
        
        [eventsAttending removeObject:event._id];
   
    } else {
        
        [button setTintColor:REMINDER_TAG_COLOUR];
        [button setSelected:YES];
        [self localNotification:YES];
        
        if (![eventsAttending containsObject:event._id]) {
            
            [eventsAttending addObject:event._id];
        }
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:eventsAttending forKey:ATTENDING_EVENTS];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void) localNotification:(BOOL)addNotification {
    
    NSString *string = [event.title stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"		" withString:@""];
    
    if (![event.time isEqualToString:@""]) {
    
        [self addTimeForNotification:(FIRST_NOTIFICATION_TIME_HOURS*3600) :[NSString stringWithFormat:@"%@%@", string, FIRST_NOTIFICATION_TEXT] :addNotification];
    }
    
    [self addTimeForNotification:(SECOND_NOTIFICATION_TIME_HOURS*3600) :[NSString stringWithFormat:@"%@%@", string, SECOND_NOTIFICATION_TEXT] :addNotification];
}

- (void) addTimeForNotification:(double)time :(NSString*)text :(BOOL)addNotification {
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    
    [dateFormat setDateFormat:@"yyyy-MM-EEEE dd h:mma"];
    

    NSString *string = [[[event.time stringByReplacingOccurrencesOfString:@"-" withString:@" "] componentsSeparatedByString:@" "] objectAtIndex:0];
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    
    NSString *stringDate = [event.date substringToIndex:(event.date.length - 1) - (event.date.length > 0)];
    
    if (![dateFormat dateFromString:[NSString stringWithFormat:@"%@-%@-%@ %@", YEAR, MONTH , stringDate, string]]) {
     
        string = @"12:00pm";
    }
    
    string = [NSString stringWithFormat:@"%@-%@-%@ %@", YEAR, MONTH , stringDate, string];
    
    NSDate *date = [dateFormat dateFromString:string];
    
    
    if ([date timeIntervalSinceDate:[NSDate date]] > time) {
        
        UILocalNotification *notification = [[UILocalNotification alloc] init];
        
        notification.fireDate = [NSDate dateWithTimeInterval:-time sinceDate:date];
        
        notification.soundName = @"sound.caf";
        
        notification.alertBody = text;
        
        notification.applicationIconBadgeNumber = 1;
        
        if (addNotification) {
            
            [[UIApplication sharedApplication] scheduleLocalNotification:notification];
            
        } else {
            
            [[UIApplication sharedApplication] cancelLocalNotification:notification];
        }
    }
}

- (void) createSiteButton {

    if (![event.link isEqualToString:@""]) {
        
        UIBarButtonItem *webButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(goToMainSite)];
        [webButton setImage:[UIImage imageNamed:WEBSITE_ICON_IMG]];
        
        self.navigationItem.rightBarButtonItem = webButton;
    }
}

- (void) goToMainSite {

    CustomWebView *web = [[CustomWebView alloc] init];
    
    [self.navigationController pushViewController:web animated:YES];
    
    web.title = event.title;
    
    web.websiteLink = event.link;
    
    [web loadWebsite];
}

- (void) createTextData {
    
    self.title = event.title;
    
    [self setDescription];
    
    [self setLocationLabel];
    
    [self setCategoryIcons];
    
    [self setReminderButton];
    
    [self createNavigationBarTitle];
}

- (void) setCategoryIcons {
    
    float startPosition = locationLabel.frame.origin.y + locationLabel.frame.size.height + 20;
    
    UIView *circle = NULL;
    
    int count = 0;
    int alternate = 0;
    
    for (NSString *category in event.categories) {
        
        UILabel * initials = [[UILabel alloc] init];
        
        if (!(initials.text = [event getCategoryShortName:category]))
            continue;
        
        circle = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CATEGORY_CIRCLE_RADIUS*CAT_ICON_WIDTH, CATEGORY_CIRCLE_RADIUS)];
        
        circle.layer.cornerRadius = CATEGORY_CIRCLE_RADIUS/2;
        
        if (![locationLabel.text isEqualToString:@""]) {
            
            circle.center = CGPointMake(0, startPosition + CIRCLE_SPACING*count + CAT_ICON_PADDING*(count+1));
            
        } else {
            
            circle.center = CGPointMake(0, startPosition + 20 + CIRCLE_SPACING*count + CAT_ICON_PADDING*(count+1));
        }
        
        if (!(circle.backgroundColor = [event getCategoryColour:category]))
            continue;
        
        [scrollView addSubview:circle];
        
        switch (alternate % 2) {
                
            case 0:
                circle.center = CGPointMake(self.view.frame.size.width/CAT_ICON_SEPARATION, circle.center.y);
                break;
                
            case 1:
                circle.center = CGPointMake(self.view.frame.size.width/CAT_ICON_SEPARATION * (CAT_ICON_SEPARATION-1), circle.center.y);
                count++;
                break;
        }

        alternate++;
    
        initials.textColor = [UIColor whiteColor];
        
        initials.text = category;
        
        initials.textAlignment = NSTextAlignmentCenter;
        
        initials.frame = CGRectMake(0, 0, CATEGORY_CIRCLE_RADIUS*CAT_ICON_WIDTH, CATEGORY_CIRCLE_RADIUS);
        
        initials.font = descriptionView.font;
        
        [circle addSubview:initials];
    }
    
    if (alternate % 2 == 1) {

        circle.center = CGPointMake(self.view.frame.size.width/2, circle.center.y);
    }
    
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width, circle.center.y + CIRCLE_SPACING);
}

- (void) createNavigationBarTitle {
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 40)];
    label.text = self.navigationItem.title;
    
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont boldSystemFontOfSize:17];
    label.backgroundColor = [UIColor clearColor];
    
    label.adjustsFontSizeToFitWidth = YES;
    label.minimumScaleFactor = 0.7;
    
    label.textAlignment = NSTextAlignmentCenter;
    
    self.navigationItem.titleView = label;
}

@end
