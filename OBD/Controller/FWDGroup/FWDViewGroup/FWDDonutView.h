//
//  FWDDonutView.h
//  OBD
//
//  Created by 苏沫离 on 2017/5/8.
//  Copyright © 2017年 苏沫离. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,DonutScheduleType)
{
    DonutScheduleTypeWaterTemperature = 0,//水温度
    DonutScheduleTypeAirFuelRatio,//空燃比
};



@interface TemperatureGradualView : UIView//水温进度圆环
@end

@interface AirFuelRatiView : UIView//空燃比
@end





@interface FWDDonutView : UIView

- (instancetype)initWithFrame:(CGRect)frame Type:(DonutScheduleType)donutType;

@end
