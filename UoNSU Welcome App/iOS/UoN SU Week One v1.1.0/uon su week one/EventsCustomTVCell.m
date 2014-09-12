//
//  CustomTableViewCell.m
//  NEFS
//
//  Created by Stephen Sowole on 24/06/2014.
//  Copyright (c) 2014 Stephen Sowole. All rights reserved.
//

#import "EventsCustomTVCell.h"
#import "Config.h"

#define REMINDER_ICON_SIZE 18.0f

#define TITLE_SIZE 20.0
#define TITLE_FONT @"Primer"

#define TIME_SIZE 12.0
#define TIME_FONT @"Mockup"

#define DESCRIPTION_SIZE 13.0

#define PADDING 15.0

#define CIRCLE_SPACING 25.0

@implementation EventsCustomTVCell {
    
    UILabel *titleLabel, *timeLabel;
}

@synthesize event;

- (id) initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = EVENTS_TABLE_CELL_COLOUR;
        
        titleLabel = [[UILabel alloc] init];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.textColor = EVENT_TITLE_LABEL_COLOUR;
        titleLabel.font = [UIFont fontWithName:TITLE_FONT size:TITLE_SIZE];
        
        timeLabel = [[UILabel alloc] init];
        timeLabel.textAlignment = NSTextAlignmentLeft;
        timeLabel.textColor = EVENT_TIME_LABEL_COLOUR;
        timeLabel.font = [UIFont fontWithName:TIME_FONT size:TIME_SIZE];
        
        [self.contentView addSubview:titleLabel];
        [self.contentView addSubview:timeLabel];
    }
    
    return self;
}

- (void) addReminderLabel {

    if ([[[NSUserDefaults standardUserDefaults] objectForKey:ATTENDING_EVENTS] containsObject:event._id]) {
        
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathMoveToPoint(path,NULL,0.0,0.0);
        CGPathAddLineToPoint(path, NULL, REMINDER_ICON_SIZE, 0.0f);
        CGPathAddLineToPoint(path, NULL, 0.0f, REMINDER_ICON_SIZE);
        
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        [shapeLayer setPath:path];
        [shapeLayer setFillColor:[REMINDER_TAG_COLOUR CGColor]];
        [shapeLayer setBounds:CGRectMake(0.0f, 0.0f, REMINDER_ICON_SIZE, REMINDER_ICON_SIZE)];
        [shapeLayer setAnchorPoint:CGPointMake(0.0f, 0.0f)];
        
        [self.layer addSublayer:shapeLayer];
        CGPathRelease(path);
    }
}

- (void) addCategoryImages {
    
    UIView *circle;
    
    int count = 0;
    
    for (NSString *category in event.categories) {
        
        circle = [[UIView alloc] initWithFrame:CGRectMake(CIRCLE_SPACING*count + PADDING*(count+1), self.frame.size.height * 2.0, CATEGORY_CIRCLE_RADIUS, CATEGORY_CIRCLE_RADIUS)];
        circle.layer.cornerRadius = CATEGORY_CIRCLE_RADIUS/2;
        
        if (!(circle.backgroundColor = [event getCategoryColour:category]))
            continue;
        
        [self.contentView addSubview:circle];
        
        UILabel * initials = [[UILabel alloc] init];
        
        if (!(initials.text = [event getCategoryShortName:category]))
            continue;
        
        initials.textColor = EVENT_INITIALS_LABEL_COLOUR;
        
        initials.textAlignment = NSTextAlignmentCenter;
        
        initials.frame = CGRectMake(0, 0, CATEGORY_CIRCLE_RADIUS, CATEGORY_CIRCLE_RADIUS);
        
        initials.font = [UIFont fontWithName:TIME_FONT size:CATEGORY_TITLE_FONT_SIZE];
        
        [circle addSubview:initials];
        
        count++;
    }
}

- (void)setFrame:(CGRect)frame {
    
    frame.origin.x += SEPARATOR_PADDING_SIZE;
    
    frame.size.width -= 2 * SEPARATOR_PADDING_SIZE;
    
    frame.origin.y += SEPARATOR_PADDING_SIZE;
    
    frame.size.height -= SEPARATOR_PADDING_SIZE;
    
    [super setFrame:frame];
}

- (void) layoutSubviews {
    
    [super layoutSubviews];
    
    CGRect frame;
    
    //x,y,width,height
    
    frame = CGRectMake(PADDING, self.frame.size.height * 0.1, self.frame.size.width - PADDING*2, 25);
    titleLabel.frame = frame;
    
    frame = CGRectMake(PADDING, self.frame.size.height * 0.33, self.frame.size.width - PADDING*2, 25);
    timeLabel.frame = frame;
}

- (void) createTextData {
    
    titleLabel.text = event.title;
    timeLabel.text = [NSString stringWithFormat:@"%@ : %@", event.time, [event.location stringByReplacingOccurrencesOfString:@"Location:" withString:@""]];
    
    [self addCategoryImages];
    
    [self addReminderLabel];
}

@end
