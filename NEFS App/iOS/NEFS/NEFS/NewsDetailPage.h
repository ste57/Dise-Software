//
//  NewsDetailPage.h
//  NEFS
//
//  Created by Stephen Sowole on 13/08/2014.
//  Copyright (c) 2014 Stephen Sowole. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "News.h"
#import "Config.h"
#import "CustomWebView.h"

@interface NewsDetailPage : UIViewController

@property(nonatomic,retain) News *news;

- (void) createTextData;

@end
