//
//  OneTopView.h
//  OBD
//
//  Created by Why on 16/3/25.
//  Copyright © 2016年 Why. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OneTopView : UIView<PNChartDelegate>

@property(nonatomic,strong)UILabel * bigTitle_topLable;

@property(nonatomic,strong)PNLineChart * lineChart;
@end
