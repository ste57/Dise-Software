//
//  FinanceSocieties.m
//  NEFS
//
//  Created by Stephen Sowole on 14/08/2014.
//  Copyright (c) 2014 Stephen Sowole. All rights reserved.
//

#import "FinanceSocieties.h"

@interface FinanceSocieties ()

@end

@implementation FinanceSocieties {
    
    UITableView *tableView;
    NSArray *categories;
}

- (void) viewDidLoad {
    
    [super viewDidLoad];
    
    categories = FINANCE_SOCIETIES;
    
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

    PlainDescriptionView *descView = [[PlainDescriptionView alloc] init];
    
    switch (indexPath.row) {
            
        case 0:
            descView.title = @"Corporate Finance";
            [descView setText:COORP_FINANCE_DESC];
            break;
        
        case 1:
            descView.title = @"Equity Fund";
            [descView setText:EQUITY_FUND_DESC];
            break;
        
        case 2:
            descView.title = @"Research";
            [descView setText:RESEARCH_DESC];
            break;
        
        case 3:
            descView.title = @"Women In Finance";
            [descView setText:WOMEN_IN_FINANCE_DESC];
            break;
            
        default:
            break;
    }
    
    
    [self.navigationController pushViewController:descView animated:YES];

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
    
    [cell addArrow];
    
    return cell;
}

@end
