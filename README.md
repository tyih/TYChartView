# TYChartView

## 折线图

### 用法：

* 创建 TYChart 添加到视图上
* 实现 TYChartDataSource 方法：x轴坐标标题、x轴数值数组及对应的y轴数值数组，颜色数组...
```
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _chartView = [[TYChart alloc] initWithFrame:CGRectMake(10, 104, SCREEN_WIDTH - 20, 520) dataSource:self style:TYChartStyleLine];
    _chartView.backgroundColor = [UIColor yellowColor];
    [_chartView showInView:self.view];
}

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
```
