//
//  TYChart.h
//  TYChartView
//
//  Created by IGEN-TECH on 2017/12/19.
//  Copyright © 2017年 tianyao. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TYChartConst.h"

typedef NS_ENUM(NSUInteger, TYChartStyle) {
    TYChartStyleLine = 0,
    TYChartStyleBar
};

@class TYChart;
@protocol TYChartDataSource <NSObject>

@required
/// 横坐标标题数组
- (NSArray *)chartConfigAxisXLabel:(TYChart *)chart;

/// x数值多重数组
- (NSArray *)chartConfigAxisXValue:(TYChart *)chart;

/// y数值多重数组
- (NSArray *)chartConfigAxisYValue:(TYChart *)chart;

@optional
/// 颜色数组
- (NSArray *)chartConfigColors:(TYChart *)chart;

/// 显示数值范围
- (CGRange)chartRange:(TYChart *)chart;

#pragma mark - 折线专属功能
/// 标记数值区域
- (CGRange)chartHighlightRangeInLine:(TYChart *)chart;

/// 判断显示横线条
- (BOOL)chart:(TYChart *)chart showHorizonLineAtIndex:(NSInteger)index;

/// 判断显示最大最小值
- (BOOL)chart:(TYChart *)chart showMaxMinAtIndex:(NSInteger)index;

@end

@interface TYChart : UIView

@property (nonatomic, assign) TYChartStyle chartStyle;

- (instancetype)initWithFrame:(CGRect)rect dataSource:(id <TYChartDataSource>)dataSource style:(TYChartStyle)style;

- (void)showInView:(UIView *)view;

@end
