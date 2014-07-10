//
//  CustomTableViewCell.m
//  NEFS
//
//  Created by Stephen Sowole on 24/06/2014.
//  Copyright (c) 2014 Stephen Sowole. All rights reserved.
//

#import "EventsCustomTVCell.h"
#import "Config.h"

#define TITLE_SIZE 15
#define TIME_SIZE 12
#define GOING_SIZE 12
#define MONTH_SIZE 17
#define DATE_SIZE 37

#define RIGHT_SHIFT 90
#define DATE_SHIFT 15

#define EVENT_TYPE_HEIGHT 75

#define EVENT_TYPE_WIDTH 100

#define SEPERATOR_HEIGHT 9

@implementation EventsCustomTVCell {
    
    UILabel *titleLabel;
    UILabel *timeLabel;
    UILabel *eventTypeLabel;
    UILabel *monthLabel;
    UILabel *dateLabel;
    
    UIImageView *icon;
    UIImageView *attendIcon;
    
    NSMutableArray *eventsAttending;
}

@synthesize event,eId;

- (id) initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier]) {
        
        [self retrieveAttendingEvents];
        
        titleLabel = [[UILabel alloc]init];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.font = [UIFont systemFontOfSize:TITLE_SIZE];
        
        timeLabel = [[UILabel alloc]init];
        timeLabel.textAlignment = NSTextAlignmentLeft;
        timeLabel.font = [UIFont systemFontOfSize:TIME_SIZE];
        timeLabel.textColor = [UIColor grayColor];
        
        monthLabel = [[UILabel alloc] init];
        monthLabel.textAlignment = NSTextAlignmentCenter;
        monthLabel.font = [UIFont systemFontOfSize:MONTH_SIZE];
        monthLabel.textColor = [UIColor grayColor];
        
        dateLabel = [[UILabel alloc] init];
        dateLabel.textAlignment = NSTextAlignmentCenter;
        dateLabel.font = [UIFont systemFontOfSize:DATE_SIZE];
    
        icon = [[UIImageView alloc] init];
        attendIcon = [[UIImageView alloc] init];
        
        eventTypeLabel = [[UILabel alloc] init];
        eventTypeLabel.textAlignment = NSTextAlignmentCenter;
        eventTypeLabel.font = [UIFont systemFontOfSize:GOING_SIZE];
        eventTypeLabel.textColor = [UIColor whiteColor];

        [self.contentView addSubview:icon];
        [self.contentView addSubview:titleLabel];
        [self.contentView addSubview:timeLabel];
        [self.contentView addSubview:monthLabel];
        [self.contentView addSubview:dateLabel];
        [self.contentView addSubview:eventTypeLabel];
        [self.contentView addSubview:attendIcon];
        
        [self setSeperators];
    }
    return self;
}

- (void) setSeperators {
    
    UIImageView *seperator;
    CGRect frame;
    
    seperator = [[UIImageView alloc] init];
    seperator.image = [UIImage imageNamed:@"Seperator"];

    frame = CGRectMake(0, CELL_HEIGHT, 320, SEPERATOR_HEIGHT);
    seperator.frame = frame;
    
    [self.contentView addSubview:seperator];
    
    
    seperator = [[UIImageView alloc] init];
    seperator.image = [UIImage imageNamed:@"Seperator"];
    
    frame = CGRectMake(0, 0, 320, SEPERATOR_HEIGHT);
    seperator.frame = frame;
    
    [self.contentView addSubview:seperator];
    
    
    seperator = [[UIImageView alloc] init];
    seperator.image = [UIImage imageNamed:@"Seperator"];
    
    frame = CGRectMake(0, 0, SEPERATOR_HEIGHT, CELL_HEIGHT);
    seperator.frame = frame;
    
    [self.contentView addSubview:seperator];
    
    
    seperator = [[UIImageView alloc] init];
    seperator.image = [UIImage imageNamed:@"Seperator"];
    
    frame = CGRectMake(320-SEPERATOR_HEIGHT, 0, SEPERATOR_HEIGHT, CELL_HEIGHT);
    seperator.frame = frame;
    
    [self.contentView addSubview:seperator];
    
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = [UIColor colorWithRed:220.0/250.0 green:220.0/250.0 blue:220.0/250.0 alpha:1.0];
    
    [self setSelectedBackgroundView: bgColorView];
}

- (void) retrieveAttendingEvents {
    
    eventsAttending = [[NSMutableArray alloc] init];
    
    NSMutableArray *tempArray = (NSMutableArray *)[[NSUserDefaults standardUserDefaults] objectForKey:ATTENDING_EVENTS];
    
    for (NSString *_id in tempArray) {
        
        [eventsAttending addObject:_id];
    }
}

- (void) checkIfEventIsBeingAttended {

    if ([eventsAttending containsObject:eId]) {
        
        attendIcon.hidden = NO;
        
    } else {
        
        attendIcon.hidden = YES;
    }
}

- (void) createTextData {
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-d"];
    
    NSDate *date = [dateFormat dateFromString:event.eDate];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    eId = event._id;
    titleLabel.text = event.eTitle;
    timeLabel.text = [NSString stringWithFormat:@"%@ - %@", event.eStart, event.eEnd];
    
    formatter.dateFormat = @"MMM";
    monthLabel.text = [formatter stringFromDate:date];

    formatter.dateFormat = @"dd";
    dateLabel.text = [formatter stringFromDate:date];
    
    eventTypeLabel.text = event.eEvent;
    
    [self setImageColour];
    
    [self setAttendIconColour];
    
    [self checkIfEventIsBeingAttended];
}

- (void) setImageColour {
    
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
}

- (void) setAttendIconColour {
    
    UIImage *image = [UIImage imageNamed:ATTEND_ICON];
    
    CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClipToMask(context, rect, image.CGImage);
    CGContextSetFillColorWithColor(context, [[UIColor colorWithRed:(TAB_COLOUR_R+20)/255.0 green:(TAB_COLOUR_G+20)/255.0 blue:(TAB_COLOUR_B+20)/255.0 alpha:1.0] CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImage *flippedImage = [UIImage imageWithCGImage:img.CGImage
                                                scale:1.0 orientation: UIImageOrientationDownMirrored];
    
    attendIcon.image = flippedImage;
}

- (void) layoutSubviews {
    
    [super layoutSubviews];
    
    CGRect contentRect = self.contentView.bounds;
    CGFloat boundsX = contentRect.origin.x;
    CGRect frame;
    
    //x,y,width,height
    
    frame = CGRectMake(boundsX + RIGHT_SHIFT, 20, 200, 25);
    titleLabel.frame = frame;
    
    frame = CGRectMake(boundsX + RIGHT_SHIFT, 45, 180, 25);
    timeLabel.frame = frame;
    
    frame = CGRectMake(boundsX + RIGHT_SHIFT, EVENT_TYPE_HEIGHT, EVENT_TYPE_WIDTH, 25);
    eventTypeLabel.frame = frame;
    
    frame = CGRectMake(boundsX + DATE_SHIFT, 25, 60, 25);
    monthLabel.frame = frame;
    
    frame = CGRectMake(boundsX + DATE_SHIFT, 55, 60, 40);
    dateLabel.frame = frame;
    
    frame = CGRectMake(boundsX + RIGHT_SHIFT, EVENT_TYPE_HEIGHT, EVENT_TYPE_WIDTH, 25);
    icon.frame = frame;
    
    frame = CGRectMake(boundsX + 280, (CELL_HEIGHT/2), 8, 8);
    attendIcon.frame = frame;
}

@end
