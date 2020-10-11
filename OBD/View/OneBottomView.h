//
//  OneBottomView.h
//  OBD
//
//  Created by Why on 16/3/28.
//  Copyright © 2016年 Why. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OneBottomView : UIView
/**
 *  行驶里程
 */
@property(nonatomic,strong)UILabel * drive_DistanceLable;
/**
 *  油耗
 */
@property(nonatomic,strong)UILabel * oil_ConsumptionLable;
/**
 *  平均油耗
 */
@property(nonatomic,strong)UILabel * averge_oilConsumptionLable;
@end
