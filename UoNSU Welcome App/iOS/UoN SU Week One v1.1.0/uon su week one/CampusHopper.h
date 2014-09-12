//
//  CampusHopper.h
//  UoNSU Welcome App
//
//  Created by Stephen Sowole on 02/09/2014.
//  Copyright (c) 2014 Stephen Sowole. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"
#import "Config.h"
#import "CustomCell.h"
#import "AllTimesForBus.h"

@interface CampusHopper : UITableViewController <CustomCellDelegate>

- (void) getBusTimes:(NSString*)bus;

@end
