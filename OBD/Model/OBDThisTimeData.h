//
//  OBDThisTimeData.h
//  OBD
//
//  Created by 苏沫离 on 2017/5/26.
//  Copyright © 2017年 苏沫离. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OBDThisTimeData : NSObject

//是否重新链接OBD 开始清零
+ (void)isAgainLinkedOBD:(BOOL)isAgain;

// 本次行驶里程
+ (NSString *)getThisTimeDriveDistance:(NSString *)driveDistance;

//本次油耗量
+ (NSString *)getThisTimeOilConsumption:(NSString *)oilConsumption;

//本次行驶时间
+ (NSString *)getThisTimeDrivableTime:(NSString *)drivableTime;

//本次怠速时间
+ (NSString *)getThisTimeIdlingTime:(NSString *)idlingTime;

@end



