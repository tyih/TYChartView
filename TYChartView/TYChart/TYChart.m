//
//  TYChart.m
//  TYChartView
//
//  Created by IGEN-TECH on 2017/12/19.
//  Copyright © 2017年 tianyao. All rights reserved.
//

#import "TYChart.h"

#import "TYChartDraw.h"

typedef NS_ENUM(NSUInteger, TYChartDateType) {
    TYChartDateTypeDay = 100,
    TYChartDateTypeMonth,
    TYChartDateTypeYear,
    TYChartDateTypeTotal
};

static CGFloat const kChartHeaderH = 160.f;

static CGFloat const kDateButtonH = 30.f;

@interface TYChart ()

@property (nonatomic, weak) id <TYChartDataSource> dataSource;

@property (nonatomic, strong) TYChartDraw *lineChart;

@property (nonatomic, strong) TYChartDraw *barChart;

@property (nonatomic, weak) UIButton *preDateButton;

@end

@implementation TYChart

- (instancetype)initWithFrame:(CGRect)rect dataSource:(id<TYChartDataSource>)dataSource style:(TYChartStyle)style {
    
    self.dataSource = dataSource;
    self.chartStyle = style;
    return [self initWithFrame:rect];
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.clipsToBounds = NO;
    }
    return self;
}

- (void)showInView:(UIView *)view {
    
    [self setUpDate];
    [self setUpChart];
    [view addSubview:self];
}

- (void)setUpDate {
    
    CGFloat buttonWidth = self.frame.size.width * 0.25;
    
    UIButton *dayBtn = [self dateButtonWithTitle:@"日" buttonType:TYChartDateTypeDay x:0 y:0 width:buttonWidth];
    [self addSubview:dayBtn];
    UIButton *monthBtn = [self dateButtonWithTitle:@"月" buttonType:TYChartDateTypeMonth x:buttonWidth y:0 width:buttonWidth];
    [self addSubview:monthBtn];
    UIButton *yearBtn = [self dateButtonWithTitle:@"年" buttonType:TYChartDateTypeYear x:buttonWidth * 2 y:0 width:buttonWidth];
    [self addSubview:yearBtn];
    UIButton *totalBtn = [self dateButtonWithTitle:@"总" buttonType:TYChartDateTypeTotal x:buttonWidth * 3 y:0 width:buttonWidth];
    [self addSubview:totalBtn];
}

- (UIButton *)dateButtonWithTitle:(NSString *)title buttonType:(TYChartDateType)buttonType x:(CGFloat)x y:(CGFloat)y width:(CGFloat)width {
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(x, y, width, kDateButtonH)];
    button.tag = buttonType;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
    button.selected = NO;
    [button addTarget:self action:@selector(dateButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    if (buttonType != TYChartDateTypeTotal) {
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(width, 3, 0.5, kDateButtonH - 6)];
        line.backgroundColor = [UIColor lightGrayColor];
        [button addSubview:line];
    }
    
    return button;
}

- (IBAction)dateButtonDidClicked:(UIButton *)button {
    
    self.preDateButton.selected = NO;
    button.selected = YES;
    
    TYChartDateType type = button.tag;
    switch (type) {
        case TYChartDateTypeDay:
            NSLog(@"TYChartDateTypeDay");
            break;
        case TYChartDateTypeMonth:
            NSLog(@"TYChartDateTypeMonth");
            break;
        case TYChartDateTypeYear:
            NSLog(@"TYChartDateTypeYear");
            break;
        case TYChartDateTypeTotal:
            NSLog(@"TYChartDateTypeTotal");
            break;
            
        default:
            break;
    }
    
    self.preDateButton = button;
}

- (void)setUpChart {
    
    switch (self.chartStyle) {
        case TYChartStyleLine: { // 折线
            
            if (!_lineChart) {
                _lineChart = [[TYChartDraw alloc] initWithFrame:CGRectMake(0, kChartHeaderH, self.frame.size.width, self.frame.size.height - kChartHeaderH)];
                [self addSubview:_lineChart];
                _lineChart.backgroundColor = [UIColor greenColor];
            }
            
            // x轴标题
            if ([self.dataSource respondsToSelector:@selector(chartConfigAxisXLabel:)]) {
                [_lineChart setXLabels:[self.dataSource chartConfigAxisXLabel:self]];
            }
            
            // y轴及坐标值
            if ([self.dataSource respondsToSelector:@selector(chartConfigAxisYValue:)]) {
                [_lineChart setYValues:[self.dataSource chartConfigAxisYValue:self]];
            }
            
            // x坐标值
            if ([self.dataSource respondsToSelector:@selector(chartConfigAxisXValue:)]) {
                [_lineChart setXValues:[self.dataSource chartConfigAxisXValue:self]];
            }
            
            // 折线颜色
            if ([self.dataSource respondsToSelector:@selector(chartConfigColors:)]) {
                [_lineChart setColors:[self.dataSource chartConfigColors:self]];
            }
            
            // 画线
            [_lineChart strokeChartLine];
        }
            
            break;
        case TYChartStyleBar: { // 柱状图
            
            if (!_barChart) {
                _barChart = [[TYChartDraw alloc] initWithFrame:CGRectMake(0, kChartHeaderH, self.frame.size.width, self.frame.size.height - kChartHeaderH)];
                [self addSubview:_barChart];
                _barChart.backgroundColor = [UIColor greenColor];
            }
            
            // x轴标题
            if ([self.dataSource respondsToSelector:@selector(chartConfigAxisXLabel:)]) {
                [_barChart setXLabels:[self.dataSource chartConfigAxisXLabel:self]];
            }
            
            // y轴及坐标值
            if ([self.dataSource respondsToSelector:@selector(chartConfigAxisYValue:)]) {
                [_barChart setYValues:[self.dataSource chartConfigAxisYValue:self]];
            }
            
            // x坐标值
            if ([self.dataSource respondsToSelector:@selector(chartConfigAxisXValue:)]) {
                [_barChart setXValues:[self.dataSource chartConfigAxisXValue:self]];
            }
            
            // 柱状图
            [_barChart strokeChartBar];
        }
            
            break;
            
        default:
            break;
    }
}

@end
