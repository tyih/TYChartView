//
//  ViewController.m
//  TYChartView
//
//  Created by IGEN-TECH on 2017/12/19.
//  Copyright © 2017年 tianyao. All rights reserved.
//

#import "ViewController.h"

#import "TYChart.h"

@interface ViewController () <TYChartDataSource> {
    
    TYChart *_chartView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _chartView = [[TYChart alloc] initWithFrame:CGRectMake(10, 104, SCREEN_WIDTH - 20, 520) dataSource:self style:TYChartStyleLine];
    _chartView.backgroundColor = [UIColor yellowColor];
    [_chartView showInView:self.view];
}

#pragma mark - TYChartDataSource @required

/// 横坐标标题数组
- (NSArray *)chartConfigAxisXLabel:(TYChart *)chart {
    
    NSMutableArray *xTitles = [NSMutableArray array];
    for (int i=1; i<32; i++) {
        NSString *str = [NSString stringWithFormat:@"%d", i];
        [xTitles addObject:str];
    }
    return xTitles;
}

/// y数值多重数组
- (NSArray *)chartConfigAxisYValue:(TYChart *)chart {
    
    NSArray *valueArr1 = @[@"1", @"13", @"16.25", @"22", @"15", @"13", @"46", @"35", @"53", @"65", @"7"];
    return @[valueArr1];
}

/// x数值多重数组
- (NSArray *)chartConfigAxisXValue:(TYChart *)chart {
    
    NSArray *valueArr1 = @[@"3", @"12", @"12.3", @"13", @"25", @"33", @"46", @"55", @"63", @"75", @"87"];
    return @[valueArr1];
}

/// 折线颜色
- (NSArray *)chartConfigColors:(TYChart *)chart {
    
    UIColor *color1 = [UIColor blackColor];
    return @[color1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
