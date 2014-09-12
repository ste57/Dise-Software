//
//  ImageViewController.h
//  UoNSU Welcome App
//
//  Created by Stephen Sowole on 31/08/2014.
//  Copyright (c) 2014 Stephen Sowole. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageViewController : UIViewController <UIScrollViewDelegate>

@property (strong, nonatomic) UIImageView *imageView;

- (void) loadImage;

@end
