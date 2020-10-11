//
//  OBDModel.m
//  OBD
//
//  Created by Why on 16/1/15.
//  Copyright © 2016年 Why. All rights reserved.
//

#import "OBDModel.h"
@implementation OBDModel

+ (OBDModel*)getOBDFlueModel:(NSArray*)strArray
{
    OBDModel * obdModel = [[OBDModel alloc]init];
    if (strArray.count>23)
    {
        obdModel.commandCode = strArray[1];
        obdModel.dataByteCount = strArray[2];
        obdModel.turnSpeed = strArray[3];
        obdModel.carSpeed = strArray[4];
        obdModel.turboPressure = strArray[5];
        obdModel.oilPressure = strArray[6];
        obdModel.oilTemperature = strArray[7];
        obdModel.waterTemperature = strArray[8];
        obdModel.intakePressure = strArray[9];
        obdModel.feastsOpeningValve = strArray[10];
        obdModel.intakeTemperature = strArray[11];
        obdModel.engineLoad = strArray[12];
        obdModel.exhaustTemperature = strArray[13];
        obdModel.fuelRatio = strArray[14];
        obdModel.intakeAirFlow = strArray[15];
        obdModel.errorCodeNumber = strArray[16];
        obdModel.oilAverageLoss = strArray[17];
        obdModel.boxStatus = strArray[18];
        obdModel.currentDriveDistance = strArray[19];
        obdModel.currentOilLoss = strArray[20];
        obdModel.currentDriveTime = strArray[21];
        obdModel.currentDaiSuTime = strArray[22];
        obdModel.averageCarSpeed = [[strArray[23] componentsSeparatedByString:@"\r"]firstObject];
        [[OBDMainViewController sharedOBDMainViewController] reloadData];
        return obdModel;

    }
    
    return nil;
}

- (void)setBoxStatus:(NSString *)boxStatus
{
    if ([_boxStatus isEqualToString:boxStatus] == NO)
    {
        _boxStatus = boxStatus;
    }
}

@end

#pragma mark --命令--

@implementation CommandModel

+ (CommandModel*)getCommandModel:(NSArray*)strArr{
    CommandModel * cModel = [[CommandModel alloc]init];
    
    if (strArr && [strArr isKindOfClass:[NSArray class]])
    {
        if (strArr.count > 1)
        {
            cModel.commandType = strArr[1];
        }
        
        if (strArr.count > 2)
        {
           cModel.byteCount = strArr[2];
        }
        
        if (strArr.count > 2)
        {
           cModel.message = [[strArr[3] componentsSeparatedByString:@"\r"]firstObject];
        }
    }
    
    
    
    return cModel;
}

@end

#pragma mark --管理--

@implementation OBDModelManager
+ (OBDModelManager*)sharedOBDModelManager
{
    static  OBDModelManager * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
    {
        manager = [[OBDModelManager alloc]init];
    });
    return manager;
}

- (void)managerODBMessageWithStr:(NSString*)receiveValueStr complete:(void(^)(id object,BOOL isByteFlue))completed
{
    NSArray * strArr = [receiveValueStr componentsSeparatedByString:@","];
    NSString * codeStr = strArr[1];

    switch ([[WHYToolModel getHexNumFrom:codeStr]integerValue])
    {
        case 0:
        {
            /**
             *  数据流
             */
            if (completed)
            {
                completed([OBDModel getOBDFlueModel:strArr],YES);
            }
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
            if (completed)
            {
                completed([CommandModel getCommandModel:strArr],YES);
            }
        }
            break;
        case 3:
        {
            /**
             *  设置转速阀值 $OBD,03,2,OK\r\n
             */
            if (completed) {
                completed([CommandModel getCommandModel:strArr],NO);
            }
        }
            break;
        case 4:
        {
            /**
             *  查询盒子状态 $OBD,04,2,MANON\r\n
             */
            if (completed)
            {
                completed([CommandModel getCommandModel:strArr],NO);
            }
        }
            break;
        case 5:
        {
            /**
             *  控制盒子状态 $OBD,05,2,OK\r\n
             */
            if (completed) {
                completed([CommandModel getCommandModel:strArr],NO);
            }
        }
            break;
        case 6:
        {
            /**
             *  查询数据流设置 $OBD,06,2,ON\r\n 状态
             */
            if (completed) {
                completed([CommandModel getCommandModel:strArr],NO);
            }
        }
            break;
        case 7:
        {
            /**
             *  设置数据流开关￼ $OBD,07,2,OK\r\n
             */
            if (completed) {
                completed([CommandModel getCommandModel:strArr],NO);
            }
        }
            break;
        case 8:
        {
            /**
             *  查询数据流间隔（s） $OBD,08,1,1\r\n
             */
            if (completed) {
                completed([CommandModel getCommandModel:strArr],NO);
            }
        }
            break;
        case 9:
        {
            /**
             *  设置数据流间隔（s）$OBD,09,2,OK\r\n
             */
            if (completed) {
                completed([CommandModel getCommandModel:strArr],NO);
            }
        }
            break;
        case 10:
        {
            /**
             *  读取已配对盒子ID $OBD,0A,4,0010\r\n
             */
            if (completed) {
                completed([CommandModel getCommandModel:strArr],NO);
            }
        }
            break;
        case 11:
        {
            /**
             *  获取当前配对成功的ID $OBD,0B,4,0010\r\n
             */
            if (completed) {
                completed([CommandModel getCommandModel:strArr],NO);
            }
        }
            break;
        case 12:
        {
            /**
             *  读取故障码 $OBD,0C,23,P0006|P0007
             \r\n
             */
            if (completed) {
                completed([CommandModel getCommandModel:strArr],YES);
            }
        }
            break;
        case 13:
        {
            /**
             *  清除故障码 $OBD,0D,2,OK\r\n
             */
            if (completed) {
                completed([CommandModel getCommandModel:strArr],NO);
            }
        }
            break;
        case 14:
        {
            /**
             *  OBD 连接成功提示 ￼￼
             $OBD,0E,7,CONNECT\r\n
             */
            if ([OBDCentralMangerModel sharedOBDCentralMangerModel].cbCharacteristicArray&&[OBDCentralMangerModel sharedOBDCentralMangerModel].cbCharacteristicArray.count>0) {
                [[OBDCentralMangerModel sharedOBDCentralMangerModel].cbCharacteristicArray removeAllObjects];
            }
            Alert(@"连接到OBD");
        }
            break;
        case 15:
        {
            /**
             *  OBD 断线提示 $OBD,0F,10,DISCONNECT
             \r\n
             */
            if ([OBDCentralMangerModel sharedOBDCentralMangerModel].cbCharacteristicArray&&[OBDCentralMangerModel sharedOBDCentralMangerModel].cbCharacteristicArray.count>0) {
                [[OBDCentralMangerModel sharedOBDCentralMangerModel].cbCharacteristicArray removeAllObjects];
            }
            [[CurrentOBDModel sharedCurrentOBDModel] cleanData];
            [[OBDCentralMangerModel sharedOBDCentralMangerModel]brokeBluetoothLink];
            Alert(@"已和OBD断开连接");
        }
            break;
        case 16:
        {
            /**
             *  查询延时时间
             */
            [CurrentOBDModel sharedCurrentOBDModel].delayTime = [CommandModel getCommandModel:strArr].message;
        }
            break;
        case 17:
        {
            /**
             *  设置关闭盒子延时时间
             */
            if (completed) {
                completed([CommandModel getCommandModel:strArr],NO);
            }
        }
            break;
        case 18:
        {
            /**
             *  查询氧传感设置
             */
            if (completed) {
                completed([CommandModel getCommandModel:strArr],NO);
            }
        }
            break;
        case 19:
        {
            /**
             *  设置氧传感设置
             */
            if (completed) {
                completed([CommandModel getCommandModel:strArr],NO);
            }
        }
            break;
        default:
            break;
    }
}

- (void)setCheckTurnSpeed_Manager:(NSString *)checkTurnSpeed_Manager{
    if (![_checkTurnSpeed_Manager isEqualToString:checkTurnSpeed_Manager]) {
        _checkTurnSpeed_Manager = checkTurnSpeed_Manager;
    }
}
@end
