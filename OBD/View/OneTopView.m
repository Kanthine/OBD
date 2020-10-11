//
//  OneTopView.m
//  OBD
//
//  Created by Why on 16/3/25.
//  Copyright © 2016年 Why. All rights reserved.
//

#import "OneTopView.h"

@interface OneTopView()

{
    NSMutableArray * _dataArray;
    NSString * _orginalStr;
}

@end

@implementation OneTopView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        _orginalStr = @"%";
        //self.backgroundColor = [UIColor orangeColor];
        _dataArray = [NSMutableArray array];
        [self addSubview:self.bigTitle_topLable];
        [self addSubview:self.lineChart];
        [self addObserverEvent];
    }
    return self;
}

- (void)addObserverEvent
{
    [[CurrentOBDModel sharedCurrentOBDModel]obdEngineLoadChangeWithBlock:^(NSString *engineLoad) {
        if (![CurrentOBDModel sharedCurrentOBDModel].isNoFirstView||[CurrentOBDModel sharedCurrentOBDModel].isClean) {
            self.bigTitle_topLable.attributedText = [self getAttributeStr:WHYGetStringWithKeyFromTable(@"ENGINELOAD", @"") unChangeLength:engineLoad.length NewValue:engineLoad];
            if (_dataArray.count<15)
            {
                [_dataArray addObject:engineLoad];
            }
            else
            {
                [_dataArray removeObjectAtIndex:0];
                [_dataArray addObject:engineLoad];
            }
            _lineChart.showCoordinateAxis = NO;
            _lineChart.yFixedValueMax = 100.0;
            _lineChart.yFixedValueMin = 0.0;
            [self.lineChart setXLabels:@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15"]];
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
            [_lineChart updateChartData:@[data01]];
        }
    }];
}
- (NSMutableAttributedString*)getAttributeStr:(NSString*)oldStr unChangeLength:(NSInteger)len NewValue:(NSString*)NewValue{
    float lenght = oldStr.length; //发动机负荷的长度
    NSMutableAttributedString * str = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@%@",oldStr,NewValue,_orginalStr]];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorConvertWithHexString:@"219dd0"] range:NSMakeRange(0, lenght+1)];
    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CourierNewPS-BoldMT" size:14] range:NSMakeRange(0, lenght+1)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorConvertWithHexString:@"ffc000"] range:NSMakeRange(lenght+1, len)];
     [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"DBLCDTempBlack" size:[self getFont]] range:NSMakeRange(lenght+1, len)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorConvertWithHexString:@"ffc000"] range:NSMakeRange(lenght+1+len, 1)];
    return str;
}
- (NSInteger)getFont{
    if (isiPhone5) {
        return 20;
    }else if (isiPhone6){
        return 30;
    }else if (isiPhone6P){
        return 40;
    }else{
        return 16;
    }
}
#pragma mark --大标题
- (UILabel*)bigTitle_topLable{
    if (!_bigTitle_topLable) {
        _bigTitle_topLable = [[UILabel alloc]initWithFrame:CGRectMake(25, 10, ScreenWidth-25, 40)];
        _bigTitle_topLable.text = WHYGetStringWithKeyFromTable(@"ENGINELOAD", @"");

        _bigTitle_topLable.font = [UIFont fontWithName:@"CourierNewPS-BoldMT" size:[self getTitleFont]];
        _bigTitle_topLable.textColor = [UIColor colorConvertWithHexString:@"219dd0"];
    }
    return _bigTitle_topLable;
}
- (NSInteger)getTitleFont{
    if (isiPhone5) {
        return 11;
    }else if (isiPhone6){
        return 13;
    }else if (isiPhone6P){
        return 15;
    }else{
        return 10;
    }
}
- (PNLineChart*)lineChart{
    if (!_lineChart) {
//        _lineChart = [[PNLineChart alloc]initWithFrame:CGRectMake(0, 50, ScreenWidth, self.frame.size.height-50) isTwoRound:YES];
        _lineChart = [[PNLineChart alloc] initWithFrame:CGRectMake(0, 50, ScreenWidth, self.frame.size.height-50)];
        _lineChart.yLabelColor = [UIColor whiteColor];
        _lineChart.xLabelColor = [UIColor whiteColor];

        _lineChart.yLabelFormat = @"%1.1f";
        _lineChart.backgroundColor = [UIColor clearColor];
        [_lineChart setXLabels:@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15"]];
        _lineChart.showCoordinateAxis = NO;
        _lineChart.yFixedValueMax = 100.0;
        _lineChart.yFixedValueMin = 0.0;
        [_lineChart setYLabels:@[
                                     @"0",
                                     @"20",
                                     @"40",
                                     @"60",
                                     @"80",
                                     @"100",
                                     
                                     ]
         ];//,@"33",@"12",@"55",@"88",@"66",@"43",@"10",@"99"
        _dataArray = [NSMutableArray arrayWithArray:@[@"80",@"30",@"40",@"60",@"10",@"20",@"90"]];
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
        _lineChart.legendStyle = PNLegendItemStyleStacked;
        _lineChart.chartData = @[data01];
        [_lineChart strokeChart];
        _lineChart.delegate = self;
        
        _lineChart.legendFont = [UIFont boldSystemFontOfSize:12.0f];
        _lineChart.legendFontColor = [UIColor redColor];
    }
    return _lineChart;
}

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
