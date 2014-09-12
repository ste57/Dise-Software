//
//  NewsCell.h
//  NEFS
//
//  Created by Stephen Sowole on 10/07/2014.
//  Copyright (c) 2014 Stephen Sowole. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "News.h"
#import "Config.h"

@interface NewsCell : UITableViewCell

@property(nonatomic,retain) News *news;

- (void) createTextData;

@end
