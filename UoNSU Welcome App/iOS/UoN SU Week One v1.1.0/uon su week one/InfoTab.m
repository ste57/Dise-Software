//
//  InfoTab.m
//  UoN SU Week One
//
//  Created by Stephen Sowole on 15/08/2014.
//  Copyright (c) 2014 Stephen Sowole. All rights reserved.
//

#import "InfoTab.h"

#define INFO_ROW_HEIGHT 60.0

#define CELL_FONT @"GillSans"
#define CELL_FONT_SIZE 16.0

@implementation InfoTab {
    
    UITableView *tableView;
    NSArray *categories;
}

- (void) viewDidLoad {
    
    [super viewDidLoad];
    
    [self setScreenName:@"Info Tab"];
    
    categories = INFO_CATEGORIES;
    
    [self removeBackButtonText];
    
    [self createTableView];
}

- (void) tableView:(UITableView *)table didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.row) {
            
        case 0:
            [self universityMaps];
            break;
            
        case 1:
            [self hopperBus];
            break;
            
        case 2:
            [self importantContacts:[categories objectAtIndex:indexPath.row]];
            break;
            
        case 3:
            [self aboutUoNSU:[categories objectAtIndex:indexPath.row]];
            break;
            
        case 4:
            [self sendFeedback];
            break;
            
        case 5:
            [self credits];
            break;
            
        default:
            break;
    }
    
    [table deselectRowAtIndexPath:indexPath animated:YES];
}

- (void) hopperBus {
    
    HopperBuses *view = [[HopperBuses alloc] init];
    
    [self.navigationController pushViewController:view animated:YES];
}

- (void) credits {
    
    [self setScreenName:@"Credits"];
    
    PlainDescriptionView *descView = [[PlainDescriptionView alloc] init];
    
    descView.title = @"Acknowledgements";
    
    [descView setText:[NSString stringWithFormat:@"%@\n\n%@",CREDITS,VERSION]];
    
    [self.navigationController pushViewController:descView animated:YES];
}

- (void) sendFeedback {
    
    NSString *emailTitle = @"Feedback";
    
    NSString *messageBody = @"Feedback is always appreciated :).";
    
    NSArray *toRecipents = [NSArray arrayWithObjects:@"suwebsite@nottingham.ac.uk", @"stephensowole@hotmail.co.uk", nil];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    
    mc.mailComposeDelegate = self;
    
    [mc setSubject:emailTitle];
    
    [mc setMessageBody:messageBody isHTML:NO];
    
    [mc setToRecipients:toRecipents];
    
    [self presentViewController:mc animated:YES completion:NULL];
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void) aboutUoNSU:(NSString*)title {
    
    PlainDescriptionView *descView = [[PlainDescriptionView alloc] init];
    
    descView.title = title;
    
    [descView setText:UONSU_DESC];
    
    [self.navigationController pushViewController:descView animated:YES];
}

- (void) universityMaps {
    
    UniversityMaps *view = [[UniversityMaps alloc] init];
    
    [self.navigationController pushViewController:view animated:YES];
}

- (void) importantContacts:(NSString*)title {
    
    [self setScreenName:@"Important Contacts"];
    
    Contacts *contacts = [[Contacts alloc] init];
    
    [self.navigationController pushViewController:contacts animated:YES];
}

- (void) createTableView {
    
    CGRect window = [[UIScreen mainScreen] bounds];
    
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, window.size.width, window.size.height) style:UITableViewStylePlain];
    
    tableView.delegate = self;
    
    tableView.dataSource = self;
    
    tableView.rowHeight = INFO_ROW_HEIGHT;
    
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self.view addSubview:tableView];
    
    tableView.scrollEnabled = NO;
}

- (UITableViewCell*) tableView:(UITableView *)table cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [table dequeueReusableCellWithIdentifier:@"Cell"];
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithFrame:CGRectZero];
    
    cell.textLabel.text = [categories objectAtIndex:indexPath.row];
    
    cell.textLabel.font = [UIFont fontWithName:CELL_FONT size:CELL_FONT_SIZE];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return categories.count;
}

- (void) tableView:(UITableView *)table moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    
    [table deselectRowAtIndexPath:sourceIndexPath animated:YES];
}

- (void) removeBackButtonText {
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backButtonItem];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
