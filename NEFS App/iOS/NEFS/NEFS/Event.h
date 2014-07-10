//
//  Event.h
//  NEFS
//
//  Created by Stephen Sowole on 24/06/2014.
//  Copyright (c) 2014 Stephen Sowole. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Config.h"

@interface Event : NSObject

@property (strong, nonatomic) NSString *_id;
@property (strong, nonatomic) NSString *eTitle;
@property (strong, nonatomic) NSString *eDesc;
@property (strong, nonatomic) NSString *eDate;
@property (strong, nonatomic) NSString *eStart;
@property (strong, nonatomic) NSString *eEnd;
@property (strong, nonatomic) NSString *eLink;
@property (strong, nonatomic) NSString *eEvent;

- (UIColor*) getIconColour;

@end
