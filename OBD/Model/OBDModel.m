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

@interface OBDModelManager ()
@end

@implementation OBDModelManager
+ (OBDModelManager*)sharedOBDModelManager{
    static  OBDModelManager * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[OBDModelManager alloc]init];
    });
    return manager;
}


// 油耗
- (NSString *)demoString{
    NSArray *array = @[
@"$OBD,00,62,1221 ,30 ,0,1, 0.1, 60, 90,  60 ,30, 80, 40 ,60, 36.8,105.63,5, 9.8,1,20,6.7,0.5,3,45\r\n",
@"$OBD,00,62,2221 ,35 ,0.15,0.2, 70, 100, 130,50, 120,55 ,70, 57.2,282.15,5,10.5,1,30,8.5,1,8,30\r\n",
@"$OBD,00,62,5221 ,50 ,0.18,0.15,80, 150, 155,60, 150,68 ,76, 60.6,350.21,5,12.6,1,50,6.8,2,10,50\r\n",
@"$OBD,00,62,3221 ,40 ,0.19,0.25,80, 135, 192,65, 100,50 ,80, 50.3,421.56,5,15.8,1,70,9.7,10,20,55\r\n",
@"$OBD,00,62,6221 ,60 ,0.2, 0.35,90, 130, 190,78, 136,70 ,90, 56.8,456.32,5,20.9,1,80.2,10.7,20.5,15,60\r\n",
@"$OBD,00,62,7221 ,65 ,0.3, 0.5, 120,155, 200,86, 160,80 ,100,67.5,500.05,5,37.9,1,90,12.7,35.8,35,70\r\n",
@"$OBD,00,62,8221 ,70 ,0.4, 0.6, 200,170, 210,90, 195,95 ,105,80.0,595.3 ,5,45.6,1,95,16.7,40,53,80\r\n",
@"$OBD,00,62,10221,100,0.5, 0.75,290,210, 250,100,215,100,120,99.0,655.35,5,58.8,1,93,19.7,60,32,90\r\n",
@"$OBD,00,62,5221 ,80 ,0.35,0.6, 230,200, 230,90, 200,90 ,110,89.0,605.5 ,5,48.9,1,99,9.7,9.5,17,85\r\n"
    ];
    return array[arc4random() % array.count];
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
