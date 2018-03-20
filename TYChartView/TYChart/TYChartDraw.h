//
//  TYLineChart.h
//  TYChartView
//
//  Created by IGEN-TECH on 2017/12/19.
//  Copyright © 2017年 tianyao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TYChartDraw : UIView

/// x轴标题数组
@property (nonatomic, strong) NSArray *xLabels;
/// y轴标题数组
@property (nonatomic, strong) NSArray *yLabels;

/// y坐标值数组
@property (nonatomic, strong) NSArray *yValues;
/// y坐标最小值
@property (nonatomic, assign) CGFloat yValueMin;
/// y坐标最大值
@property (nonatomic, assign) CGFloat yValueMax;
/// x坐标值数组
@property (nonatomic, strong) NSArray *xValues;

/// x轴标题Label宽度
@property (nonatomic, assign) CGFloat xTitleLabelWidth;
/// x轴标题最小值
@property (nonatomic, assign) CGFloat xTitleValueMin;
/// x轴标题最大值
@property (nonatomic, assign) CGFloat xTitleValueMax;

@property (nonatomic, strong) NSArray *colors;

/// 线
- (void)strokeChartLine;

/// 柱状图
- (void)strokeChartBar;

@end
