//
//  ViewEchartsController.m
//  JSCTool
//
//  Created by zuosen on 2019/4/25.
//  Copyright © 2019 jsc. All rights reserved.
//

#import "ViewEchartsController.h"
#import "iOS-Echarts.h"

@interface ViewEchartsController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) PYZoomEchartsView *kEchartView;

@end

@implementation ViewEchartsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Echarts";
    
    [self creatScrollView];
    
    [self showLineDemo];
    
    [self.kEchartView loadEcharts];
    
}

- (void)creatScrollView{
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 100, kScreenWidth , 400)];
    [self.view addSubview:self.scrollView];
    self.scrollView.delegate = self;
    self.scrollView.contentSize = CGSizeMake(kScreenWidth * 2, 0);
    self.scrollView.showsHorizontalScrollIndicator = NO;
}

-(void)showLineDemo {
    
    /** 图表选项 */
    PYOption *option = [[PYOption alloc] init];
    //是否启用拖拽重计算特性，默认关闭
    option.calculable = NO;
    //数值系列的颜色列表(折线颜色)
    option.color = @[@"#20BCFC", @"#ff6347"];
    // 图标背景色
    // option.backgroundColor = [[PYColor alloc] initWithColor:[UIColor orangeColor]];
    PYTitle *title = [[PYTitle alloc] init];
    title.subtext = @"订单数";
    title.y = @-20;
    option.title = title;
    
    /** 提示框 */
    PYTooltip *tooltip = [[PYTooltip alloc] init];
    // 触发类型 默认数据触发
    tooltip.trigger = @"axis";
    
    // 竖线宽度
    tooltip.axisPointer.lineStyle.width = @1;
    // 提示框 文字样式设置
    tooltip.textStyle = [[PYTextStyle alloc] init];
    tooltip.textStyle.fontSize = @12;
    // 提示框 显示自定义
    // tooltip.formatter = @"(function(params){ var res = params[0].name; for (var i = 0, l = params.length; i < l; i++) {res += '<br/>' + params[i].seriesName + ' : ' + params[i].value;}; return res})";
    // 添加到图标选择中
    option.tooltip = tooltip;
    
    
    /** 图例 */
    PYLegend *legend = [[PYLegend alloc] init];
    // 设置数据
    legend.data = @[@"挂牌价",@"成交价"];
    
    // 添加到图标选择中
    option.legend = legend;
    
    
    /** 直角坐标系内绘图网格, 说明见下图 */
    PYGrid *grid = [[PYGrid alloc] init];
    // 左上角位置
    grid.x = @(45);
    grid.y = @(20);
    // 右下角位置
    grid.x2 = @(20);
    grid.y2 = @(30);
    grid.borderWidth = @(0);
    
    // 添加到图标选择中
    option.grid = grid;
    
    /** X轴设置 */
    PYAxis *xAxis = [[PYAxis  alloc] init];
    //横轴默认为类目型(就是坐标自己设置)
    xAxis.type = @"category";
    // 起始和结束两端空白
    xAxis.boundaryGap = @(YES);
    // 分隔线
    xAxis.splitLine.show = NO;
    // 坐标轴线
    xAxis.axisLine.show = NO;
    // X轴坐标数据
    xAxis.data = @[@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11", @"13" , @"14" , @"15" , @"16" , @"17" , @"18" , @"19" , @"20" , @"21" , @"22" , @"23" , @"24" , @"25" , @"26" , @"27" , @"28" , @"29" , @"30" ];
    // 坐标轴小标记
    xAxis.axisTick = [[PYAxisTick alloc] init];
    xAxis.axisTick.show = YES;
    
    // 添加到图标选择中
    option.xAxis = [[NSMutableArray alloc] initWithObjects:xAxis, nil];
    
    
    /** Y轴设置 */
    PYAxis *yAxis = [[PYAxis alloc] init];
    yAxis.axisLine.show = NO;
    // 纵轴默认为数值型(就是坐标系统生成), 改为 @"category" 会有问题, 读者可以自行尝试
    yAxis.type = @"value";
    // 分割段数，默认为5
    yAxis.splitNumber = @4;
    // 分割线类型
    // yAxis.splitLine.lineStyle.type = @"dashed";   //'solid' | 'dotted' | 'dashed' 虚线类型
    
    //单位设置,  设置最大值, 最小值
    // yAxis.axisLabel.formatter = @"{value} k";
    // yAxis.max = @9000;
    // yAxis.min = @5000;
    
    
    // 添加到图标选择中  ( y轴更多设置, 自行查看官方文档)
    option.yAxis = [[NSMutableArray alloc] initWithObjects:yAxis, nil];
    
    
    /** 定义坐标点数组 */
    NSMutableArray *seriesArr = [NSMutableArray array];
    
    /** 第一条折线设置 */
    PYCartesianSeries *series1 = [[PYCartesianSeries alloc] init];
    series1.name = @"挂牌价";
    // 类型为折线
    series1.type = @"line";
    // 曲线平滑
    // series1.smooth = YES;
    // 坐标点大小
    series1.symbolSize = @(1.5);
    // 坐标点样式, 设置连线的宽度
    series1.itemStyle = [[PYItemStyle alloc] init];
    series1.itemStyle.normal = [[PYItemStyleProp alloc] init];
    series1.itemStyle.normal.lineStyle = [[PYLineStyle alloc] init];
    series1.itemStyle.normal.lineStyle.width = @(1.5);
    // 添加坐标点 y 轴数据 ( 如果某一点 无数据, 可以传 @"-" 断开连线 如 : @[@"7566", @"-", @"7571"]  )
    series1.data = @[@"7566", @"7619", @"7571", @"7670", @"7528", @"7640", @"7472", @"7800", @"8058", @"7972", @"7606", @"7710", @"7619", @"7571", @"7670", @"7528", @"7640", @"7472", @"7800", @"8058", @"7972", @"7606", @"7710", @"7619", @"7571", @"7670", @"7528", @"7640", @"7472", @"7800", @"8058", @"7972", @"7606", @"7710"];
    
    [seriesArr addObject:series1];
    
    /** 第二条折线设置 */
    PYCartesianSeries *series2 = [[PYCartesianSeries alloc] init];
    series2.name = @"成交价";
    series2.type = @"line";
    series2.symbolSize = @(1.5);
    series2.itemStyle = [[PYItemStyle alloc] init];
    series2.itemStyle.normal = [[PYItemStyleProp alloc] init];
    series2.itemStyle.normal.lineStyle = [[PYLineStyle alloc] init];
    series2.itemStyle.normal.lineStyle.width = @(1.5);
    series2.data = @[@"7066", @"7119", @"7471", @"7470", @"7228", @"7340", @"7402", @"7600", @"7858", @"7772", @"7506", @"7310", @"7119", @"7471", @"7470", @"7228", @"7340", @"7402", @"7600", @"7858", @"7772", @"7506", @"7310", @"7119", @"7471", @"7470", @"7228", @"7340", @"7402", @"7600", @"7858", @"7772", @"7506", @"7310"];
    [seriesArr addObject:series2];
    
    [option setSeries:seriesArr];
    
    
    
    /** 初始化图表 */
    self.kEchartView = [[PYZoomEchartsView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width * 2 , 300)];
    // 添加到 scrollView 上
    [self.scrollView addSubview:self.kEchartView];
    // 图表选项添加到图表上
    [self.kEchartView setOption:option];
    
    
}


@end
