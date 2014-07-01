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

- (NSString*) getIconName {
    
    if ([eEvent isEqual:NEFS_API_NAME]) {
    
        return NEFS_ICON;
        
    } else if ([eEvent isEqual:VICTORIA_CENTRE_API_NAME]) {
        
        return VICTORIA_CENTRE_ICON;
        
    } else if ([eEvent isEqualToString:CAREERS_API_NAME]) {
        
        return CAREERS_ICON;
        
    } else if ([eEvent isEqualToString:SOCIAL_API_NAME]) {
        
        return SOCIAL_ICON;
        
    } else if ([eEvent isEqualToString:SPORTS_API_NAME]) {
        
        return SPORTS_ICON;
    }
    
    return NULL;
}

@end
