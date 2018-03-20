//
//  TYChartConst.h
//  TYChartView
//
//  Created by IGEN-TECH on 2017/12/19.
//  Copyright © 2017年 tianyao. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SCREEN_WIDTH    [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT   [UIScreen mainScreen].bounds.size.height

struct Range {
    CGFloat max;
    CGFloat min;
};

typedef struct Range CGRange;

CG_INLINE CGRange CGRangeMake(CGFloat max, CGFloat min);

CG_INLINE CGRange CGRangeMake(CGFloat max, CGFloat min) {
    
    CGRange p;
    p.max = max;
    p.min = min;
    return p;
}

static const CGRange CGRangeZero = {0, 0};
