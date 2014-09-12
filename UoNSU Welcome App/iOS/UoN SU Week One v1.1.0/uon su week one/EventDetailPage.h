//
//  EventDetailPage.h
//  UoN SU Week One
//
//  Created by Stephen Sowole on 19/08/2014.
//  Copyright (c) 2014 Stephen Sowole. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"
#import "Config.h"
#import "CustomWebView.h"

@interface EventDetailPage : UIViewController

@property(nonatomic,retain) Event *event;

- (void) createTextData;

@end
