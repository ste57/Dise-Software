//
//  Event.m
//  UoN SU Week One
//
//  Created by Stephen Sowole on 15/08/2014.
//  Copyright (c) 2014 Stephen Sowole. All rights reserved.
//

#import "Event.h"

#define FREE @"Free"
#define MEET_GREET @"Meet and greet"
#define MATURE @"Mature"
#define NON_ALCOHOLIC @"Non-alcoholic"
#define POST_GRAD @"Postgraduate"
#define NIGHT_OUT @"Night out"
#define MOVIE_NIGHT @"Movie night"
#define FAITH @"Faith"
#define OFF_CAMPUS @"Off campus"
#define ON_CAMPUS @"On campus"
#define SPORTS @"Sport"
#define TICKETED @"Ticketed"
#define DERBY @"Derby"

@implementation Event

@synthesize categories;

- (id) init {
    
    if (self = [super init]) {
        
        categories = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (UIColor*) getCategoryColour:(NSString*) category {
    
    if ([category isEqual:FREE]) {
        
        return [UIColor colorWithRed:0.53 green:0.78 blue:0.57 alpha:1.0];
        
    } else if ([category isEqual:MEET_GREET]) {
        
        return [UIColor colorWithRed:0.93 green:0.76 blue:0.58 alpha:1.0];
        
    } else if ([category isEqual:MATURE]) {
        
        return [UIColor colorWithRed:0.48 green:0.76 blue:0.91 alpha:1.0];
        
    } else if ([category isEqual:NON_ALCOHOLIC]) {
        
        return [UIColor colorWithRed:0.96 green:0.60 blue:0.60 alpha:1.0];
        
    } else if ([category isEqual:POST_GRAD]) {
        
        return [UIColor colorWithRed:0.84 green:0.57 blue:0.87 alpha:1.0];
        
    } else if ([category isEqual:NIGHT_OUT]) {
        
        return [UIColor colorWithRed:0.95 green:0.60 blue:0.54 alpha:1.0];
        
    } else if ([category isEqual:MOVIE_NIGHT]) {
        
        return [UIColor colorWithRed:0.47 green:0.67 blue:0.86 alpha:1.0];//[UIColor colorWithRed:0.90 green:0.66 blue:0.91 alpha:1.0];
        
    } else if ([category isEqual:FAITH]) {
        
        return [UIColor colorWithRed:0.53 green:0.70 blue:0.85 alpha:1.0];
        
    } else if ([category isEqual:OFF_CAMPUS]) {
        
        return [UIColor colorWithRed:0.96 green:0.75 blue:0.48 alpha:1.0];
        
    } else if ([category isEqual:ON_CAMPUS]) {
        
        return [UIColor colorWithRed:0.53 green:0.55 blue:0.78 alpha:1.0];
    
    } else if ([category isEqual:SPORTS]) {
        
        return [UIColor colorWithRed:0.87 green:0.73 blue:0.87 alpha:1.0];
        
    } else if ([category isEqual:TICKETED]) {
        
        return [UIColor colorWithRed:0.58 green:0.80 blue:0.66 alpha:1.0];
    
    } else if ([category isEqual:DERBY]) {
            
        return [UIColor colorWithRed:0.69 green:0.60 blue:0.85 alpha:1.0];
    }
    
    return NULL;
}

- (NSString*) getCategoryShortName:(NSString*) category {
    
    if ([category isEqual:FREE]) {
        
        return @"FR";
        
    } else if ([category isEqual:MEET_GREET]) {
        
        return @"MG";
        
    } else if ([category isEqual:MATURE]) {
        
        return @"MA";
        
    } else if ([category isEqual:NON_ALCOHOLIC]) {
        
        return @"NA";
        
    } else if ([category isEqual:POST_GRAD]) {
        
        return @"PG";
        
    } else if ([category isEqual:NIGHT_OUT]) {
        
        return @"NO";
        
    } else if ([category isEqual:MOVIE_NIGHT]) {
        
        return @"MN";
        
    } else if ([category isEqual:FAITH]) {
        
        return @"FA";
        
    } else if ([category isEqual:OFF_CAMPUS]) {
        
        return @"OF";
        
    } else if ([category isEqual:ON_CAMPUS]) {
        
        return @"ON";
        
    } else if ([category isEqual:SPORTS]) {
        
        return @"SP";
        
    } else if ([category isEqual:TICKETED]) {
        
        return @"TK";
        
    } else if ([category isEqual:DERBY]) {
        
        return @"DB";
    }
    
    return NULL;
}

@end
