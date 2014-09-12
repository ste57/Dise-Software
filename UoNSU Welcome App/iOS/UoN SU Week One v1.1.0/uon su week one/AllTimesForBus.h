//
//  AllTimesForBus.h
//  UoNSU Welcome App
//
//  Created by Stephen Sowole on 02/09/2014.
//  Copyright (c) 2014 Stephen Sowole. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Config.h"

@interface AllTimesForBus : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSMutableDictionary *times;

@end
