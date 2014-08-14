//
//  InfoCell.m
//  NEFS
//
//  Created by Stephen Sowole on 14/08/2014.
//  Copyright (c) 2014 Stephen Sowole. All rights reserved.
//

#import "InfoCell.h"

#define TITLE_SIZE 17
#define SEPERATOR_HEIGHT 9

@implementation InfoCell {
    
    UILabel *title;
}

- (id) initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier]) {
        
        title = [[UILabel alloc]init];
        title.textAlignment = NSTextAlignmentLeft;
        title.font = [UIFont fontWithName:@"TrebuchetMS" size:TITLE_SIZE];

        [self.contentView addSubview:title];
        
        [self setSeperators];
    }
    
    return self;
}

- (void) addArrow {
    
    CGRect contentRect = self.contentView.bounds;
    CGRect frame;
    
    UIImageView *img = [[UIImageView alloc] init];
    img.image = [UIImage imageNamed:@"TableViewArrow"];
    
    //x,y,width,height
    
    frame = CGRectMake(contentRect.size.width - 44.0, 16, 35, 35);
    img.frame = frame;
    
    [self.contentView addSubview:img];
}

- (void) layoutSubviews {
    
    [super layoutSubviews];
    
    CGRect contentRect = self.contentView.bounds;
    CGRect frame;
    
    //x,y,width,height
    
    frame = CGRectMake(20.0, 20, contentRect.size.width - 35.0, 25);
    title.frame = frame;
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
    
    frame = CGRectMake(0, 0, SEPERATOR_HEIGHT, INFO_ROW_HEIGHT);
    seperator.frame = frame;
    
    [self.contentView addSubview:seperator];
    
    
    seperator = [[UIImageView alloc] init];
    seperator.image = [UIImage imageNamed:@"Seperator"];
    
    frame = CGRectMake(320-SEPERATOR_HEIGHT, 0, SEPERATOR_HEIGHT, INFO_ROW_HEIGHT);
    seperator.frame = frame;
    
    [self.contentView addSubview:seperator];
    
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = [UIColor colorWithRed:230.0/250.0 green:230.0/250.0 blue:230.0/250.0 alpha:1.0];
    
    [self setSelectedBackgroundView: bgColorView];
}

- (void) setTitle:(NSString *)labelText {
    
    title.text = labelText;
}

@end
