//
//  SportsCustomTVCell.m
//  NEFS
//
//  Created by Stephen Sowole on 15/07/2014.
//  Copyright (c) 2014 Stephen Sowole. All rights reserved.
//

#import "SportsCustomTVCell.h"

#define SEPERATOR_HEIGHT 9
#define RIGHT_SHIFT 130

#define RIGHT_WDL_SHIFT 200

#define TITLE_HEIGHT 24
#define POSITION_HEIGHT 55
#define WDL_HEIGHT 94

#define SPORTS_TITLE_SIZE 19
#define POSITION_TITLE_SIZE 17
#define WDL_LABEL_FONT_SIZE 14

@implementation SportsCustomTVCell {

    UILabel *winLabel, *drawLabel, *lossLabel;
    UIImageView *winImg, *drawImg, *lossImg;

    UILabel *positionLabel;
    UILabel *teamName;
    UILabel *sportTitle;
    UILabel *positionSuffix;
}

@synthesize team;

- (id) initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier]) {
        
        drawLabel = [[UILabel alloc]init];
        drawLabel.textAlignment = NSTextAlignmentCenter;
        drawLabel.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:WDL_LABEL_FONT_SIZE];
        drawLabel.textColor = [UIColor whiteColor];
        
        winLabel = [[UILabel alloc]init];
        winLabel.textAlignment = NSTextAlignmentCenter;
        winLabel.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:WDL_LABEL_FONT_SIZE];
        winLabel.textColor = [UIColor whiteColor];
        
        lossLabel = [[UILabel alloc]init];
        lossLabel.textAlignment = NSTextAlignmentCenter;
        lossLabel.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:WDL_LABEL_FONT_SIZE];
        lossLabel.textColor = [UIColor whiteColor];
        
        winImg = [[UIImageView alloc] init];
        drawImg = [[UIImageView alloc] init];
        lossImg = [[UIImageView alloc] init];
        
        [self.contentView addSubview:winImg];
        [self.contentView addSubview:drawImg];
        [self.contentView addSubview:lossImg];
        
        [self.contentView addSubview:drawLabel];
        [self.contentView addSubview:winLabel];
        [self.contentView addSubview:lossLabel];
        
        positionLabel = [[UILabel alloc]init];
        positionLabel.textAlignment = NSTextAlignmentRight;
        positionLabel.font = [UIFont systemFontOfSize:32];
        
        sportTitle = [[UILabel alloc]init];
        sportTitle.textAlignment = NSTextAlignmentLeft;
        sportTitle.font = [UIFont systemFontOfSize:16];//18];
        
        teamName = [[UILabel alloc]init];
        teamName.textAlignment = NSTextAlignmentLeft;
        teamName.font = [UIFont systemFontOfSize:16];
        teamName.textColor = [UIColor grayColor];
        
        positionSuffix = [[UILabel alloc]init];
        positionSuffix.textAlignment = NSTextAlignmentLeft;
        positionSuffix.font = [UIFont systemFontOfSize:14];
        positionSuffix.textColor = [UIColor grayColor];
        
        [self.contentView addSubview:positionLabel];
        [self.contentView addSubview:teamName];
        [self.contentView addSubview:sportTitle];
        [self.contentView addSubview:positionSuffix];
    
        [self setSeperators];
    }
    return self;
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
    
    frame = CGRectMake(0, 0, SEPERATOR_HEIGHT, SPORTS_CELL_HEIGHT);
    seperator.frame = frame;
    
    [self.contentView addSubview:seperator];
    
    
    seperator = [[UIImageView alloc] init];
    seperator.image = [UIImage imageNamed:@"Seperator"];
    
    frame = CGRectMake(320-SEPERATOR_HEIGHT, 0, SEPERATOR_HEIGHT, SPORTS_CELL_HEIGHT);
    seperator.frame = frame;
    
    [self.contentView addSubview:seperator];
    
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = [UIColor colorWithRed:230.0/250.0 green:230.0/250.0 blue:230.0/250.0 alpha:1.0];
    
    [self setSelectedBackgroundView: bgColorView];
}

- (void) createTextData {
    
   // if (sport.sTeams.count == 1) {
        
    [self addExtraInfo];
        
   // }
    
    [self setWinImageColour];
    [self setDrawImageColour];
    [self setLossImageColour];
}

- (void) setWinImageColour {
    
    UIImage *image = [UIImage imageNamed:MAIN_EVENT_TYPE_ICON];
    
    CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClipToMask(context, rect, image.CGImage);
    CGContextSetFillColorWithColor(context, [[UIColor colorWithRed:0.51 green:0.76 blue:0.55 alpha:1.0] CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImage *flippedImage = [UIImage imageWithCGImage:img.CGImage
                                                scale:1.0 orientation: UIImageOrientationDownMirrored];
    
    winImg.image = flippedImage;
}

- (void) setDrawImageColour {
    
    UIImage *image = [UIImage imageNamed:MAIN_EVENT_TYPE_ICON];
    
    CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClipToMask(context, rect, image.CGImage);
    CGContextSetFillColorWithColor(context, [[UIColor colorWithRed:0.83 green:0.74 blue:0.56 alpha:1.0] CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImage *flippedImage = [UIImage imageWithCGImage:img.CGImage
                                                scale:1.0 orientation: UIImageOrientationDownMirrored];
    
    drawImg.image = flippedImage;
}

- (void) setLossImageColour {
    
    UIImage *image = [UIImage imageNamed:MAIN_EVENT_TYPE_ICON];
    
    CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClipToMask(context, rect, image.CGImage);
    CGContextSetFillColorWithColor(context, [[UIColor colorWithRed:0.93 green:0.61 blue:0.61 alpha:1.0] CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImage *flippedImage = [UIImage imageWithCGImage:img.CGImage
                                                scale:1.0 orientation: UIImageOrientationDownMirrored];
    
    lossImg.image = flippedImage;
}

- (void) addExtraInfo {

    if ([team.sWin isEqualToString:@"1"]) {
        
        winLabel.text = [NSString stringWithFormat:@"%@ win", team.sWin];
        
    } else {
        
        winLabel.text = [NSString stringWithFormat:@"%@ wins", team.sWin];
    }
    
    if ([team.sDraw isEqualToString:@""]) {
        
        drawLabel.text = @"";
        drawImg.hidden = YES;
        
    } else if ([team.sDraw isEqualToString:@"1"]) {
        
        drawLabel.text = [NSString stringWithFormat:@"%@ draw", team.sDraw];
        
    } else {
        
        drawLabel.text = [NSString stringWithFormat:@"%@ draws", team.sDraw];
    }
    
    if ([team.sLoss isEqual:@"1"]) {
        
        lossLabel.text = [NSString stringWithFormat:@"%@ loss", team.sLoss];
        
    } else {
        
        lossLabel.text = [NSString stringWithFormat:@"%@ losses", team.sLoss];
    }

    if ([team.sPosition isEqualToString:@"1"]) {
        
        positionSuffix.text = @"st";
        
    } else if ([team.sPosition isEqualToString:@"2"]) {
        
        positionSuffix.text = @"nd";
        
    } else if ([team.sPosition isEqualToString:@"3"]) {
    
        positionSuffix.text = @"rd";
        
    } else {
        
        positionSuffix.text = @"th";
    }
    
    positionLabel.text = [NSString stringWithFormat:@"%@", team.sPosition];
    teamName.text = [NSString stringWithFormat:@"%@", team.sSport];
    sportTitle.text = [NSString stringWithFormat:@"%@", team.sName];
}

- (void) layoutSubviews {
    
    [super layoutSubviews];
    
    CGRect contentRect = self.contentView.bounds;
    CGRect frame;
    
    //x,y,width,height
    
    frame = CGRectMake(contentRect.size.width/2 - 35, WDL_HEIGHT, 70, 26);
    drawLabel.frame = frame;
    
    if (![drawLabel.text isEqualToString:@""]) {
    
        frame = CGRectMake(contentRect.size.width/4.5 - 35, WDL_HEIGHT, 70, 26);
        winLabel.frame = frame;
    
        frame = CGRectMake((contentRect.size.width/4.5) * 3.5 - 35, WDL_HEIGHT, 70, 26);
        lossLabel.frame = frame;
        
    } else {
        
        frame = CGRectMake(contentRect.size.width/3 - 35, WDL_HEIGHT, 70, 26);
        winLabel.frame = frame;
        
        frame = CGRectMake((contentRect.size.width/3) * 2 - 35, WDL_HEIGHT, 70, 26);
        lossLabel.frame = frame;
    }

    drawImg.frame = drawLabel.frame;
    winImg.frame = winLabel.frame;
    lossImg.frame = lossLabel.frame;
    
    frame = CGRectMake(35, 40, 40, 25);
    positionLabel.frame = frame;
    
    frame = CGRectMake(RIGHT_SHIFT, 25, 166, 25);
    sportTitle.frame = frame;
    
    frame = CGRectMake(RIGHT_SHIFT, 55, 166, 25);
    teamName.frame = frame;
    
    frame = CGRectMake(80, 35, 15, 25);
    positionSuffix.frame = frame;
}

@end

