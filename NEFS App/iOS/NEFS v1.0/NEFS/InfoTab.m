//
//  InfoTab.m
//  NEFS
//
//  Created by Stephen Sowole on 24/06/2014.
//  Copyright (c) 2014 Stephen Sowole. All rights reserved.
//

#import "InfoTab.h"

@implementation InfoTab {
    
    UITableView *tableView;
    NSArray *categories;
}

- (void) viewDidLoad {
    
    [super viewDidLoad];
    
    categories = INFO_CATEGORIES;
    
    [self removeBackButtonText];
    
    [self createTableView];
}

- (void) createTableView {
    
    CGRect window = [[UIScreen mainScreen] bounds];
    
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, window.size.width, window.size.height) style:UITableViewStylePlain];
    
    tableView.delegate = self;
    
    tableView.dataSource = self;
    
    tableView.rowHeight = INFO_ROW_HEIGHT;
    
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self.view addSubview:tableView];
    
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [tableView setSeparatorInset:UIEdgeInsetsZero];
    
    tableView.backgroundColor = [UIColor colorWithRed:220.0/250.0 green:220.0/250.0 blue:220.0/250.0 alpha:1.0];
    
    tableView.scrollEnabled = NO;
}

- (void) removeBackButtonText {
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backButtonItem];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return categories.count;
}

- (void) tableView:(UITableView *)table didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [table deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
            
        case 0:
            [self sponsorsPage];
            break;
            
        case 1:
            [self financeSocietiesPage];
            break;
            
        case 2:
            [self aboutNEFSPage];
            break;
            
        case 3:
            [self sendFeedback];
            break;
            
        default:
            break;
    }
}

- (void) sponsorsPage {
    
    SponsorPage *view = [[SponsorPage alloc] init];
    
    view.title = @"Sponsors";
    
    [self.navigationController pushViewController:view animated:YES];
}

- (void) financeSocietiesPage {
    
    FinanceSocieties *view = [[FinanceSocieties alloc] init];
    
    view.title = @"Finance Societies";
    
    [self.navigationController pushViewController:view animated:YES];
}

- (void) aboutNEFSPage {
    
    PlainDescriptionView *descView = [[PlainDescriptionView alloc] init];
    
    descView.title = @"About NEFS";
    
    [descView setText:ABOUT_NEFS_DESCRIPTION];

    [self.navigationController pushViewController:descView animated:YES];
}

- (void) sendFeedback {
    
    // Email Subject
    NSString *emailTitle = @"Feedback";
    // Email Content
    NSString *messageBody = @"Feedback is always appreciated :).";
    // To address
    NSArray *toRecipents = [NSArray arrayWithObject:@"stephensowole@hotmail.co.uk"];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    
    mc.mailComposeDelegate = self;
    
    [mc setSubject:emailTitle];
    
    [mc setMessageBody:messageBody isHTML:NO];
    
    [mc setToRecipients:toRecipents];
    
    // Present mail view controller on screen
    [self presentViewController:mc animated:YES completion:NULL];
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void) tableView:(UITableView *)table moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    
    [table deselectRowAtIndexPath:sourceIndexPath animated:YES];
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self loadDataIntoTable:indexPath];
}

- (UITableViewCell*) loadDataIntoTable:(NSIndexPath *)index {
    
    [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    InfoCell *cell = [[InfoCell alloc] initWithFrame:CGRectZero];
    
    [cell setTitle:[categories objectAtIndex:index.row]];
    
    if (index.row < (categories.count - 1)) {
        
        [cell addArrow];
    }
        
    return cell;
}

@end
