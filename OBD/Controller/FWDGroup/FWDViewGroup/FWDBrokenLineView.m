//
//  FWDBrokenLineView.m
//  OBD
//
//  Created by 苏沫离 on 2017/5/8.
//  Copyright © 2017年 苏沫离. All rights reserved.
//

#import "FWDBrokenLineView.h"

@interface FWDBrokenLineView()
<PNChartDelegate>

{
    BrokenLineType _lineType;
}

@property (nonatomic ,strong) UILabel *titleLable;
@property (nonatomic ,strong) UIImageView *logoImageView;
@property (nonatomic ,strong) UILabel *valueLable;

@property (nonatomic ,strong) PNLineChart *chartView;
@property (nonatomic ,strong) NSMutableArray *dataArray;

@end

@implementation FWDBrokenLineView

- (instancetype)initWithFrame:(CGRect)frame Type:(BrokenLineType)lineType
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        _lineType = lineType;
        
        self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.12];
        
        self.layer.borderWidth = 1;
        self.layer.borderColor = [UIColor whiteColor].CGColor;
        
        [self addSubview:self.titleLable];
        [self addSubview:self.logoImageView];
        [self addSubview:self.valueLable];
        [self addSubview:self.chartView];
        
        if (lineType == BrokenLineTypeEngine)
        {
            [self addEngineObserverEvent];
        }
        else if (lineType == BrokenLineTypeThrottle)
        {
            [self addThrottleObserverEvent];
        }
        
        
        [self setAttributeText:@"20.0"];

    }
    
    return self;
}

- (UILabel *)titleLable
{
    if (_titleLable == nil)
    {
        UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, CGRectGetWidth(self.frame), 20)];
        lable.textAlignment = NSTextAlignmentCenter;
        lable.font = [UIFont systemFontOfSize:15];
        lable.textColor = [UIColor whiteColor];
        
        
        if (_lineType == BrokenLineTypeEngine)
        {
            lable.text = @"发动机负荷";
        }
        else if (_lineType == BrokenLineTypeThrottle)
        {
            lable.text = @"节气开度";
        }
        
        
        _titleLable = lable;
    }
    return _titleLable;
}

- (UIImageView *)logoImageView
{
    if (_logoImageView == nil)
    {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake((CGRectGetWidth(self.frame) - 25)/2.0, CGRectGetMaxY(self.titleLable.frame) + 8, 25, 25)];
        imageView.tintColor = [UIColor whiteColor];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        if (_lineType == BrokenLineTypeEngine)
        {
            imageView.image = [UIImage imageNamed:@"FWD_FaDongJiFuHe"];
        }
        else if (_lineType == BrokenLineTypeThrottle)
        {
            imageView.image = [UIImage imageNamed:@"FWD_JieQiKaiDu"];
        }
        
        _logoImageView = imageView;
    }
    
    return _logoImageView;
}

- (UILabel *)valueLable
{
    if (_valueLable == nil)
    {
        UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.logoImageView.frame) + 8, CGRectGetWidth(self.frame), 34)];
        lable.textAlignment = NSTextAlignmentCenter;
        lable.font = [UIFont systemFontOfSize:32];
        lable.textColor = [UIColor whiteColor];
        lable.text = @"69.80";
        
        
        _valueLable = lable;
    }
    return _valueLable;
}

- (void)setAttributeText:(NSString *)newString
{
    NSMutableAttributedString *string1 = [[NSMutableAttributedString alloc] initWithString:newString];
    [string1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:34] range:NSMakeRange(0, string1.length)];
    [string1 addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, string1.length)];
    
    NSMutableAttributedString *string2 = [[NSMutableAttributedString alloc] initWithString:@" %"];
    [string2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, string2.length)];
    [string2 addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, string2.length)];
    [string1 appendAttributedString:string2];    
    self.valueLable.attributedText = string1;
}

- (PNLineChart*)chartView
{
    if (_chartView == nil)
    {
        CGFloat y = CGRectGetMaxY(self.valueLable.frame) + 10;
        
        PNLineChart *lineChart = [[PNLineChart alloc] initWithFrame:CGRectMake(0, y, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)  - y)];
        lineChart.backgroundColor = [UIColor clearColor];
        lineChart.showCoordinateAxis = NO;//坐标轴
        lineChart.yLabelColor = [UIColor whiteColor];
        lineChart.xLabelColor = [UIColor clearColor];
        lineChart.showGenYLabels = NO;
        lineChart.showYGridLines = YES;

        
        lineChart.yLabelFormat = @"%1.1f";
        lineChart.yFixedValueMax = 100.0;
        lineChart.yFixedValueMin = 0.0;
        [lineChart setYLabels:@[@"0",@"20",@"40",@"60",@"80",@"100",]];
        [lineChart setXLabels:@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15"]];


        
        _dataArray = [NSMutableArray arrayWithArray:@[@"80",@"30",@"40",@"60",@"0",@"20",@"90",@"80",@"30",@"40",@"60",@"10",@"20"]];
        
        PNLineChartData *data01 = [PNLineChartData new];
        data01.dataTitle = @"Alpha";
        data01.inflexionPointWidth = 2.0f;
        data01.color = RGBA(144, 173, 65, 1);
        data01.alpha = 1.0f;
        data01.itemCount = _dataArray.count;
        data01.inflexionPointStyle = PNLineChartPointStyleCircle;
        data01.getData = ^(NSUInteger index) {
            CGFloat yValue = [_dataArray[index] floatValue];
            return [PNLineChartDataItem dataItemWithY:yValue];
        };
        
        
        lineChart.legendStyle = PNLegendItemStyleStacked;
        lineChart.chartData = @[data01];
        [lineChart strokeChart];
        lineChart.delegate = self;
        
        lineChart.legendFont = [UIFont boldSystemFontOfSize:12.0f];
        lineChart.legendFontColor = [UIColor redColor];
        
        _chartView = lineChart;
    }
    return _chartView;
}

#pragma mark - 数据改变

- (void)addEngineObserverEvent
{
    __weak __typeof__(self) weakSelf = self;

    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^{
        
        
        
        
        [[CurrentOBDModel sharedCurrentOBDModel]obdEngineLoadChangeWithBlock:^(NSString *engineLoad)
         {
             if (![CurrentOBDModel sharedCurrentOBDModel].isNoFirstView||[CurrentOBDModel sharedCurrentOBDModel].isClean)
             {
                 [weakSelf setAttributeText:engineLoad];
                 
                 if (_dataArray.count<15)
                 {
                     [_dataArray addObject:engineLoad];
                 }
                 else
                 {
                     [_dataArray removeObjectAtIndex:0];
                     [_dataArray addObject:engineLoad];
                 }
                 _chartView.legendFontColor = RGBA(153, 135, 146, 1);
                 
                 [_chartView setXLabels:@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15"]];
                 NSArray * data01Array = [NSArray arrayWithArray:_dataArray];
                 PNLineChartData *data01 = [PNLineChartData new];
                 data01.color = RGBA(144, 173, 65, 1);
                 data01.alpha = 1.0f;
                 data01.inflexionPointWidth = 2.0f;
                 data01.itemCount = data01Array.count;
                 data01.inflexionPointStyle = PNLineChartPointStyleCircle;
                 data01.getData = ^(NSUInteger index)
                 {
                     CGFloat yValue = [data01Array[index] floatValue];
                     return [PNLineChartDataItem dataItemWithY:yValue];
                 };
                 
                 dispatch_async(dispatch_get_main_queue(), ^{
                     [_chartView updateChartData:@[data01]];
                 });
             }
         }];
    });

}


- (void)addThrottleObserverEvent
{
    __weak __typeof__(self) weakSelf = self;

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^{
        
        
        
        [[CurrentOBDModel sharedCurrentOBDModel]obdFeatsOpeningChangeWithBlock:^(NSString *featsOpening) {
            if (![CurrentOBDModel sharedCurrentOBDModel].isNoFirstView||[CurrentOBDModel sharedCurrentOBDModel].isClean) {
                
                [weakSelf setAttributeText:featsOpening];
                
                if (_dataArray.count<20) {
                    if (featsOpening != nil) {
                        [_dataArray addObject:featsOpening];
                    }
                }else{
                    [_dataArray removeObjectAtIndex:0];
                    if (featsOpening != nil) {
                        [_dataArray addObject:featsOpening];
                    }
                }
                
                _chartView.legendFontColor = [UIColor redColor];
                
                NSArray * data01Array = [NSArray arrayWithArray:_dataArray];
                PNLineChartData *data01 = [PNLineChartData new];
                data01.color = [UIColor colorConvertWithHexString:@"ff1e6d"];
                data01.alpha = 1.0f;
                data01.itemCount = data01Array.count;
                data01.inflexionPointWidth = 1.0f;
                data01.inflexionPointStyle = PNLineChartPointStyleCircle;
                data01.getData = ^(NSUInteger index) {
                    CGFloat yValue = [data01Array[index] floatValue];
                    return [PNLineChartDataItem dataItemWithY:yValue];
                };
                
                [_chartView setXLabels:@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20"]];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [_chartView updateChartData:@[data01]];
                });
            }
        }];
    });
}


#pragma mark - PNChartDelegate

- (void)userClickedOnLinePoint:(CGPoint)point lineIndex:(NSInteger)lineIndex{
    NSLog(@"A");
}

/**
 * Callback method that gets invoked when the user taps on a chart line key point.
 */
- (void)userClickedOnLineKeyPoint:(CGPoint)point
                        lineIndex:(NSInteger)lineIndex
                       pointIndex:(NSInteger)pointIndex{
    NSLog(@"B");
}

/**
 * Callback method that gets invoked when the user taps on a chart bar.
 */
- (void)userClickedOnBarAtIndex:(NSInteger)barIndex{
    NSLog(@"C");
}


- (void)userClickedOnPieIndexItem:(NSInteger)pieIndex{
    NSLog(@"D");
}
- (void)didUnselectPieItem{
    NSLog(@"E");
}


@end
