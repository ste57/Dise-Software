//
//  Contacts.m
//  UoNSU Welcome App
//
//  Created by Stephen Sowole on 01/09/2014.
//  Copyright (c) 2014 Stephen Sowole. All rights reserved.
//

#import "Contacts.h"

#define TITLE @"Important Contacts"

#define TITLE_COLOUR  [UIColor blackColor]
#define TITLE_FONT_SIZE 16.0
#define TITLE_FONT @"GillSans"

#define TEXT_COLOUR  [UIColor grayColor]
#define TEXT_FONT_SIZE 16.0
#define TEXT_FONT @"GillSans"

#define LINE_SPACING 5.0

@implementation Contacts {
    
    UIScrollView *scroll;
}

- (void) viewDidLoad {
    
    [super viewDidLoad];

    [self removeBackButtonText];
    
    [self addScrollView];
    
    [self addContacts];
}

- (void) addScrollView {
    
    scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    scroll.backgroundColor = MAIN_COLOUR_2;
    
    [self.view addSubview:scroll];
}

- (void) removeBackButtonText {
    
    [self setTitle:TITLE];
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backButtonItem];
}

- (void) addContacts {
    
    [self getTextProperties:@"0115 846 8800" forNumber:true :30];
    
    [self getTitleProperties:@"Students' Union Reception/Box Office:" :0];
    
    
    [self getTextProperties:@"student-advice-centre@nottingham.ac.uk" forNumber:false :130];
    
    [self getTextProperties:@"0115 846 8730" forNumber:true :100];
    
    [self getTitleProperties:@"Student Advice Centre:" :70];
    
    
    [self getTextProperties:@"nightlineanon@nottingham.ac.uk" forNumber:false :230];
    
    [self getTextProperties:@"0115 951 4985" forNumber:true :200];
    
    [self getTitleProperties:@"Nightline:" :170];
    
    
    [self getTextProperties:@"0115 846 8888" forNumber:true :300];
    
    [self getTitleProperties:@"University of Nottingham Health Service:" :270];
    
    
    [self getTextProperties:@"0115 960 7607" forNumber:true :370];
    
    [self getTitleProperties:@"D&G Taxis:" :340];
}

- (void) getTextProperties:(NSString*)text forNumber:(bool)isNumber :(int)add {
    
    UITextView *label = [[UITextView alloc] init];
    
    label.frame = CGRectMake(15.0, 15.0 + add, self.view.frame.size.width - 30.0, 30);
    
    [scroll addSubview:label];
    
    label.textColor = TEXT_COLOUR;
    
    label.font = [UIFont fontWithName:TEXT_FONT size:TEXT_FONT_SIZE];
    
    label.text = text;
    
    label.textAlignment = NSTextAlignmentCenter;
    label.dataDetectorTypes = UIDataDetectorTypePhoneNumber;
    //label.selectable = NO;
    label.editable = NO;
    label.scrollEnabled = NO;
    
    if (isNumber) {
        label.selectable = YES;
    }
    
    [scroll setContentSize:CGSizeMake(scroll.frame.size.width, 15.0 + label.center.y + label.frame.size.height/2)];
}

- (void) getTitleProperties:(NSString*)text :(int)add {
    
    UILabel *label = [[UILabel alloc] init];
    
    label.frame = CGRectMake(15.0, 15.0 + add, self.view.frame.size.width - 30.0, 30);
    
    [scroll addSubview:label];
    
    label.textColor = TITLE_COLOUR;
    
    label.text = text;
    
    label.font = [UIFont fontWithName:TITLE_FONT size:TITLE_FONT_SIZE];
    
    label.textAlignment = NSTextAlignmentCenter;
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

@end
