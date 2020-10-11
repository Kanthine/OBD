//
//  OBDCentralMangerModel.h
//  OBD
//
//  Created by Why on 16/1/15.
//  Copyright © 2016年 Why. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

typedef NS_ENUM(NSUInteger,OBDLinkState)
{
    OBDLinkStateBluetoothOff = 0,//蓝牙关闭
    OBDLinkStateBluetoothOn,//蓝牙打开
    OBDLinkStateStartScan,//开始扫描
    OBDLinkStateScanSuccess,//扫描成功
    OBDLinkStateScanFail,//扫描失败
};

@interface OBDCentralMangerModel : NSObject
<CBCentralManagerDelegate,CBPeripheralDelegate>

@property (strong, nonatomic) CBCentralManager * centralManager;//中心管理对象
@property (assign, nonatomic) OBDLinkState linkState;
/* 连接到的外设 */
@property (strong, nonatomic) CBPeripheral * discoveredPeripheral;
/* 当前获取到的OBD发送的数据 */
@property (strong, nonatomic) CommandModel * commendModel;
@property (strong, nonatomic) CBCharacteristic * fff1Charatistic;
@property (nonatomic,strong) NSMutableArray * cbCharacteristicArray;



//建立一个单例类
+ (OBDCentralMangerModel*)sharedOBDCentralMangerModel;

// 断开蓝牙链接
- (void)brokeBluetoothLink;
//重新扫描链接
- (void)scanPeripherals;

@end
