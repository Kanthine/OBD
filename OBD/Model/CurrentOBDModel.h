//
//  CurrentOBDModel.h
//  OBD
//
//  Created by Why on 16/3/25.
//  Copyright © 2016年 Why. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger,BoxState)//盒子状态
{
    BoxStateNoLink = 0,
    BoxStateOn,
    BoxStateOff,
    BoxStateAutoOn,
    BoxStateAutoOff
};



typedef void (^CurrentOBDModelChangeBlock)(OBDModel * model);
typedef void (^OilAvergageLossBlock)(NSString * currentOilLoss);
typedef void (^FeatsOpeningBlock)(NSString * featsOpening);
typedef void (^EngineLoadBlock) (NSString * engineLoad);
typedef void (^BluetoothOnBlock)(NSString * bluethOn);
typedef void (^ErrorCodeNumBlock)(NSString * errcodeNum);
typedef void (^CarSpeedBlock)(NSString * carSpeed);
typedef void (^TurnSpeedBlock)(NSString * turnSpeed);
typedef void (^WaterTempBlock)(NSString * waterTemp);
typedef void (^FuelRatioBlock)(NSString * fuelRatio);
typedef void (^IntakePressureBlock)(NSString *intakePressure);
typedef void (^IntakeFlueBlock)(NSString * intakeFlue);
typedef void (^IntakeTempBlock)(NSString * intakeTemp);
typedef void (^ExhaustTempBlock)(NSString * exhaustTemp);
typedef void (^SWITCHSTATUSBLOCK) (NSString * switchStatus);
typedef void (^DriveDistanceBlock) (NSString * driveDistance);
typedef void (^OilMainLossBlock) (NSString * oilMainLoss);
typedef void (^DriveTimeBlock) (NSString * driveTime);
typedef void (^DaiSuTimeBlock) (NSString * daiSuTime);
typedef void (^AverageCarSpeedBlock) (NSString * averCarSpeed);
#pragma mark --发命令--
typedef void (^ErrorCodeChangeBlock)(NSString * errorcode);
typedef void (^CommendModelChangeBlock)(CommandModel * commandM);
typedef void (^CheckTurnSpeedChangeBlock) (NSString * checkTurnSpeed);
typedef void (^CheckDelayTimeChangeBlock)(NSString * delayTime);
typedef void (^OxygenErrorCleanBlock) (NSString * oxygenError);
typedef void (^BoxIDBlock) (NSString * boxID);
@interface CurrentOBDModel : NSObject

+ (CurrentOBDModel*)sharedCurrentOBDModel;

@property(nonatomic,strong)OBDModel * currentModel;
@property(nonatomic,copy)CurrentOBDModelChangeBlock currentBlock;
/**
 *  发动机负荷变化
 */
@property (nonatomic,copy)NSString * engineLoad;
@property (nonatomic,copy)EngineLoadBlock engineLoadBlock;
- (void)obdEngineLoadChangeWithBlock:(EngineLoadBlock)block;
/**
 *  平均油耗变化
 */
@property(nonatomic,copy)NSString * oilAverageLoss;
@property(nonatomic,copy)OilAvergageLossBlock oilBlock;
- (void)obdOilLossChangeWithBlock:(OilAvergageLossBlock)block;
/**
 *  节气门开度变化
 */
@property(nonatomic,copy)NSString * feastsOperning;
@property(nonatomic,copy)FeatsOpeningBlock featsBlock;
- (void)obdFeatsOpeningChangeWithBlock:(FeatsOpeningBlock)block;
/**
 *  故障码数量变化
 */
@property(nonatomic,copy)NSString * errcodeNum;
@property(nonatomic,copy)ErrorCodeNumBlock errorcodeBlock;
- (void)obdErrorcodeNumChangeBlock:(ErrorCodeNumBlock)block;
/**
 *  状态 1蓝牙关-》打开蓝牙2蓝牙开-》链接obd3链接上obd了-》显示开关状态
 */
@property(nonatomic,copy)NSString * processStatus;
@property(nonatomic,copy)BluetoothOnBlock bluetoothBlock;
- (void)obdBluetoothSwitchChangeWithBlock:(BluetoothOnBlock)block;
/**
 *  车速变化
 */
@property(nonatomic,copy)NSString * carSpeed;
@property(nonatomic,copy)CarSpeedBlock carBlock;
- (void)obdCarSpeedChangeWithBlock:(CarSpeedBlock)block;
/**
 *  转速变化
 */
@property(nonatomic,copy)NSString * turnSpeed;
@property(nonatomic,copy)TurnSpeedBlock turnBlock;
- (void)obdTurnSpeedChangeWithBlock:(TurnSpeedBlock)block;
/**
 *  水温变化
 */
@property(nonatomic,copy)NSString * waterTep;
@property(nonatomic,copy)WaterTempBlock waterBlock;
- (void)obdWaterTempChangeWithBlock:(WaterTempBlock)block;
/**
 *  空燃比变化
 */
@property(nonatomic,copy)NSString * fuelRatio;
@property(nonatomic,copy)FuelRatioBlock fuelRatioBlock;
- (void)obdFuelRatioChangeWithBlock:(FuelRatioBlock)block;
/**
 *  进气压力变化
 */
@property(nonatomic,copy)NSString * intakePressure;
@property(nonatomic,copy)IntakePressureBlock intakePresBlock;
- (void)obdIntakePressureChangeWithBlock:(IntakePressureBlock)block;
/**
 *  进气流量变化
 */
@property(nonatomic,copy)NSString * intakeFlue;
@property(nonatomic,copy)IntakeFlueBlock intakeFluBlock;
- (void)obdIntakeFlueChangeWithBlock:(IntakeFlueBlock)block;
/**
 *  进气温度变化
 */
@property(nonatomic,copy)NSString * intakeTemp;
@property(nonatomic,copy)IntakeTempBlock intakeTempBlock;
- (void)obdIntakeTempChangeWithBlock:(IntakeTempBlock)block;
/**
 *  排气温度变化
 */
@property(nonatomic,copy)NSString * exhustTemp;
@property(nonatomic,copy)ExhaustTempBlock exhustBlock;
- (void)obdExhaustTempChangeWithBlock:(ExhaustTempBlock)block;
/**
 *  行驶里程变化
 */
@property(nonatomic,copy)NSString * driveDistance;
@property(nonatomic,copy)DriveDistanceBlock driveDistanceBlock;
- (void)obdDriveDistanceChangeWithBlock:(DriveDistanceBlock)block;
/**
 *  本次油耗量变化
 */
@property(nonatomic,copy)NSString * oilMainLoss;
@property(nonatomic,copy)OilMainLossBlock oilMainLossBlock;
- (void)obdOilMainLossChangeWithBlock:(OilMainLossBlock)block;

/**
 *  本次油行驶时间变化
 */
@property(nonatomic,copy)NSString * driveTime;
@property(nonatomic,copy)DriveTimeBlock driveTimeBlock;
- (void)obdDriveTimeChangeWithBlock:(DriveTimeBlock)block;
/**
 *  本次油行驶时间变化
 */
@property(nonatomic,copy)NSString * daiSuTime;
@property(nonatomic,copy)DaiSuTimeBlock daiSuTimeBlock;
- (void)obdDaiSuTimeChangeWithBlock:(DaiSuTimeBlock)block;
/**
 *  平均车速变化
 */
@property(nonatomic,copy)NSString * averageCarSpeed;
@property(nonatomic,copy)AverageCarSpeedBlock averageCarSpeedBlock;
- (void)obdAverageCarSpeedChangeWithBlock:(AverageCarSpeedBlock)block;


- (void)obdModelChangeWithBlock:(CurrentOBDModelChangeBlock)block;


#pragma mark --发命令--
/**
 *  当前的命令Model
 */
@property (nonatomic,strong)CommandModel * currentCommandModel;
@property (nonatomic,copy)CommendModelChangeBlock commandBlock;
- (void)orderManagerCommendChange:(CommendModelChangeBlock)block;
/**
 *  故障码
 */
@property (nonatomic,copy)NSString * errorcode;
@property (nonatomic,copy)ErrorCodeChangeBlock  checkErrorBlock;
- (void)orderMangerErrorcodeChange:(ErrorCodeChangeBlock)block;
/**
 *  查看转速阀值
 */
@property (nonatomic,copy)NSString * checkTurnSpeed;
@property (nonatomic,copy)CheckTurnSpeedChangeBlock checkTurnSpeedBlock;
- (void)orderManagerTurnSpeedChange:(CheckTurnSpeedChangeBlock)block;
/**
 *  开关OFF1 AUTO 2 ON 0
 */
@property (nonatomic,copy)NSString * switchStatus;
@property (nonatomic,copy)SWITCHSTATUSBLOCK switchBlock;
- (void)obdSwitchStatusChange:(SWITCHSTATUSBLOCK)block;
/**
 *  查看延时时间
 */
@property (nonatomic,copy)NSString * delayTime;
@property (nonatomic,copy)CheckDelayTimeChangeBlock delayTimeBlock;
- (void)orderManagerDelayTimeChangeBlock:(CheckDelayTimeChangeBlock)block;

/**
 *  氧传感故障码清除
 */
@property (nonatomic,copy)NSString * oxygenErrorClean;
@property (nonatomic,copy)OxygenErrorCleanBlock oxygenBlock;
- (void)orderManagerOxygenErrorChangeBlock:(OxygenErrorCleanBlock)block;

/**
 *  是否不是第一页
 */
@property (nonatomic,assign)BOOL isNoFirstView;
/**
 *  配对的盒子的ID
 */
@property (nonatomic,copy)NSString * boxID;
@property (nonatomic,copy)BoxIDBlock boxBlock;
- (void)orderManagerGetBoxIdChangeBlock:(BoxIDBlock)block;

/**
 *  把数据清空
 */
- (void)cleanData;
@property (nonatomic,assign)BOOL isClean;

/**
 *  盒子状态 0: MANON 1: MANOFF ERROR 2:AUTON 查询的返回
 */
@property(nonatomic,assign)NSInteger switchStatusNum;
@property(nonatomic,assign)BoxState boxState;

/**
 *  本地执行的盒子状态指令 本地保存一下
 */
@property(nonatomic,copy)NSString * localSwitchStatus;

@end
