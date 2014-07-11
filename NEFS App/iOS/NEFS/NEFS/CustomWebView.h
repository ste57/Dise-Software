//
//  CustomWebView.h
//  NEFS
//
//  Created by Stephen Sowole on 10/07/2014.
//  Copyright (c) 2014 Stephen Sowole. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomWebView : UIViewController <UIWebViewDelegate>

@property(nonatomic,retain) NSString *websiteLink;

- (void) loadWebsite;

@end
