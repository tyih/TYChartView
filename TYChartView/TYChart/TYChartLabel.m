//
//  TYChartLabel.m
//  TYChartView
//
//  Created by IGEN-TECH on 2017/12/20.
//  Copyright © 2017年 tianyao. All rights reserved.
//

#import "TYChartLabel.h"

#import "TYChartConst.h"

@implementation TYChartLabel

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setLineBreakMode:NSLineBreakByWordWrapping];
        [self setMinimumScaleFactor:5.0f];
        [self setNumberOfLines:1];
        [self setFont:[UIFont boldSystemFontOfSize:9.0f]];
        [self setTextColor: [UIColor darkGrayColor]];
        [self setTextAlignment:NSTextAlignmentCenter];
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = YES;
    }
    return self;
}

@end
