//
//  AllTimesForBus.m
//  UoNSU Welcome App
//
//  Created by Stephen Sowole on 02/09/2014.
//  Copyright (c) 2014 Stephen Sowole. All rights reserved.
//

#import "AllTimesForBus.h"

#define ROW_HEIGHT 50.0

#define CELL_FONT @"GillSans"
#define CELL_FONT_SIZE 18.0

@implementation AllTimesForBus

@synthesize times;

- (void) viewDidLoad {
    
    [super viewDidLoad];

    [self removeBackButtonText];
    
    [self createTableView];
}

- (void) createTableView {
    
    CGRect window = [[UIScreen mainScreen] bounds];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, window.size.width, window.size.height) style:UITableViewStylePlain];
    
    tableView.delegate = self;
    
    tableView.dataSource = self;
    
    tableView.rowHeight = ROW_HEIGHT;

    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    tableView.separatorInset = UIEdgeInsetsZero;
    
    [self.view addSubview:tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSArray *timesArray = [times objectForKey:[HOPPER_API_HEADERS objectAtIndex:section]];
    
    return [timesArray count];
}

- (void) tableView:(UITableView *)table didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [table deselectRowAtIndexPath:indexPath animated:YES];
}

- (void) tableView:(UITableView *)table moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    
    [table deselectRowAtIndexPath:sourceIndexPath animated:YES];
}

- (UITableViewCell*) tableView:(UITableView *)table cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [table dequeueReusableCellWithIdentifier:@"Cell"];
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithFrame:CGRectZero];
    
    NSArray *timesArray = [times objectForKey:[HOPPER_API_HEADERS objectAtIndex:indexPath.section]];
    
    NSString *time = [timesArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = time;
    
    cell.textLabel.font = [UIFont fontWithName:CELL_FONT size:CELL_FONT_SIZE];
    
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    
    return cell;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [HOPPER_API_HEADERS count];
}

- (NSString*) getHeaderName:(int)section {
    
    NSArray *timesArray = [times objectForKey:[HOPPER_API_HEADERS objectAtIndex:section]];
    
    if (timesArray.count) {
        
        switch (section) {
                
            case 0:
                return @"Term Times";
                break;
                
            case 1:
                return @"Saturdays";
                break;
                
            case 2:
                return @"Out Of Term Times";
                break;
        }
    }
    
    return @"";
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if ([tableView.dataSource tableView:tableView numberOfRowsInSection:section] == 0) {
        
        return 0;
        
    } else {
        
        return 30.0;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    NSArray *timesArray = [times objectForKey:[HOPPER_API_HEADERS objectAtIndex:section]];
    
    UILabel *lbl = [[UILabel alloc] init];
    
    if (timesArray.count) {
        
        lbl.textAlignment = NSTextAlignmentCenter;
        
        lbl.font = [UIFont fontWithName:CELL_FONT size:17];
        
        lbl.text = [self getHeaderName:(int)section];
        
        lbl.textColor = [UIColor blackColor];
        
        lbl.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:0.9];
        
        lbl.frame = CGRectMake(0, 0, 320, 50);
        
        return lbl;
    }
    
    return nil;
}

- (void) removeBackButtonText {
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backButtonItem];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

@end
