//
//  TYLineChart.m
//  TYChartView
//
//  Created by IGEN-TECH on 2017/12/19.
//  Copyright © 2017年 tianyao. All rights reserved.
//

#import "TYChartDraw.h"

#import "TYChartLabel.h"

static CGFloat const kChartLabelW = 30.f;
static CGFloat const kChartLabelH = 10.f;

static CGFloat const kChartViewBottom = 30.f;

@implementation TYChartDraw

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
    }
    return self;
}

- (void)setXValues:(NSArray *)xValues {
    
    _xValues = xValues;
}

- (void)setYValues:(NSArray *)yValues {
    
    _yValues = yValues;
    [self setYLabels:yValues];
}

- (void)setYLabels:(NSArray *)yLabels {
    
    CGFloat min = 0;
    CGFloat max = 0;
    
    for (NSArray *arr in yLabels) {
        for (NSString *vStr in arr) {
            CGFloat value = [vStr floatValue];
            if (value > max) {
                max = value;
            }
            if (value < min) {
                min = value;
            }
        }
    }
    _yValueMin = min;
    _yValueMax = max;
    
    CGFloat level = (_yValueMax - _yValueMin) * 0.25; // 最大最小差值平均
    CGFloat chartHeight = self.frame.size.height - kChartViewBottom - kChartLabelH * 0.5;
    CGFloat levelHeight = chartHeight * 0.25; // 间隔的高度
    
    // y轴水平值
    CGFloat yLabelFirstY = self.frame.size.height - kChartViewBottom - kChartLabelH * 0.5;
    for (int i=0; i<5; i++) {
        TYChartLabel *yLabel = [[TYChartLabel alloc] initWithFrame:CGRectMake(0, yLabelFirstY - i * levelHeight, kChartLabelW, kChartLabelH)];
        yLabel.text = [NSString stringWithFormat:@"%.2f", _yValueMin + i * level];
        [self addSubview:yLabel];
    }
    
    // 横线
    CGFloat yLineFirstY = self.frame.size.height - kChartViewBottom;
    for (int i=0; i<5; i++) {
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(kChartLabelW, yLineFirstY - i * levelHeight)];
        [path addLineToPoint:CGPointMake(self.frame.size.width, yLineFirstY - i * levelHeight)];
        shapeLayer.path = path.CGPath;
        shapeLayer.strokeColor = [[UIColor blackColor] colorWithAlphaComponent:0.1].CGColor;
        shapeLayer.lineWidth = 1.f;
        if (i != 0) { // 最底部实线
            [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:3], [NSNumber numberWithInt:3], nil]];
        }
        
        [self.layer addSublayer:shapeLayer];
    }
}

- (void)setXLabels:(NSArray *)xLabels {
    
    _xLabels = xLabels;
    CGFloat num = xLabels.count;
    BOOL isPartShow = NO;
    if (xLabels.count > 15) {
        isPartShow = YES; // 数据大于15个间隔显示
    } else if (xLabels.count <= 1) {
        num = 1.f;
    }
    _xTitleLabelWidth = (self.frame.size.width - kChartLabelW) / num;
    _xTitleValueMin = [xLabels.firstObject floatValue];
    _xTitleValueMax = [xLabels.lastObject floatValue];
    
    CGFloat chartHeight = self.frame.size.height - kChartViewBottom;
    for (int i=0; i<xLabels.count; i++) {
        
        NSString *xStr = xLabels[i];
        if (isPartShow) {
            if ([xStr integerValue] % 2 == 0) { // 部分显示
                continue;
            }
        }
        TYChartLabel *xLabel = [[TYChartLabel alloc] initWithFrame:CGRectMake(kChartLabelW * 0.5 + _xTitleLabelWidth * i, chartHeight + 10, kChartLabelW, kChartLabelH)];
        xLabel.text = xStr;
        [self addSubview:xLabel];
    }
}

- (void)strokeChartLine {
    
    for (int i=0; i<_yValues.count; i++) {
        NSArray *childYArray = _yValues[i];
        NSArray *childXArray = _xValues[i];
        if (childYArray.count == 0 || childXArray.count == 0 || childYArray.count != childXArray.count) {
            NSLog(@"xValues 或 yValues 出错");
            return;
        }
        
        CAShapeLayer *chartLine = [CAShapeLayer layer];
        chartLine.lineCap = kCALineCapRound;
        chartLine.lineJoin = kCALineJoinBevel;
        chartLine.fillColor = [UIColor whiteColor].CGColor;
        chartLine.lineWidth = 0.5f;
        chartLine.strokeEnd = 0.f;
        [self.layer addSublayer:chartLine];
        
        UIBezierPath *linePath = [UIBezierPath bezierPath];
        CGFloat xPosition = kChartLabelW; // 0 点
        
        CGFloat chartHeight = self.frame.size.height - kChartViewBottom - kChartLabelH * 0.5; // 图表高度
        CGFloat originY = self.frame.size.height - kChartViewBottom;
        NSInteger index = 0;
        for (NSString *valueStr in childYArray) {
            
            CGFloat gradeY = ([valueStr floatValue] - _yValueMin) / (_yValueMax - _yValueMin);
            CGFloat lineHeight = gradeY * chartHeight;
            
            CGFloat gradeX = ([childXArray[index] floatValue] - _xTitleValueMin) / (_xTitleValueMax - _xTitleValueMin);
            
            CGFloat lineWidth = gradeX * (self.frame.size.width - xPosition);
            CGPoint point = CGPointMake(xPosition + lineWidth, originY - lineHeight);
            
            [linePath addLineToPoint:point];
            [linePath moveToPoint:point];
            
            index ++;
        }
        
        chartLine.path = linePath.CGPath;
        chartLine.strokeColor = ((UIColor *)_colors[i]).CGColor;
        chartLine.strokeEnd = 1.f;
    }
}

- (void)strokeChartBar {
    
    for (int i=0; i<_yValues.count; i++) {
        NSArray *childYArray = _yValues[i];
        NSArray *childXArray = _xValues[i];
        if (childYArray.count == 0 || childXArray.count == 0 || childYArray.count != childXArray.count) {
            NSLog(@"xValues 或 yValues 出错");
            return;
        }

        UIBezierPath *barPath = [UIBezierPath bezierPath];
        CGFloat xPosition = kChartLabelW; // 0 点
        CGFloat originY = self.frame.size.height - kChartViewBottom;

        CGFloat chartHeight = self.frame.size.height - kChartViewBottom - kChartLabelH * 0.5; // 图表高度
        CGFloat barWidth = 20.f;
        for (int i=0; i<childXArray.count; i++) {
            
            CAShapeLayer *barLayer = [CAShapeLayer layer];
            
            NSString *yValueString = childYArray[i];
            CGFloat gradeY = ([yValueString floatValue] - _yValueMin) / (_yValueMax - _yValueMin);
            CGFloat barHeight = gradeY * chartHeight;

            NSString *xValueString = childXArray[i];
            CGFloat gradeX = ([xValueString floatValue] - _xTitleValueMin) / (_xTitleValueMax - _xTitleValueMin);
            CGFloat barXlength = gradeX * (self.frame.size.width - xPosition);
            
            [barPath moveToPoint:CGPointMake(xPosition + barXlength - barWidth * 0.5, originY)];
            [barPath addLineToPoint:CGPointMake(xPosition + barXlength - barWidth * 0.5, originY - barHeight)];
            [barPath addLineToPoint:CGPointMake(xPosition + barXlength + barWidth * 0.5, originY - barHeight)];
            [barPath addLineToPoint:CGPointMake(xPosition + barXlength + barWidth * 0.5, originY)];
            
            barLayer.path = barPath.CGPath;
            barLayer.fillColor = [UIColor redColor].CGColor;
            [self.layer addSublayer:barLayer];
        }
    }
}

- (void)setColors:(NSArray *)colors {
    
    _colors = colors;
}

@end
