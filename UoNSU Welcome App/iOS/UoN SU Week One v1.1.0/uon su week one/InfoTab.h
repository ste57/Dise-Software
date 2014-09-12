//
//  InfoTab.h
//  UoN SU Week One
//
//  Created by Stephen Sowole on 15/08/2014.
//  Copyright (c) 2014 Stephen Sowole. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "Config.h"
#import "UniversityMaps.h"
#import "PlainDescriptionView.h"
#import "Config.h"
#import "Contacts.h"
#import "HopperBuses.h"

#import "GAI.h"
#import "GAIFields.h"

@interface InfoTab : GAITrackedViewController  <UITableViewDataSource, UITableViewDelegate, MFMailComposeViewControllerDelegate>

@end
