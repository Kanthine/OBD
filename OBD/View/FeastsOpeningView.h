//
//  FeastsOpeningView.h
//  OBD
//
//  Created by Why on 16/3/28.
//  Copyright © 2016年 Why. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeastsOpeningView : UIView<PNChartDelegate>
+ (FeastsOpeningView*)sharedFeastsOpeningView;
@property(nonatomic,strong)UILabel * bigTitle_topLable;

@property(nonatomic,strong)PNLineChart * lineChart;
@end
