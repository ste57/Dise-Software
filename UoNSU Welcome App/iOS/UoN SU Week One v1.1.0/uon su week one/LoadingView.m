//
//  LoadingView.m
//  UoNSU Week One
//
//  Created by Tosin Afolabi on 30/08/2014.
//  Copyright (c) 2014 Stephen Sowole. All rights reserved.
//

#import "LoadingView.h"

@implementation LoadingView

- (instancetype)init {
    
    self = [super init];
    
    if (self) {
        
        [self setBackgroundColor:[UIColor whiteColor]];
        [self configureSubviews];
    }
    
    return self;
}

- (void)configureSubviews {
    
    self.shimmeringView = [FBShimmeringView new];
    [self.shimmeringView setShimmeringPauseDuration:1.0];
    [self.shimmeringView setTranslatesAutoresizingMaskIntoConstraints:false];
    [self addSubview:self.shimmeringView];
    
    self.loadingLabel = [UILabel new];
    [self.loadingLabel setText:EVENT_LOADING_TEXT];
    [self.loadingLabel setFont:[UIFont fontWithName:@"Mockup" size:16.0]];
    [self.loadingLabel setTextColor:[UIColor blackColor]];
    [self.loadingLabel setTextAlignment:NSTextAlignmentCenter];
    [self.loadingLabel setTranslatesAutoresizingMaskIntoConstraints:false];
    self.loadingLabel.numberOfLines = 2;
    
    self.shimmeringView.contentView = self.loadingLabel;
    
    // Start shimmering.
    self.shimmeringView.shimmering = YES;
    
    NSDictionary *views = @{@"shimmeringView": self.shimmeringView};
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[shimmeringView]|" options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[shimmeringView]|" options:0 metrics:nil views:views]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.shimmeringView.contentView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.shimmeringView.contentView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]];
}

- (CGSize)intrinsicContentSize {
    
    return CGSizeMake(280, 90);
}



@end
