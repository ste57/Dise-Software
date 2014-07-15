//
//  SportsTab.m
//  NEFS
//
//  Created by Stephen Sowole on 24/06/2014.
//  Copyright (c) 2014 Stephen Sowole. All rights reserved.
//

#import "SportsTab.h"

@interface SportsTab ()

@end

@implementation SportsTab

- (void) viewDidLoad {
    
    [super viewDidLoad];
    
    [self removeBackButtonText];
}

- (void) removeBackButtonText {
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backButtonItem];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

@end
