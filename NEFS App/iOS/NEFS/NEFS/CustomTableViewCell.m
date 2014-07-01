//
//  CustomTableViewCell.m
//  NEFS
//
//  Created by Stephen Sowole on 24/06/2014.
//  Copyright (c) 2014 Stephen Sowole. All rights reserved.
//

#import "CustomTableViewCell.h"

@implementation CustomTableViewCell {
    
    UILabel *mainLabel;
    UILabel *timeLabel;
    UIImageView *icon;
    
    UILabel *goingLabel;
}

@synthesize event,eId;

- (id) initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier]) {
        
        // Initialization code
        mainLabel = [[UILabel alloc]init];

        //primaryLabel.textAlignment = UITextAlignmentCenter;
        mainLabel.textAlignment = UITextAlignmentLeft;
        mainLabel.font = [UIFont systemFontOfSize:15];
        
        timeLabel = [[UILabel alloc]init];

        timeLabel.textAlignment = UITextAlignmentLeft;
        timeLabel.font = [UIFont systemFontOfSize:12];
        
        icon = [[UIImageView alloc]init];
   
        
        
        
        
       /* goingLabel = [[UILabel alloc] init];
        goingLabel.textAlignment = UITextAlignmentCenter;
        goingLabel.font = [UIFont systemFontOfSize:11];
        goingLabel.textColor = [UIColor blueColor];
        goingLabel.text = @"going";
        [self.contentView addSubview:goingLabel];*/
        
        
        
        
        [self.contentView addSubview:mainLabel];
        [self.contentView addSubview:timeLabel];
        [self.contentView addSubview:icon];
        
        
        
        
        
                
        
    }
    return self;
}

- (void) createTextData {
    
    eId = event._id;
    mainLabel.text = event.eTitle;
    timeLabel.text = event.eStart;
    icon.image = [UIImage imageNamed:[event getIconName]];
}

- (void) layoutSubviews {
    
    [super layoutSubviews];
    
    CGRect contentRect = self.contentView.bounds;
    CGFloat boundsX = contentRect.origin.x;
    CGRect frame;
    
    //x,y,width,height
    
    frame = CGRectMake(contentRect.size.width - 50, 9, 30, 30);
    icon.frame = frame;
    
    
    frame= CGRectMake(boundsX+15 ,5, 200, 25);
    mainLabel.frame = frame;
    
    
    frame= CGRectMake(boundsX+15 ,29, 180, 25);
    timeLabel.frame = frame;
    
    
    /*frame = CGRectMake(boundsX+80, 10, 200, 25);
    goingLabel.frame = frame;*/
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
