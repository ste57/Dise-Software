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

#define SEPERATOR_HEIGHT 5//7//9

@implementation NewsCell {
    
    UILabel *title;
    UILabel *description;
    UILabel *dateCreated;
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
        
        dateCreated = [[UILabel alloc] init];
        dateCreated.textAlignment = NSTextAlignmentLeft;
        dateCreated.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:DESCRIPTION_SIZE-2];
        
        [self.contentView addSubview:description];
        [self.contentView addSubview:title];
        [self.contentView addSubview:dateCreated];
        
        [self setSeperators];
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
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"d/MM/yyyy HH:mm"];

    NSDate *date = [dateFormat dateFromString:news.dateCreated];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"d/MM/YYYY";
    
    dateCreated.text = [formatter stringFromDate:date];
    

    if (![newsRead containsObject:news._id]) {
        
        description.textColor = [UIColor grayColor];
        dateCreated.textColor = [UIColor colorWithRed:(TAB_COLOUR_R)/255.0 green:(TAB_COLOUR_G)/255.0 blue:(TAB_COLOUR_B)/255.0 alpha:1.0];
        
    } else {

        description.textColor = [UIColor lightGrayColor];
        title.textColor = [UIColor grayColor];
        dateCreated.textColor = [UIColor colorWithRed:0.73 green:0.70 blue:0.82 alpha:1.0];
    }
}

- (void) layoutSubviews {
    
    [super layoutSubviews];
    
    CGRect contentRect = self.contentView.bounds;
    CGRect frame;
    
    //x,y,width,height
    
    frame = CGRectMake(20.0, 20, contentRect.size.width - 35.0, 25);
    title.frame = frame;
    
    frame = CGRectMake(20.0, 47, contentRect.size.width - 35.0, 25);
    dateCreated.frame = frame;
    
    frame = CGRectMake(20.0, 75, contentRect.size.width - 35.0, NUMBER_OF_LINES*18);
    description.frame = frame;

}

- (void) setSeperators {
    
    UIImageView *seperator;
    CGRect frame;
    
    seperator = [[UIImageView alloc] init];
    seperator.image = [UIImage imageNamed:@"Seperator"];
    
    frame = CGRectMake(0, 0, 320, SEPERATOR_HEIGHT);
    seperator.frame = frame;
    
    [self.contentView addSubview:seperator];
    
    
    seperator = [[UIImageView alloc] init];
    seperator.image = [UIImage imageNamed:@"Seperator"];
    
    frame = CGRectMake(0, 0, SEPERATOR_HEIGHT, NEWS_ROW_HEIGHT);
    seperator.frame = frame;
    
    [self.contentView addSubview:seperator];
    
    
    seperator = [[UIImageView alloc] init];
    seperator.image = [UIImage imageNamed:@"Seperator"];
    
    frame = CGRectMake(320-SEPERATOR_HEIGHT, 0, SEPERATOR_HEIGHT, NEWS_ROW_HEIGHT);
    seperator.frame = frame;
    
    [self.contentView addSubview:seperator];
    
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = [UIColor colorWithRed:230.0/250.0 green:230.0/250.0 blue:230.0/250.0 alpha:1.0];
    
    [self setSelectedBackgroundView: bgColorView];
}

@end
