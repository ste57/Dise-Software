//
//  UniversityMaps.m
//  UoNSU Welcome App
//
//  Created by Stephen Sowole on 30/08/2014.
//  Copyright (c) 2014 Stephen Sowole. All rights reserved.
//

#import "UniversityMaps.h"

#define INFO_ROW_HEIGHT 60.0

#define CELL_FONT @"GillSans"
#define CELL_FONT_SIZE 16.0

#define TITLE @"Maps"

#define UNI_PARK @"UniversityPark"
#define JUBILEE @"JubileeCampus"
#define SUTTON @"SuttonBonington"

@implementation UniversityMaps {
    
    UITableView *tableView;
    NSArray *categories;
}

- (void) viewDidLoad {
    
    [super viewDidLoad];
    
    categories = MAPS;
    
    self.title = TITLE;
    
    [self removeBackButtonText];
    
    [self createTableView];
}

- (void) removeBackButtonText {
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backButtonItem];
}

- (void) tableView:(UITableView *)table didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self setScreenName:[MAPS objectAtIndex:indexPath.row]];
    
    switch (indexPath.row) {
            
        case 0:
            
            [self mapImage:[MAPS objectAtIndex:indexPath.row] :UNI_PARK];
            break;
            
        case 1:
            
            [self mapImage:[MAPS objectAtIndex:indexPath.row] :JUBILEE];
            break;
            
        case 2:
            
            [self mapImage:[MAPS objectAtIndex:indexPath.row] :SUTTON];
            break;
            
        default:
            break;
    }
    
    [table deselectRowAtIndexPath:indexPath animated:YES];
}

- (void) mapImage:(NSString*)title :(NSString*)imageName {
    
    ImageViewController *view = [[ImageViewController alloc] init];
    
    view.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    
    [view loadImage];
    
    view.title = title;
    
    [self.navigationController pushViewController:view animated:YES];
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

@end
