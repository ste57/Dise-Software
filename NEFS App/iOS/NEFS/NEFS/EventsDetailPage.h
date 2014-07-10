//
//  EventsDetailPage.h
//  NEFS
//
//  Created by Stephen Sowole on 26/06/2014.
//  Copyright (c) 2014 Stephen Sowole. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"
#import "Config.h"

@interface EventsDetailPage : UIViewController <UIWebViewDelegate>

@property(nonatomic,retain) Event *event;
@property(nonatomic,retain) NSString *eId;

- (void) createTextData;

@end
