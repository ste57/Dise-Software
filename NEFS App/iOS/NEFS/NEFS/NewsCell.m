//
//  NewsCell.m
//  NEFS
//
//  Created by Stephen Sowole on 10/07/2014.
//  Copyright (c) 2014 Stephen Sowole. All rights reserved.
//

#import "NewsCell.h"

#define TITLE_SIZE 14.0
#define DESCRIPTION_SIZE 13.0
#define NUMBER_OF_LINES 3

@implementation NewsCell {
    
    UILabel *title;
    UILabel *description;
    NSMutableArray *newsRead;
}

@synthesize news;

- (id) initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier]) {
        
        [self getReadNewsArticles];
        
        title = [[UILabel alloc]init];
        title.textAlignment = NSTextAlignmentLeft;
        title.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:TITLE_SIZE];
        
        description = [[UILabel alloc]init];
        description.textAlignment = NSTextAlignmentLeft;
        description.font = [UIFont systemFontOfSize:DESCRIPTION_SIZE];
        description.numberOfLines = NUMBER_OF_LINES;
        
        [self.contentView addSubview:description];
        [self.contentView addSubview:title];
    }
    
    return self;
}

- (void) getReadNewsArticles {
    
    newsRead = [[NSMutableArray alloc] init];
    
    NSMutableArray *tempArray = (NSMutableArray *)[[NSUserDefaults standardUserDefaults] objectForKey:NEWS];
    
    for (NSString *_id in tempArray) {
        
        [newsRead addObject:_id];
    }
}

- (void) createTextData {

    title.text = news.nTitle;
    description.text = news.nDesc;

    if (![newsRead containsObject:news._id]) {
        
        description.textColor = [UIColor grayColor];
        
    } else {

        description.textColor = [UIColor lightGrayColor];
        title.textColor = [UIColor grayColor];
    }
}

- (void) layoutSubviews {
    
    [super layoutSubviews];
    
    CGRect contentRect = self.contentView.bounds;
    CGRect frame;
    
    //x,y,width,height
    
    frame = CGRectMake(15.0, 10, contentRect.size.width - 30.0, 25);
    title.frame = frame;
    
    frame = CGRectMake(15.0, 40, contentRect.size.width - 30.0, NUMBER_OF_LINES*18);
    description.frame = frame;
}

@end
