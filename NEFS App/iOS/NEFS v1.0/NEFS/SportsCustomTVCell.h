//
//  SportsCustomTVCell.h
//  NEFS
//
//  Created by Stephen Sowole on 15/07/2014.
//  Copyright (c) 2014 Stephen Sowole. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SportsTeam.h"
#import "Config.h"

@interface SportsCustomTVCell : UITableViewCell

@property(nonatomic,retain) SportsTeam *team;

- (void) createTextData;

@end
