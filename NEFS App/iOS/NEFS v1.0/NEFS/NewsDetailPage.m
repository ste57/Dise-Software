//
//  NewsDetailPage.m
//  NEFS
//
//  Created by Stephen Sowole on 13/08/2014.
//  Copyright (c) 2014 Stephen Sowole. All rights reserved.
//

#import "NewsDetailPage.h"

@implementation NewsDetailPage {
    
    UITextView *descriptionView;
    
    UIButton *siteButton;
}

@synthesize news;

- (void) viewDidLoad {
    
    [super viewDidLoad];
    
    [self removeBackButtonText];
    
    [self createDisplay];
}

- (void) removeBackButtonText {
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backButtonItem];
}

- (void) createDisplay {

    [self createSiteButton];
    
    [self createDescription];
}

- (void) createSiteButton {
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"NewsWebIcon"]];
    
    if (![news.nLink isEqualToString:@""]) {

        UIBarButtonItem *webButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(goToMainSite)];
        [webButton setImage:[UIImage imageNamed:@"NewsWebIcon"]];
    
        self.navigationItem.rightBarButtonItem = webButton;
    }
}

- (void) goToMainSite {
    
    CustomWebView *web = [[CustomWebView alloc] init];
    
    [self.navigationController pushViewController:web animated:YES];
    
    web.title = news.nTitle;
    
    web.websiteLink = news.nLink;
    
    [web loadWebsite];
}

- (void) createDescription {
    
    descriptionView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    [self.view addSubview:descriptionView];
    
    descriptionView.textAlignment = NSTextAlignmentLeft;
    
    descriptionView.editable = NO;
    
    descriptionView.textContainerInset = UIEdgeInsetsMake(15.0, 15.0, 10.0, 10.0);
}

- (void) createTextData {
    
    [self createNavigationBarTitle];
    
    descriptionView.text = news.nDesc;
    
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

- (void) createNavigationBarTitle {
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 40)];
    label.text = self.navigationItem.title;
    
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont boldSystemFontOfSize:17];
    label.backgroundColor = [UIColor clearColor];
    
    label.adjustsFontSizeToFitWidth = YES;
    label.minimumScaleFactor = 0.7;
    
    label.textAlignment = NSTextAlignmentCenter;
    
    self.navigationItem.titleView = label;
}

@end
