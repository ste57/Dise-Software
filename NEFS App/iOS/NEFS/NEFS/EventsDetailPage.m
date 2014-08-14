//
//  EventsDetailPage.m
//  NEFS
//
//  Created by Stephen Sowole on 26/06/2014.
//  Copyright (c) 2014 Stephen Sowole. All rights reserved.
//

#import "EventsDetailPage.h"

@implementation EventsDetailPage {
    
    UILabel *dateLabel;
    UITextView *descriptionView;
    UIButton *siteButton, *attendButton;
    UIActivityIndicatorView *loadIndicator;
    NSMutableArray *eventsAttending;
    
    UIImageView *icon;
}

@synthesize event,eId;

- (void) viewDidLoad {
    
    [super viewDidLoad];
    
    [self removeBackButtonText];
    
    [self retrieveAttendingEvents];
    
    [self createDisplay];
}

- (void) removeBackButtonText {
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backButtonItem];
}

- (void) retrieveAttendingEvents {
    
    eventsAttending = [[NSMutableArray alloc] init];
    
    NSMutableArray *tempArray = (NSMutableArray *)[[NSUserDefaults standardUserDefaults] objectForKey:ATTENDING_EVENTS];
    
    for (NSString *_id in tempArray) {
        
        [eventsAttending addObject:_id];
    }
}

- (void) createDateLabel {
    
    dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(15.0, EVENT_DATE_HEIGHT, 290.0, 45.0)];
    dateLabel.textAlignment = NSTextAlignmentLeft;
    dateLabel.textColor = [UIColor darkGrayColor];
    dateLabel.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:DATE_FONT_SIZE];
    
    [self.view addSubview:dateLabel];
}

- (void) createSiteButton {
    
    siteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [siteButton addTarget:self action:@selector(goToMainSite)
         forControlEvents:UIControlEventTouchUpInside];
    
    siteButton.frame = CGRectMake(0, 0, 140.0, 40.0);
    siteButton.center = CGPointMake((self.view.bounds.size.width/3.8) * 2.8, self.view.bounds.size.height - 90.0);
    
    [siteButton setTitle:@"Visit Website" forState:UIControlStateNormal];
    [siteButton setTitle:@"Visit Website" forState:UIControlStateSelected];
    
    siteButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
    
    [siteButton setTitle:@"Visit Website" forState:UIControlStateHighlighted];
    [siteButton setTitle:@"Visit Website" forState:UIControlStateSelected | UIControlStateHighlighted];

    [siteButton setBackgroundImage:[UIImage imageNamed:@"EventButton"] forState:UIControlStateNormal];
    [siteButton setBackgroundImage:[UIImage imageNamed:@"EventButtonSelect"] forState:UIControlStateSelected];
    [siteButton setBackgroundImage:[UIImage imageNamed:@"EventButtonHighlight"] forState:UIControlStateHighlighted];
    
    [siteButton setBackgroundImage:[UIImage imageNamed:@"EventButtonHighlight"] forState:UIControlStateSelected | UIControlStateHighlighted];
    
    [siteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [siteButton setTitleColor:[UIColor grayColor] forState:UIControlStateSelected];
    [siteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [siteButton setTitleColor:[UIColor grayColor] forState:UIControlStateSelected | UIControlStateHighlighted];
    
    siteButton.backgroundColor = [UIColor clearColor];
    siteButton.tintColor = [UIColor clearColor];
    
    [self.view addSubview:siteButton];
}

- (void) createAttendButton {
    
    attendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [attendButton addTarget:self action:@selector(attend)
     forControlEvents:UIControlEventTouchUpInside];
    
    [attendButton setTitle:UNATTEND_STRING forState:UIControlStateNormal];
    [attendButton setTitle:ATTEND_STRING forState:UIControlStateSelected];
    
    attendButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
    
    [attendButton setTitle:UNATTEND_STRING forState:UIControlStateHighlighted];
    [attendButton setTitle:ATTEND_STRING forState:UIControlStateSelected | UIControlStateHighlighted];
    
    attendButton.frame = CGRectMake(0, 0, 140.0, 40.0);
    attendButton.center = CGPointMake(self.view.bounds.size.width/3.8, self.view.bounds.size.height - 90.0);
    
    [attendButton setBackgroundImage:[UIImage imageNamed:@"EventButton"] forState:UIControlStateNormal];
    [attendButton setBackgroundImage:[UIImage imageNamed:@"EventButtonSelect"] forState:UIControlStateSelected];
    [attendButton setBackgroundImage:[UIImage imageNamed:@"EventButtonHighlight"] forState:UIControlStateHighlighted];
    
    [attendButton setBackgroundImage:[UIImage imageNamed:@"EventButtonHighlight"] forState:UIControlStateSelected | UIControlStateHighlighted];
    
    [attendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [attendButton setTitleColor:[UIColor grayColor] forState:UIControlStateSelected];
    [attendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [attendButton setTitleColor:[UIColor grayColor] forState:UIControlStateSelected | UIControlStateHighlighted];
    
    attendButton.backgroundColor = [UIColor clearColor];
    attendButton.tintColor = [UIColor clearColor];
    
    [self.view addSubview:attendButton];
}

- (void) attend {
    
    if (attendButton.selected) {
        
        [attendButton setSelected:NO];
        [eventsAttending removeObject:eId];
        [self localNotification:NO];
    
    } else {
    
        [attendButton setSelected:YES];
        [eventsAttending addObject:eId];
        [self localNotification:YES];
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:eventsAttending forKey:ATTENDING_EVENTS];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void) localNotification:(BOOL)addNotification {

    [self addTimeForNotification:(FIRST_NOTIFICATION_TIME_HOURS*3600) :[NSString stringWithFormat:@"%@%@%@",event.eTitle, FIRST_NOTIFICATION_TEXT, event.eStart] :addNotification];
    
    [self addTimeForNotification:(SECOND_NOTIFICATION_TIME_HOURS*3600) :[NSString stringWithFormat:@"%@%@",event.eTitle, SECOND_NOTIFICATION_TEXT] :addNotification];
}

- (void) addTimeForNotification:(double)time :(NSString*)text :(BOOL)addNotification {

    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd hh:mm a"];

    NSDate *date = [dateFormat dateFromString:[NSString stringWithFormat:@"%@ %@", event.eDate ,event.eStart]];

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

- (void) createDescription {

    descriptionView = [[UITextView alloc] initWithFrame:CGRectMake(10.0, 145.0, 300.0, siteButton.center.y - 185)];
    
    [self.view addSubview:descriptionView];

    descriptionView.textAlignment = NSTextAlignmentLeft;

    descriptionView.font = [UIFont fontWithName:@"TrebuchetMS" size:DESCRIPTION_FONT_SIZE];
    
    descriptionView.textColor = [UIColor grayColor];
    
    descriptionView.editable = NO;
}

- (void) addEventTypeLabel {
    
    CGRect frame;
    
    icon = [[UIImageView alloc] init];
    frame = CGRectMake(15.0, EVENT_TYPE_HEIGHT, EVENT_TYPE_WIDTH, 25);
    
    UIImage *image = [UIImage imageNamed:MAIN_EVENT_TYPE_ICON];
    
    CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClipToMask(context, rect, image.CGImage);
    CGContextSetFillColorWithColor(context, [[event getIconColour] CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImage *flippedImage = [UIImage imageWithCGImage:img.CGImage
                                                scale:1.0 orientation: UIImageOrientationDownMirrored];
    
    icon.image = flippedImage;
    icon.frame = frame;
    
    [self.view addSubview:icon];
    
    
    
    UILabel *eventTypeLabel = [[UILabel alloc] init];
    eventTypeLabel.textAlignment = NSTextAlignmentCenter;
    eventTypeLabel.font = [UIFont systemFontOfSize:12];
    eventTypeLabel.textColor = [UIColor whiteColor];
    eventTypeLabel.text = event.eEvent;
    
    [self.view addSubview:eventTypeLabel];
    
    frame = CGRectMake(icon.frame.origin.x, icon.frame.origin.y, EVENT_TYPE_WIDTH, 25);
    eventTypeLabel.frame = frame;
}

- (void) createDisplay {
    
    [self createDateLabel];
    
    [self createSiteButton];
    
    [self createAttendButton];
    
    [self createDescription];
}

- (void) goToMainSite {
    
    CustomWebView *web = [[CustomWebView alloc] init];
    
    [self.navigationController pushViewController:web animated:YES];
    
    web.title = event.eTitle;
    
    web.websiteLink = event.eLink;
    
    [web loadWebsite];
}

- (void) createTextData {
    
    [self createNavigationBarTitle];

    eId = event._id;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-d"];

    NSDate *date = [dateFormat dateFromString:event.eDate];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"EEEE, d MMM";
    
    dateLabel.text = [NSString stringWithFormat:@"%@ @ %@ - %@",[formatter stringFromDate:date], event.eStart, event.eEnd];
    
    
    descriptionView.text = event.eDesc;
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    paragraphStyle.lineSpacing = LINE_SPACING;
    
    NSString *string = descriptionView.text;
    
    NSDictionary *ats = @{
                          NSFontAttributeName : [UIFont fontWithName:@"AppleSDGothicNeo-Medium" size:DESCRIPTION_FONT_SIZE],
                          NSParagraphStyleAttributeName : paragraphStyle,
                          };
    
    descriptionView.attributedText = [[NSAttributedString alloc] initWithString:string attributes:ats];
    descriptionView.textColor = [UIColor darkGrayColor];
    
    
    
    [self checkIfEventIsBeingAttended];
    
    if ([event.eLink isEqualToString:@""]) {
        
        siteButton.highlighted = YES;
        siteButton.enabled = NO;
    }
    
    [self addEventTypeLabel];
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

- (void) checkIfEventIsBeingAttended {
    
    if ([eventsAttending containsObject:eId]) {
        
        attendButton.selected = YES;
    }
}

@end
