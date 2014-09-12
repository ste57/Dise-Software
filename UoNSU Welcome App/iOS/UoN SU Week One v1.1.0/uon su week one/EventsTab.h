//
//  EventsTab.h
//  UoN SU Week One
//
//  Created by Stephen Sowole on 15/08/2014.
//  Copyright (c) 2014 Stephen Sowole. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Config.h"
#import "Event.h"
#import "EventsCustomTVCell.h"
#import "Reachability.h"
#import "EventDetailPage.h"

#import "GAI.h"
#import "GAIFields.h"

@interface EventsTab : GAITrackedViewController <NSXMLParserDelegate, UITableViewDataSource, UITableViewDelegate>

@end
