//
//  CarThreeStatus.h
//  OBD
//
//  Created by Why on 16/4/1.
//  Copyright © 2016年 Why. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CarThreeStatus : UIView
/**
 *  行驶时间
 */
@property(nonatomic,strong)UILabel * drivetTimeLable;
/**
 *  油耗
 */
@property(nonatomic,strong)UILabel * ldlingTimeLable;
/**
 *  平均车速
 */
@property(nonatomic,strong)UILabel * averageCarSpeedLable;

@end
