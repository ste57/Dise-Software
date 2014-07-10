//
//  Event.m
//  NEFS
//
//  Created by Stephen Sowole on 24/06/2014.
//  Copyright (c) 2014 Stephen Sowole. All rights reserved.
//

#import "Event.h"

@implementation Event

@synthesize eEvent;

- (UIColor*) getIconColour {
    
    if ([eEvent isEqual:NEFS_API_NAME]) {
    
        return [UIColor colorWithRed:0.62 green:0.61 blue:0.93 alpha:1.0];
        
    } else if ([eEvent isEqual:VICTORIA_CENTRE_API_NAME]) {
        
        return [UIColor colorWithRed:0.93 green:0.61 blue:0.93 alpha:1.0];
        
    } else if ([eEvent isEqualToString:CAREERS_API_NAME]) {
        
        return [UIColor colorWithRed:0.61 green:0.93 blue:0.67 alpha:1.0];
        
    } else if ([eEvent isEqualToString:SOCIAL_API_NAME]) {
        
        return [UIColor colorWithRed:0.93 green:0.81 blue:0.61 alpha:1.0];
        
    } else if ([eEvent isEqualToString:SPORTS_API_NAME]) {
        
        return [UIColor colorWithRed:0.93 green:0.61 blue:0.61 alpha:1.0];
    }
    
    return NULL;
}

@end
