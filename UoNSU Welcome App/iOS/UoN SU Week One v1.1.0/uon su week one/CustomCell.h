//
//  CustomCell.h
//  HopperBus
//
//  Created by sxs02u on 01/09/2014.
//  Copyright (c) 2014 sxs02u. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Config.h"

@protocol CustomCellDelegate <NSObject>

- (void) showFullTimes:(NSMutableDictionary*)dictionary;

@end

@interface CustomCell : UITableViewCell

@property (strong, nonatomic) NSArray *busStops;
@property (assign) id <CustomCellDelegate> delegate;

- (void) removeExpandedCell;

- (void) createSections;

@end
