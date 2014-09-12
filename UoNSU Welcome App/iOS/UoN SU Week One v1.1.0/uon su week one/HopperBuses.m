//
//  HopperBuses.m
//  UoNSU Welcome App
//
//  Created by Stephen Sowole on 02/09/2014.
//  Copyright (c) 2014 Stephen Sowole. All rights reserved.
//

#import "HopperBuses.h"

#define TITLE @"Hopper Buses"

#define ROW_HEIGHT 80.0

#define CELL_FONT @"GillSans"
#define CELL_FONT_SIZE 16.0

#define HOPPER_API_URLS [NSArray arrayWithObjects:@"http://hopperbus.herokuapp.com/api/jubilee", @"http://hopperbus.herokuapp.com/api/sutton", @"http://hopperbus.herokuapp.com/api/kingsmeadow", @"http://hopperbus.herokuapp.com/api/hospitalcentre", nil]

@implementation HopperBuses {
    
    UITableView *tableView;
    NSArray *categories;
}

- (void) viewDidLoad {
    
    [super viewDidLoad];
    
    categories = BUSES;
    
    self.title = TITLE;
    
    [self removeBackButtonText];
    
    [self createTableView];
}

- (void) tableView:(UITableView *)table didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CampusHopper *hopper = [[CampusHopper alloc] initWithStyle:UITableViewStylePlain];

    [hopper setTitle:[NSString stringWithFormat:@"%@ Hopper",[categories objectAtIndex:indexPath.row]]];
    [self setScreenName:[NSString stringWithFormat:@"%@ Hopper",[categories objectAtIndex:indexPath.row]]];
    [hopper getBusTimes:[HOPPER_API_URLS objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:hopper animated:YES];
    
    [table deselectRowAtIndexPath:indexPath animated:YES];
}

- (void) createTableView {
    
    CGRect window = [[UIScreen mainScreen] bounds];
    
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, window.size.width, window.size.height) style:UITableViewStylePlain];
    
    tableView.delegate = self;
    
    tableView.dataSource = self;
    
    tableView.rowHeight = ROW_HEIGHT;
    
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

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

@end
