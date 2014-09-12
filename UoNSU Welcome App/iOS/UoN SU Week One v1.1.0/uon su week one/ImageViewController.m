//
//  ImageViewController.m
//  UoNSU Welcome App
//
//  Created by Stephen Sowole on 31/08/2014.
//  Copyright (c) 2014 Stephen Sowole. All rights reserved.
//

#import "ImageViewController.h"

@implementation ImageViewController {
    
    UIScrollView *scroll;
}

@synthesize imageView;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self removeBackButtonText];
    
    [self setOrientation];
}

- (void) setOrientation {
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(orientationChanged:)
     name:UIDeviceOrientationDidChangeNotification
     object:[UIDevice currentDevice]];
}

- (void) removeBackButtonText {
    
    self.hidesBottomBarWhenPushed = YES;
    self.tabBarController.tabBar.hidden = YES;
    self.automaticallyAdjustsScrollViewInsets = YES;
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backButtonItem];
}

- (void) orientationChanged:(NSNotification *)note
{
    UIDevice * device = note.object;
    
    double x, y;
    
    [UIView beginAnimations:nil context:nil]; [UIView setAnimationDuration:0.5f]; [UIView setAnimationDelegate:self];
    
    switch(device.orientation) {
            
        case UIDeviceOrientationLandscapeLeft:

            [scroll setTransform:CGAffineTransformMakeRotation(M_PI*90/180)];
            x = 0; y = 64;
            break;
        
        case UIDeviceOrientationLandscapeRight:

            [scroll setTransform:CGAffineTransformMakeRotation(M_PI*270/180)];
            x = 0; y = 64;
            break;
            
        default:
            
            [scroll setTransform:CGAffineTransformMakeRotation(0)];
            x = 0; y = 0;
            break;
    };
    
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    
    scroll.frame = CGRectMake(x, y, screenWidth - x, screenHeight - y);
    
    [UIView commitAnimations];
}

- (void) viewWillDisappear:(BOOL)animated {
    
    self.tabBarController.tabBar.hidden = NO;
}

- (void) loadImage {

    scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    UIImage* image = imageView.image;
    imageView.bounds = CGRectMake(0, 0, image.size.width, image.size.height);
    scroll.contentSize = image.size;
    
    [scroll setShowsHorizontalScrollIndicator:NO];
    [scroll setShowsVerticalScrollIndicator:NO];
    
    scroll.delegate = self;
    
    scroll.minimumZoomScale = scroll.frame.size.height/image.size.height;
    scroll.maximumZoomScale = 2.0;
    
    scroll.zoomScale = scroll.minimumZoomScale;



    [scroll addSubview:imageView];
    
    [scroll layoutIfNeeded];
    
    [self.view addSubview:scroll];
}



- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    
    return self.imageView;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
