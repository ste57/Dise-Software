//
//  LoadingView.h
//  UoNSU Week One
//
//  Created by Tosin Afolabi on 30/08/2014.
//  Copyright (c) 2014 Stephen Sowole. All rights reserved.
//

#import "FBShimmering.h"
#import "FBShimmeringView.h"
#import <UIKit/UIKit.h>
#import "Config.h"

@interface LoadingView : UIView

@property (nonatomic, strong) UILabel *loadingLabel;
@property (nonatomic, strong) FBShimmeringView *shimmeringView;

@end
