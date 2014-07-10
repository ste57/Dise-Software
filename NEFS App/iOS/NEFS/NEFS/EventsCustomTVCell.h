//
//  CustomTableViewCell.h
//  NEFS
//
//  Created by Stephen Sowole on 24/06/2014.
//  Copyright (c) 2014 Stephen Sowole. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"

@interface EventsCustomTVCell : UITableViewCell

@property(nonatomic,retain) Event *event;
@property(nonatomic,retain) NSString *eId;

- (void) createTextData;

@end
