//
//  OBDModel.h
//  OBD
//
//  Created by Why on 16/1/15.
//  Copyright © 2016年 Why. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 *  OBD数据Model
 */
@interface OBDModel : NSObject
/**
 *  命令代号 00数据流 01预留 02查询转速阀值 03设置转速阀值 04查询盒子状态 05控制盒子状态 06查询数据流设置状态 07设置数据流开关 08查询数据流间隔（s）09设置数据流间隔（s）0A读取已配对盒子ID ）0B获取当前配对成功的ID 0C读取故障码 0D清楚故障码 0E OBD连接成功提示  0F OBD断线提示
 */
@property(nonatomic,copy)NSString * commandCode;
/**
 *  数据字节数 大于0
 */
@property(nonatomic,copy)NSString * dataByteCount;
/**
 *  转速 单位（rpm）范围（0-16384）
 */
@property(nonatomic,copy)NSString * turnSpeed;
/**
 *  车速 单位（Km/h）范围（0-255）
 */
@property(nonatomic,copy)NSString * carSpeed;
/**
 *  涡轮压力 范围（预留(固定为 0））
 */
@property(nonatomic,copy)NSString * turboPressure;
/**
 *  油压 范围（预留(固定为 0））
 */
@property(nonatomic,copy)NSString * oilPressure;
/**
 *  油温 单位（°C）范围（预留(固定为 0））
 */
@property(nonatomic,copy)NSString * oilTemperature;
/**
 *  水温 单位（°C）范围（-40-215）
 */
@property(nonatomic,copy)NSString * waterTemperature;
/**
 *  进气压力 单位（Pa）范围（0~255kPa）
 */
@property(nonatomic,copy)NSString * intakePressure;
/**
 *  节气开度 单位（%）范围（0.00-100.00）
 */
@property(nonatomic,copy)NSString * feastsOpeningValve;
/**
 *  进气温度 单位（°C）范围（-40~+215）
 */
@property(nonatomic,copy)NSString * intakeTemperature;
/**
 *  发送机负荷 单位（%）范围（0.00-100.00）
 */
@property(nonatomic,copy)NSString * engineLoad;
/**
 *  排气温度 单位（°C）范围（预留(固定为 0)）
 */
@property(nonatomic,copy)NSString * exhaustTemperature;
/**
 *  空燃比 单位（%）范围（0.0-99.9）
 */
@property(nonatomic,copy)NSString * fuelRatio;
/**
 *  进气流量 单位（g/S）范围（0~655.35）
 */
@property(nonatomic,copy)NSString * intakeAirFlow;
/**
 *  故障码数量  范围（0-127）
 */
@property(nonatomic,copy)NSString * errorCodeNumber;
/**
 *  平均油耗 单位（L/100km） 范围（0.00-99.99）
 */
@property(nonatomic,copy)NSString * oilAverageLoss;
/**
 *  盒子状态 0->未获取 1->MANON 2->MANOFF 3->AUTON 4->AUTOFF
 */
@property(nonatomic,copy)NSString * boxStatus;

/**
 *  本次行驶里程
 */
@property(nonatomic,copy)NSString * currentDriveDistance;
/**
 *  本次油耗量
 */
@property(nonatomic,copy)NSString * currentOilLoss;
/**
 *  本次行驶时间
 */
@property(nonatomic,copy)NSString * currentDriveTime;
/**
 *  本次怠速时间
 */
@property(nonatomic,copy)NSString * currentDaiSuTime;
/**
 *  平均车速
 */
@property(nonatomic,copy)NSString * averageCarSpeed;
+ (OBDModel*)getOBDFlueModel:(NSArray*)strArray;
+ (OBDModel*)getModel:(NSString*)receiveValueStr;

@end

@interface CommandModel : NSObject
/**
 *  命令字符
 */
@property(nonatomic,copy)NSString * commandType;
/**
 *  字节数
 */
@property(nonatomic,copy)NSString * byteCount;
/**
 *  具体的信息
 */
@property(nonatomic,copy)NSString * message;

+ (CommandModel*)getCommandModel:(NSArray*)strArr;

@end


@interface OBDModelManager : NSObject
@property (nonatomic ,strong) NSString *demoString;
+ (OBDModelManager*)sharedOBDModelManager;
//转速阀值
@property(nonatomic,copy)NSString *checkTurnSpeed_Manager;

/**
 * @param receiveValueStr 蓝牙数据流；使用 demoString 替代
 */
- (void)managerODBMessageWithStr:(NSString*)receiveValueStr complete:(void(^)(id object,BOOL isByteFlue))completed;

@end


