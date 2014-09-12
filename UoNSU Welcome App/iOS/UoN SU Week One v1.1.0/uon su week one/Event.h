//
//  Event.h
//  UoN SU Week One
//
//  Created by Stephen Sowole on 15/08/2014.
//  Copyright (c) 2014 Stephen Sowole. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Event : NSObject

@property (strong, nonatomic) NSString *_id;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *link;
@property (strong, nonatomic) NSString *eventDesc;
@property (strong, nonatomic) NSString *time;
@property (strong, nonatomic) NSString *date;
@property (strong, nonatomic) NSString *location;
@property (strong, nonatomic) NSMutableArray *categories;

- (UIColor*) getCategoryColour:(NSString*) category;

- (NSString*) getCategoryShortName:(NSString*) category;

@end
