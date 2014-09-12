//
//  PlainDescriptionView.m
//  NEFS
//
//  Created by Stephen Sowole on 14/08/2014.
//  Copyright (c) 2014 Stephen Sowole. All rights reserved.
//

#import "PlainDescriptionView.h"

@implementation PlainDescriptionView

- (void) viewDidLoad {
    
    [super viewDidLoad];
    
    [self removeBackButtonText];
}

- (void) removeBackButtonText {
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backButtonItem];
}

- (void) setText:(NSString*)desc {
    
    UITextView *descriptionView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    [self.view addSubview:descriptionView];
    
    descriptionView.text = desc;
    
    descriptionView.textAlignment = NSTextAlignmentLeft;
    
    descriptionView.editable = NO;
    
    descriptionView.textContainerInset = UIEdgeInsetsMake(15.0, 15.0, 0.0, 10.0);
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    paragraphStyle.lineSpacing = LINE_SPACING;
    
    NSString *string = descriptionView.text;
    
    NSDictionary *ats = @{
                          NSFontAttributeName : [UIFont fontWithName:@"AppleSDGothicNeo-Medium" size:DESCRIPTION_FONT_SIZE],
                          NSParagraphStyleAttributeName : paragraphStyle,
                          };
    
    descriptionView.attributedText = [[NSAttributedString alloc] initWithString:string attributes:ats];
    descriptionView.textColor = [UIColor darkGrayColor];

}

@end
