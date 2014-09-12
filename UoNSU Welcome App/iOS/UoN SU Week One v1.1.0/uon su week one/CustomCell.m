//
//  CustomCell.m
//  HopperBus
//
//  Created by sxs02u on 01/09/2014.
//  Copyright (c) 2014 sxs02u. All rights reserved.
//

#import "CustomCell.h"

#define CELL_FONT @"GillSans"
#define CELL_FONT_SIZE 16.0

@implementation CustomCell {
    
    int catIcons;
    
    UIView *mainSection, *expandedSection;
    
    NSArray *termTimes, *saturdayTimes, *outofTermTimes;
    
    BOOL summaryTimesDisplayed;
}

@synthesize busStops, delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        mainSection = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, HOPPER_TABLE_HEIGHT)];
        [mainSection setBackgroundColor:[UIColor whiteColor]];
        [self.contentView addSubview:mainSection];
        
        expandedSection = [[UIView alloc] initWithFrame:CGRectMake(0, HOPPER_TABLE_HEIGHT, self.frame.size.width, HOPPER_TABLE_HEIGHT_EXP - HOPPER_TABLE_HEIGHT)];
        [self.contentView addSubview:expandedSection];
        
        [self addMoreTimesButton];
        
        catIcons = 0;
        
        summaryTimesDisplayed = NO;
    }
    
    return self;
}

- (void) createSections {
    
    termTimes = [busStops valueForKey:[HOPPER_API_HEADERS objectAtIndex:0]];
    
    saturdayTimes = [busStops valueForKey:[HOPPER_API_HEADERS objectAtIndex:1]];
    
    outofTermTimes = [busStops valueForKey:[HOPPER_API_HEADERS objectAtIndex:2]];
    
    
    [self createLabel:[busStops valueForKey:@"Name"] :[UIColor blackColor] :YES :0 :5.0 :NO];
    
    if (termTimes.count) {
        
        if(![[self getCurrentDay] isEqual: @"Saturday"] && ![[self getCurrentDay] isEqual: @"Sunday"]){
            
            [self addTimeLabel:[termTimes objectAtIndex:0] :[termTimes objectAtIndex:[termTimes count]-1]];
        }
        
        catIcons++;
        [self setWeekdaysTag];
    }
    
    if (saturdayTimes.count) {
        
        if ([[self getCurrentDay] isEqual: @"Saturday"]) {
            
            [self addTimeLabel:[saturdayTimes objectAtIndex:0] :[saturdayTimes objectAtIndex:[saturdayTimes count]-1]];
        }
        
        catIcons++;
        [self setSaturdayTag];
    }
    
    if (outofTermTimes.count) {
        
        catIcons++;
        [self setOutOfTermTag];
    }
    
    if (!summaryTimesDisplayed) {
        
       [self createLabel:@"No Buses Today" :[UIColor grayColor] :YES :0.0 :35.0 :NO];
    }
}

- (NSString *)getCurrentDay {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEEE"];
    
    return [dateFormatter stringFromDate:[NSDate date]];
}

- (void) addTimeLabel:(NSString*)firstTime :(NSString*)secondTime {
    
    [self createLabel:[NSString stringWithFormat: @"%@ - %@", firstTime, secondTime] :[UIColor grayColor] :YES :0.0 :35.0 :NO];
    summaryTimesDisplayed = YES;
}

- (void) addMoreTimesButton {
    
    //for cell background
    
    UIButton *view = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 80)];
    
    view.backgroundColor = [UIColor colorWithRed:0.933 green:0.933 blue:0.933 alpha:1.0];
    
    [expandedSection addSubview:view];
    
    // button for more
    
    UIButton *moreTimes = [[UIButton alloc] initWithFrame:CGRectMake(250, 0,70, 80)];
    
    moreTimes.backgroundColor = MAIN_COLOUR;
    
    moreTimes.alpha = 0.72;
    
    [moreTimes setTitle:@">" forState:UIControlStateNormal];
    
    [moreTimes addTarget:self action:@selector(showTime) forControlEvents:UIControlEventTouchUpInside];
    
    [moreTimes setTitleColor:view.backgroundColor forState:UIControlStateNormal];
    
    [moreTimes.titleLabel setFont:[UIFont fontWithName:@"Mockup" size:40]];
    
    [expandedSection addSubview:moreTimes];
}

- (void) showTime {
    
    NSMutableDictionary *allTimes = [[NSMutableDictionary alloc] init];
    
    [allTimes setObject:termTimes forKey:[HOPPER_API_HEADERS objectAtIndex:0]];
    
    [allTimes setObject:saturdayTimes forKey:[HOPPER_API_HEADERS objectAtIndex:1]];
    
    [allTimes setObject:outofTermTimes forKey:[HOPPER_API_HEADERS objectAtIndex:2]];

    [self.delegate showFullTimes:allTimes];
}

- (NSString *) getNextThreeTimes:(NSArray *)times {
    
    int amountDiscovered = 0;
    
    NSMutableString *appendedTimes = [NSMutableString string];
    // get current date/time
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // display in 12HR/24HR (i.e. 11:25PM or 23:25) format according to User Settings
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"HH:mm"];
    NSString *currentTime = [dateFormatter stringFromDate:today];
    currentTime = [currentTime stringByReplacingOccurrencesOfString:@"PM" withString:@""];
    
    for (int time = 0; time < [times count]; time++) {
        
        if (amountDiscovered == 3) {
            break;
        }
        
        NSString *selectedTime;
        
        selectedTime = [[times objectAtIndex:time] stringByReplacingOccurrencesOfString:@"." withString:@":"];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"HH:mm"];
        
        NSDate *date1= [formatter dateFromString:currentTime];
        NSDate *date2 = [formatter dateFromString:selectedTime];
        
        NSComparisonResult result = [date1 compare:date2];
        
        if (result == NSOrderedDescending) {
            //NSLog(@"date1 is later than date2");
            
        } else if (result == NSOrderedAscending) {
            //Gets in here when the current time is less than the hovering time indicating a suitable take of time()
            amountDiscovered++;
            [appendedTimes appendString:[NSString stringWithFormat:@"%@    ",[times objectAtIndex:time]]];
            
        } else {
            //NSLog(@"date1 is equal to date2");
        }
    }
    
    return appendedTimes;
}

- (void) createLabel:(NSString*)text :(UIColor*)textColour :(BOOL)isForMainSection :(float)addToXVal :(float)yVal :(BOOL)centre {
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15.0 + addToXVal, yVal, self.frame.size.width - 30.0, 40)];
    label.font = [UIFont fontWithName:CELL_FONT size:CELL_FONT_SIZE];
    label.textColor = textColour;
    label.text = text;
    
    label.textAlignment = NSTextAlignmentLeft;
    
    if (centre) {
        
        label.textAlignment = NSTextAlignmentCenter;
    }
    
    if (isForMainSection) {
        
        [mainSection addSubview:label];
        
    } else {
        
        [expandedSection addSubview:label];
    }
}

- (void) removeExpandedCell {
    
    [expandedSection setBackgroundColor:[UIColor clearColor]];
    expandedSection = NULL;
}

-(void)setSaturdayTag{
    
    UILabel *saturdayTag = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width - 40*catIcons, 42.0, 25, 25)];
    [saturdayTag setTextColor:[UIColor colorWithRed:0.82 green:0.52 blue:0.39 alpha:1.0]];
    [saturdayTag.layer setBorderWidth:1.5];
    [saturdayTag.layer setBorderColor:[saturdayTag.textColor CGColor]];
    [saturdayTag.layer setCornerRadius:12.5];
    [saturdayTag setFont:[UIFont systemFontOfSize:10]];
    [saturdayTag setText:@"S"];
    [saturdayTag setTextAlignment:NSTextAlignmentCenter];
    [mainSection addSubview:saturdayTag];
    
    UILabel *saturdayTag_SecondSection = [[UILabel alloc] initWithFrame:CGRectMake(15, 15 + 18*(3 - catIcons), 60, 15)];
    [saturdayTag_SecondSection setTextColor:saturdayTag.textColor];
    [saturdayTag_SecondSection.layer setBorderWidth:1];
    [saturdayTag_SecondSection.layer setBorderColor:[saturdayTag.textColor CGColor]];
    [saturdayTag_SecondSection.layer setCornerRadius:2];
    [saturdayTag_SecondSection setFont:[UIFont systemFontOfSize:9]];
    [saturdayTag_SecondSection setText:@"Saturdays"];
    [saturdayTag_SecondSection setTextAlignment:NSTextAlignmentCenter];
    [expandedSection addSubview:saturdayTag_SecondSection];
}

-(void)setWeekdaysTag{
    
    UILabel *weekDaysTag = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width - 40*catIcons, 42.0, 25, 25)];
    [weekDaysTag setTextColor:[UIColor colorWithRed:0.56 green:0.56 blue:0.80 alpha:1.0]];
    [weekDaysTag.layer setBorderWidth:1.5];
    [weekDaysTag.layer setBorderColor:[weekDaysTag.textColor CGColor]];
    [weekDaysTag.layer setCornerRadius:12.5];
    [weekDaysTag setFont:[UIFont systemFontOfSize:8]];
    [weekDaysTag setText:@"WD"];
    [weekDaysTag setTextAlignment:NSTextAlignmentCenter];
    [mainSection addSubview:weekDaysTag];
    
    UILabel *weekDaysTag_SecondSection = [[UILabel alloc] initWithFrame:CGRectMake(15, 15 + 18*(3 - catIcons), 60, 15)];
    [weekDaysTag_SecondSection setTextColor:weekDaysTag.textColor];
    [weekDaysTag_SecondSection.layer setBorderWidth:1];
    [weekDaysTag_SecondSection.layer setBorderColor:[weekDaysTag.textColor CGColor]];
    [weekDaysTag_SecondSection.layer setCornerRadius:2];
    [weekDaysTag_SecondSection setFont:[UIFont systemFontOfSize:9]];
    [weekDaysTag_SecondSection setText:@"Weekdays"];
    [weekDaysTag_SecondSection setTextAlignment:NSTextAlignmentCenter];
    [expandedSection addSubview:weekDaysTag_SecondSection];
    
}

-(void)setOutOfTermTag{
    
    UILabel *outofTermTag = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width - 40*catIcons, 42.0, 25, 25)];
    [outofTermTag setTextColor:[UIColor colorWithRed:0.36 green:0.67 blue:0.33 alpha:1.0]];
    [outofTermTag.layer setBorderWidth:1.5];
    [outofTermTag.layer setBorderColor:[outofTermTag.textColor CGColor]];
    [outofTermTag.layer setCornerRadius:12.5];
    [outofTermTag setFont:[UIFont systemFontOfSize:8]];
    [outofTermTag setText:@"OT"];
    [outofTermTag setTextAlignment:NSTextAlignmentCenter];
    [mainSection addSubview:outofTermTag];
    
    UILabel *outofTermTag_SecondSection = [[UILabel alloc] initWithFrame:CGRectMake(15, 15 + 18*(3 - catIcons), 60, 15)];
    [outofTermTag_SecondSection setTextColor:outofTermTag.textColor];
    [outofTermTag_SecondSection.layer setBorderWidth:1];
    [outofTermTag_SecondSection.layer setBorderColor:[outofTermTag.textColor CGColor]];
    [outofTermTag_SecondSection.layer setCornerRadius:2];
    [outofTermTag_SecondSection setFont:[UIFont systemFontOfSize:9]];
    [outofTermTag_SecondSection setText:@"Out of Term"];
    [outofTermTag_SecondSection setTextAlignment:NSTextAlignmentCenter];
    [expandedSection addSubview:outofTermTag_SecondSection];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

@end
