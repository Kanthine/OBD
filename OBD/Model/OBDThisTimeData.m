//
//  OBDThisTimeData.m
//  OBD
//
//  Created by 苏沫离 on 2017/5/26.
//  Copyright © 2017年 苏沫离. All rights reserved.
//

#define UserDefaults [NSUserDefaults standardUserDefaults]

#define DriveDistance @"DriveDistance"
#define OilConsumption @"OilConsumption"
#define DrivableTime @"DrivableTime"
#define IdlingTime @"IdlingTime"

#define IsDriveDistanceClean @"IsDriveDistanceClean"
#define IsOilConsumptionClean @"IsOilConsumptionClean"
#define IsDrivableTimeClean @"IsDrivableTimeClean"
#define IsIdlingTimeClean @"IsIdlingTimeClean"



#import "OBDThisTimeData.h"

@implementation OBDThisTimeData

#pragma mark - Public Method

// 连接成功改为YES 连接失败改为NO
+ (void)isAgainLinkedOBD:(BOOL)isAgain
{
    [OBDThisTimeData setDrivableTimeClean:isAgain];
    [OBDThisTimeData setDriveDistanceClean:isAgain];
    [OBDThisTimeData setOilConsumptionClean:isAgain];
    [OBDThisTimeData setIdlingTimeClean:isAgain];
}

// 本次行驶里程 清零
+ (NSString *)getThisTimeDriveDistance:(NSString *)driveDistance
{
    NSString *newValueString = driveDistance;
    
    //每次启动时 存储最新的初始值
    if ([OBDThisTimeData getIsDriveDistanceCleaned])
    {
        [OBDThisTimeData setDriveDistance:driveDistance];
        [OBDThisTimeData setDriveDistanceClean:NO];
    }

    float newValue = [driveDistance floatValue] - [[OBDThisTimeData getDriveDistance] floatValue];
    
    if (newValue < 0)
    {
        newValue = 0.0;
    }
    
    newValueString = [NSString stringWithFormat:@"%.2f",newValue];
    
    
    return newValueString;
}

//本次油耗量    清零
+ (NSString *)getThisTimeOilConsumption:(NSString *)oilConsumption
{
    NSString *newValueString = oilConsumption;
    
    //每次启动时 存储最新的初始值
    if ([OBDThisTimeData getIsOilConsumptionCleaned])
    {
        [OBDThisTimeData setOilConsumption:oilConsumption];
        [OBDThisTimeData setOilConsumptionClean:NO];
    }
    
    float newValue = [oilConsumption floatValue] - [[OBDThisTimeData getOilConsumption] floatValue];
    
    if (newValue < 0)
    {
        newValue = 0.0;
    }

    
    newValueString = [NSString stringWithFormat:@"%.2f",newValue];

    return newValueString;
}


//本次行驶时间  清零
+ (NSString *)getThisTimeDrivableTime:(NSString *)drivableTime
{
    NSString *newValueString = drivableTime;
    
    //每次启动时 存储最新的初始值
    if ([OBDThisTimeData getIsNeededDrivableTimeClean])
    {
        [OBDThisTimeData setDrivableTime:drivableTime];
        [OBDThisTimeData setDrivableTimeClean:NO];
    }
    
    float newValue = [drivableTime floatValue] - [[OBDThisTimeData getDrivableTime] floatValue];
    
    if (newValue < 0)
    {
        newValue = 0.0;
    }

    newValueString = [NSString stringWithFormat:@"%.1f",newValue];
    
    return newValueString;

}

//本次怠速时间
+ (NSString *)getThisTimeIdlingTime:(NSString *)idlingTime
{
    NSString *newValueString = idlingTime;
    
    //每次启动时 存储最新的初始值
    if ([OBDThisTimeData getIsNeededIdlingTimeClean])
    {
        [OBDThisTimeData setIdlingTime:idlingTime];
        [OBDThisTimeData setIdlingTimeClean:NO];
    }
    
    float newValue = [idlingTime floatValue] - [[OBDThisTimeData getIdlingTime] floatValue];
    
    if (newValue < 0)
    {
        newValue = 0.0;
    }
    
    newValueString = [NSString stringWithFormat:@"%.0f",newValue];
    
    return newValueString;
}


#pragma mark - Private Method

/* 用Boolean值标记是否为刚启动 */

+ (void)setDriveDistanceClean:(BOOL)isClean
{
    [UserDefaults setObject:@(isClean) forKey:IsDriveDistanceClean];
    [UserDefaults synchronize];
}

+ (BOOL)getIsDriveDistanceCleaned
{
    return [[UserDefaults objectForKey:IsDriveDistanceClean] boolValue];
}

+ (void)setOilConsumptionClean:(BOOL)isClean
{
    [UserDefaults setObject:@(isClean) forKey:IsOilConsumptionClean];
    [UserDefaults synchronize];
}

+ (BOOL)getIsOilConsumptionCleaned
{
    return [[UserDefaults objectForKey:IsOilConsumptionClean] boolValue];
}

+ (void)setDrivableTimeClean:(BOOL)isClean
{
    [UserDefaults setObject:@(isClean) forKey:IsDrivableTimeClean];
    [UserDefaults synchronize];
}

+ (BOOL)getIsNeededDrivableTimeClean
{
    return [[UserDefaults objectForKey:IsDrivableTimeClean] boolValue];
}


+ (void)setIdlingTimeClean:(BOOL)isClean
{
    [UserDefaults setObject:@(isClean) forKey:IsIdlingTimeClean];
    [UserDefaults synchronize];
}

+ (BOOL)getIsNeededIdlingTimeClean
{
    return [[UserDefaults objectForKey:IsIdlingTimeClean] boolValue];
}

/* 存储刚启动时的初始值 */

+ (void)setDriveDistance:(NSString *)driveDistance
{
    [UserDefaults setObject:driveDistance forKey:DriveDistance];
    [UserDefaults synchronize];
}

+ (NSString *)getDriveDistance
{
    return [UserDefaults objectForKey:DriveDistance];
}


+ (void)setOilConsumption:(NSString *)oilConsumption
{
    [UserDefaults setObject:oilConsumption forKey:OilConsumption];
    [UserDefaults synchronize];
}

+ (NSString *)getOilConsumption
{
    return [UserDefaults objectForKey:OilConsumption];
}


+ (void)setDrivableTime:(NSString *)drivableTime
{
    [UserDefaults setObject:drivableTime forKey:DrivableTime];
    [UserDefaults synchronize];
}

+ (NSString *)getDrivableTime
{
    return [UserDefaults objectForKey:DrivableTime];
}


+ (void)setIdlingTime:(NSString *)idlingTime
{
    [UserDefaults setObject:idlingTime forKey:IdlingTime];
    [UserDefaults synchronize];
}

+ (NSString *)getIdlingTime
{
    return [UserDefaults objectForKey:IdlingTime];
}

@end
