//
//  CurrentOBDModel.m
//  OBD
//
//  Created by Why on 16/3/25.
//  Copyright © 2016年 Why. All rights reserved.
//

#import "CurrentOBDModel.h"
#define CHECK_BLOCK_EXIT(block,...)  if (block) {\
block(__VA_ARGS__);\
}
 static CurrentOBDModel * currentOBD;
@implementation CurrentOBDModel
{
    NSMutableArray * _switchStatusBlockArr;
}
+ (CurrentOBDModel*)sharedCurrentOBDModel{
   
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        currentOBD = [[CurrentOBDModel alloc]init];
        currentOBD.processStatus = @"1";
    });
    return currentOBD;
}
- (instancetype)init{
    if (self == [super init]) {
        _switchStatusBlockArr = [NSMutableArray array];
    }
    return self;
}
- (void)setCurrentModel:(OBDModel *)currentModel
{
    self.engineLoad = currentModel.engineLoad;
    self.oilAverageLoss = currentModel.oilAverageLoss;
    self.feastsOperning = currentModel.feastsOpeningValve;
    self.errcodeNum = currentModel.errorCodeNumber;
    self.driveDistance = currentModel.currentDriveDistance;
    self.oilMainLoss = currentModel.currentOilLoss;
    self.carSpeed = currentModel.carSpeed;
    self.turnSpeed = currentModel.turnSpeed;
    self.waterTep = currentModel.waterTemperature;
    self.fuelRatio = currentModel.fuelRatio;
    self.intakePressure = currentModel.intakePressure;
    self.intakeFlue = currentModel.intakeAirFlow;
    self.intakeTemp = currentModel.intakeTemperature;
    self.exhustTemp = currentModel.exhaustTemperature;
    self.driveTime = currentModel.currentDriveTime;
    self.daiSuTime = currentModel.currentDaiSuTime;
    self.averageCarSpeed = currentModel.averageCarSpeed;
    
    
    NSString *boxStatus = currentModel.boxStatus;
    //盒子状态 0->未获取 1->MANON 2->MANOFF 3->AUTON 4->AUTOFF
    if ([boxStatus isEqualToString:@"0"])
    {
        self.switchStatusNum = 1;
    }
    else if ([boxStatus isEqualToString:@"1"])
    {
        self.switchStatusNum = 0;
    }
    else if ([boxStatus isEqualToString:@"2"])
    {
        self.switchStatusNum = 1;
    }
    else if ([boxStatus isEqualToString:@"3"])
    {
        self.switchStatusNum = 2;
    }
    else if ([boxStatus isEqualToString:@"4"])
    {
        self.switchStatusNum = 2;
    }
    else
    {
        self.switchStatusNum = 1;
    }
}

#pragma mark --发动机负荷--
- (void)setEngineLoad:(NSString *)engineLoad{
    if (_engineLoad != engineLoad) {
        _engineLoad = engineLoad;
    }
    if (self.engineLoadBlock) {
        self.engineLoadBlock(_engineLoad);
    }
}
- (void)obdEngineLoadChangeWithBlock:(EngineLoadBlock)block{
    self.engineLoadBlock = nil;
    self.engineLoadBlock = [block copy];
}
#pragma mark --平均油耗--
- (void)setOilAverageLoss:(NSString *)oilAverageLoss{
    if (_oilAverageLoss != oilAverageLoss) {
        _oilAverageLoss = oilAverageLoss;
       
    }
    if (self.oilBlock) {
        self.oilBlock(_oilAverageLoss);
    }
}

- (void)obdOilLossChangeWithBlock:(OilAvergageLossBlock)block{
    self.oilBlock = nil;
    self.oilBlock = [block copy];
}
#pragma mark --节气开度--
- (void)setFeastsOperning:(NSString *)feastsOperning{
    if (_feastsOperning != feastsOperning) {
        _feastsOperning = feastsOperning;
    }
    if (self.featsBlock) {
        self.featsBlock(_feastsOperning);
    }
}
- (void)obdFeatsOpeningChangeWithBlock:(FeatsOpeningBlock)block{
    self.featsBlock = nil;
    self.featsBlock = [block copy];
}
#pragma mark --蓝牙开关状态--
- (void)setProcessStatus:(NSString *)processStatus
{
    if (![_processStatus isEqualToString:processStatus])
    {
        _processStatus = processStatus;
        if (self.bluetoothBlock)
        {
            self.bluetoothBlock(_processStatus);
        }
    }
}

- (void)obdBluetoothSwitchChangeWithBlock:(BluetoothOnBlock)block{
    self.bluetoothBlock = nil;
    self.bluetoothBlock = [block copy];
}
#pragma mark --故障码数量变化--
- (void)setErrcodeNum:(NSString *)errcodeNum{
    if (_errcodeNum != errcodeNum) {
        _errcodeNum = errcodeNum;
    }
    
    if (_errorcode == nil) {
        _errorcode = @"";
    }
    
    if (self.errorcodeBlock) {
        self.errorcodeBlock(_errcodeNum);
    }
}
- (void)obdErrorcodeNumChangeBlock:(void(^)(NSString * errcodeNum))block{
    self.errorcodeBlock = nil;
    self.errorcodeBlock = [block copy];
}
#pragma mark --车速变化--
- (void)setCarSpeed:(NSString *)carSpeed{
    if (_carSpeed != carSpeed) {
        _carSpeed = carSpeed;
    }
    if (self.carBlock) {
        self.carBlock(_carSpeed);
    }
}
- (void)obdCarSpeedChangeWithBlock:(CarSpeedBlock)block{
    self.carBlock = nil;
    self.carBlock = [block copy];
}
#pragma mark --转速变化--
- (void)setTurnSpeed:(NSString *)turnSpeed{
    if (_turnSpeed != turnSpeed) {
        _turnSpeed = turnSpeed;
    }
    if (self.turnBlock) {
        self.turnBlock(_turnSpeed);
    }
}
- (void)obdTurnSpeedChangeWithBlock:(TurnSpeedBlock)block{
    self.turnBlock = nil;
    self.turnBlock = [block copy];
}
#pragma mark --水温变化--
- (void)setWaterTep:(NSString *)waterTep{
    if (_waterTep != waterTep) {
        _waterTep = waterTep;
    }
    if (self.waterBlock) {
        self.waterBlock(_waterTep);
    }

}
- (void)obdWaterTempChangeWithBlock:(WaterTempBlock)block{
    self.waterBlock = nil;
    self.waterBlock = [block copy];
}
#pragma mark --空燃比变化--
- (void)setFuelRatio:(NSString *)fuelRatio{
    if (_fuelRatio != fuelRatio) {
        _fuelRatio = fuelRatio;
    }
    if (self.fuelRatioBlock) {
        self.fuelRatioBlock(_fuelRatio);
    }
}
- (void)obdFuelRatioChangeWithBlock:(FuelRatioBlock)block{
    self.fuelRatioBlock = nil;
    self.fuelRatioBlock = [block copy];
}
#pragma mark --进气压力变化--
- (void)setIntakePressure:(NSString *)intakePressure{
    if (_intakePressure != intakePressure) {
        _intakePressure = intakePressure;
    }
    if (self.intakePresBlock) {
        self.intakePresBlock(_intakePressure);
    }
}
- (void)obdIntakePressureChangeWithBlock:(IntakePressureBlock)block{
    self.intakePresBlock = nil;
    self.intakePresBlock = [block copy];
}
#pragma mark--进气流量变化--
- (void)setIntakeFlue:(NSString *)intakeFlue{
    if (_intakeFlue != intakeFlue) {
        _intakeFlue = intakeFlue;
    }
    if (self.intakeFluBlock) {
        self.intakeFluBlock(_intakeFlue);
    }
}
- (void)obdIntakeFlueChangeWithBlock:(IntakeFlueBlock)block{
    self.intakeFluBlock = nil;
    self.intakeFluBlock = [block copy];
}
#pragma mark --进气温度变化--
- (void)setIntakeTemp:(NSString *)intakeTemp{
    if (_intakeTemp != intakeTemp) {
        _intakeTemp = intakeTemp;
    }
    if (self.intakeTempBlock) {
        self.intakeTempBlock(_intakeTemp);
    }
}
- (void)obdIntakeTempChangeWithBlock:(IntakeTempBlock)block{
    self.intakeTempBlock = nil;
    self.intakeTempBlock = [block copy];
}
#pragma mark --排气温度变化--
- (void)setExhustTemp:(NSString *)exhustTemp{
    if (_exhustTemp != exhustTemp) {
        _exhustTemp = exhustTemp;
    }
    if (self.exhustBlock) {
        self.exhustBlock(_exhustTemp);
    }
}
- (void)obdExhaustTempChangeWithBlock:(ExhaustTempBlock)block{
    self.exhustBlock = nil;
    self.exhustBlock = [block copy];
}
#pragma mark --行驶里程变化--
- (void)setDriveDistance:(NSString *)driveDistance{
    if (_driveDistance != driveDistance) {
        _driveDistance = driveDistance;
    }
    if (self.driveDistanceBlock) {
        self.driveDistanceBlock(_driveDistance);
    }

}

- (void)obdDriveDistanceChangeWithBlock:(DriveDistanceBlock)block{
    self.driveDistanceBlock = nil;
    self.driveDistanceBlock = [block copy];
}
#pragma mark --本次油耗量变化--
- (void)setOilMainLoss:(NSString *)oilMainLoss{
    if (_oilMainLoss != oilMainLoss) {
         _oilMainLoss = oilMainLoss;
    }
    if (self.oilMainLossBlock) {
        self.oilMainLossBlock(_oilMainLoss);
    }
}
- (void)obdOilMainLossChangeWithBlock:(OilMainLossBlock)block{
    self.oilMainLossBlock = nil;
    self.oilMainLossBlock = [block copy];
}
#pragma mark --本次行驶时间--
- (void)setDriveTime:(NSString *)driveTime{
    if (_driveTime != driveTime) {
         _driveTime = [NSString stringWithFormat:@"%.1f",[driveTime floatValue]*60.0];
    }
    if (self.driveTimeBlock) {
        self.driveTimeBlock(_driveTime);
    }
}
- (void)obdDriveTimeChangeWithBlock:(DriveTimeBlock)block{
    self.driveTimeBlock = nil;
    self.driveTimeBlock = [block copy];
}
#pragma mark --本次怠速时间--
- (void)setDaiSuTime:(NSString *)daiSuTime{
    if (_daiSuTime != daiSuTime) {
        _daiSuTime = daiSuTime;
    }
    if (self.daiSuTimeBlock) {
        self.daiSuTimeBlock(_daiSuTime);
    }
}
- (void)obdDaiSuTimeChangeWithBlock:(DaiSuTimeBlock)block{
    self.daiSuTimeBlock = nil;
    self.daiSuTimeBlock = [block copy];
}
#pragma mark --平均车速变化--
- (void)setAverageCarSpeed:(NSString *)averageCarSpeed{
    if (_averageCarSpeed != averageCarSpeed) {
        _averageCarSpeed = averageCarSpeed;
    }
    if (self.averageCarSpeedBlock) {
        self.averageCarSpeedBlock(_averageCarSpeed);
    }
}
- (void)obdAverageCarSpeedChangeWithBlock:(AverageCarSpeedBlock)block{
    self.averageCarSpeedBlock = nil;
    self.averageCarSpeedBlock = [block copy];
}
#pragma mark --错误码--
- (void)setCurrentCommandModel:(CommandModel *)currentCommandModel
{
    if (_currentCommandModel != currentCommandModel) {
        _currentCommandModel = currentCommandModel;
    }
    switch ([[WHYToolModel getHexNumFrom:currentCommandModel.commandType] integerValue]) {
        case 0:
        {
            /**
             *  数据流
             */
        }
            break;
        case 1:
        {
            /**
             *  预留
             */
        }
            break;
        case 2:
        {
            /**
             *  查询转速阀值 $OBD,02,4,3000\r\n
             */
            self.checkTurnSpeed = currentCommandModel.message;
        }
            break;
        case 3:
        {
            /**
             *  设置转速阀值 $OBD,03,2,OK\r\n
             */
        }
            break;
        case 4:
        {
            /**
             *  查询盒子状态 $OBD,04,2,MANON\r\n
             */
            self.switchStatus = currentCommandModel.message;
        }
            break;
        case 5:
        {
            /**
             *  控制盒子状态 $OBD,05,2,OK\r\n
             */
            if ([currentCommandModel.message isEqualToString:@"OK"]) {
                self.switchStatus = self.localSwitchStatus;
            }
        }
            break;
        case 6:
        {
            /**
             *  查询数据流设置 $OBD,06,2,ON\r\n 状态
             */
        }
            break;
        case 7:
        {
            /**
             *  设置数据流开关￼ $OBD,07,2,OK\r\n
             */
        }
            break;
        case 8:
        {
            /**
             *  查询数据流间隔（s） $OBD,08,1,1\r\n
             */
        }
            break;
        case 9:
        {
            /**
             *  设置数据流间隔（s）$OBD,09,2,OK\r\n
             */
        }
            break;
        case 10:
        {
            /**
             *  读取已配对盒子ID $OBD,0A,4,0010\r\n
             */
            self.boxID = currentCommandModel.message;
        }
            break;
        case 11:
        {
            /**
             *  获取当前配对成功的ID $OBD,0B,4,0010\r\n
             */
            self.boxID = currentCommandModel.message;
        }
            break;
        case 12:
        {
            /**
             *  读取故障码 $OBD,0C,23,P0006|P0007
             \r\n
             */
             self.errorcode = currentCommandModel.message;
        }
            break;
        case 13:
        {
            /**
             *  清除故障码 $OBD,0D,2,OK\r\n
             */
        }
            break;
        case 14:
        {
            /**
             *  OBD 连接成功提示 ￼￼
             $OBD,0E,7,CONNECT\r\n
             */
        }
            break;
        case 15:
        {
            /**
             *  OBD 断线提示 $OBD,0F,10,DISCONNECT
             \r\n
             */
        }
            break;
        case 16:{
            /**
             *  查询延时时间
             */
            self.delayTime = currentCommandModel.message;
        }
            break;
        case 18:{
            /**
             *  查询清除氧故障码
             */
            self.oxygenErrorClean = currentCommandModel.message;
        }
            break;
        case 19:{
            /**
             *  设置氧传感故障码
             */
            self.oxygenErrorClean = currentCommandModel.message;
        }
            break;
        default:
            break;
    }

    
    if (self.commandBlock)
    {
        self.commandBlock(_currentCommandModel);
    }
}
- (void)orderManagerCommendChange:(CommendModelChangeBlock)block{
    self.commandBlock = nil;
    self.commandBlock = [block copy];
}

- (void)setErrorcode:(NSString *)errorcode{
    if (_errorcode != errorcode) {
        _errorcode = errorcode;
    }
    if (self.checkErrorBlock) {
        self.checkErrorBlock(_errorcode);
    }
}
- (void)orderMangerErrorcodeChange:(ErrorCodeChangeBlock)block{
    self.checkErrorBlock = nil;
    self.checkErrorBlock = [block copy];
}
#pragma mark --开关状态 ON OFF AUTO--
- (void)setSwitchStatus:(NSString *)switchStatus
{
    if (_switchStatus!= switchStatus)
    {
        _switchStatus = switchStatus;
    }
    
    [self getSwitchStatusNum:_switchStatus];
    
    for (SWITCHSTATUSBLOCK switchBlock  in _switchStatusBlockArr)
    {
        CHECK_BLOCK_EXIT(switchBlock,_switchStatus);
    }
}
- (void)obdSwitchStatusChange:(SWITCHSTATUSBLOCK)block{
    
    self.switchBlock = block;
    [_switchStatusBlockArr addObject:self.switchBlock];
}
#pragma mark-根据开关的状态 为其设值--
- (void)getSwitchStatusNum:(NSString*)switchStatus
{
    // 盒子状态 0: MANON 1: MANOFF ERROR 2:AUTON 查询的返回
    if ([switchStatus isEqualToString:@"MANOFF"]||[switchStatus isEqualToString:@"MAN_OFF"])
    {
        self.switchStatusNum = 1;
    }
    else if ([switchStatus isEqualToString:@"MANON"])
    {
        self.switchStatusNum = 0;
    }
    else if ([switchStatus isEqualToString:@"AUTON"]||[switchStatus isEqualToString:@"AUTO_OFF"])
    {
        self.switchStatusNum = 2;
    }
}

#pragma mark --查看转速阀值--
- (void)setCheckTurnSpeed:(NSString *)checkTurnSpeed{
    if (_checkTurnSpeed != checkTurnSpeed)
    {
        _checkTurnSpeed = checkTurnSpeed;
       
    }
    if (self.checkTurnSpeedBlock)
    {
        self.checkTurnSpeedBlock(_checkTurnSpeed);
    }
}
- (void)orderManagerTurnSpeedChange:(CheckTurnSpeedChangeBlock)block{
    self.checkTurnSpeedBlock = nil;
    self.checkTurnSpeedBlock = [block copy];
}
#pragma mark --查看延时时间--
- (void)setDelayTime:(NSString *)delayTime{
    if (_delayTime != delayTime) {
        _delayTime = delayTime;
       
    }
    if (self.delayTimeBlock) {
        self.delayTimeBlock(_delayTime);
    }
}
- (void)orderManagerDelayTimeChangeBlock:(CheckDelayTimeChangeBlock)block{
    self.delayTimeBlock = nil;
    self.delayTimeBlock = [block copy];
}
#pragma mark --清除氧传感故障码--
- (void)setOxygenErrorClean:(NSString *)oxygenErrorClean{
    if (_oxygenErrorClean != oxygenErrorClean) {
        _oxygenErrorClean = oxygenErrorClean;
    }
    if (self.oxygenBlock) {
        self.oxygenBlock(_oxygenErrorClean);
    }
}
- (void)orderManagerOxygenErrorChangeBlock:(OxygenErrorCleanBlock)block{
    self.oxygenBlock = nil;
    self.oxygenBlock = [block copy];
}
#pragma mark --配对的盒子的ID--
- (void)setBoxID:(NSString *)boxID{
    if (_boxID != boxID) {
        _boxID = boxID;
    }
    if (self.boxBlock) {
        self.boxBlock(_boxID);
    }
}
- (void)orderManagerGetBoxIdChangeBlock:(BoxIDBlock)block{
    self.boxBlock = nil;
    self.boxBlock = [block copy];
}


#pragma mark --把数据清空--
- (void)cleanData
{
    self.isClean = YES;
    self.engineLoad = @"0";
    //self.currentModel.self.oilAverageLoss = currentModel.oilAverageLoss;
    self.feastsOperning = @"0";
    self.errcodeNum = @"0";
    self.driveDistance = @"0";
    self.oilMainLoss = @"0";
    self.carSpeed = @"0";
    self.turnSpeed = @"0";
    self.waterTep = @"0";
    self.fuelRatio = @"0";
    self.intakePressure = @"0";
    self.intakeFlue = @"0";
    self.intakeTemp = @"0";
    self.exhustTemp = @"0";
    self.driveTime = @"0";
    self.daiSuTime = @"0";
    self.averageCarSpeed = @"0";
    self.oilAverageLoss = @"0";
    [self performSelector:@selector(cleanChange) withObject:self afterDelay:4];
}
- (void)cleanChange{
    self.isClean = NO;
}
@end
