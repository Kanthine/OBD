//
//  OBDCentralMangerModel.m
//  OBD
//
//  Created by Why on 16/1/15.
//  Copyright © 2016年 Why. All rights reserved.
//


#import "OBDCentralMangerModel.h"
#import "AuthorizationManager.h"
#import "OBDThisTimeData.h"

@interface OBDCentralMangerModel()
@property (copy, nonatomic) NSString *productName;

@end

@implementation OBDCentralMangerModel

+ (OBDCentralMangerModel*)sharedOBDCentralMangerModel
{
    static OBDCentralMangerModel * centralModel = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
    {
        centralModel = [[OBDCentralMangerModel alloc]init];
    });
    return centralModel;
}

- (instancetype)init
{
    if (self)
    {
        //  初始化中央管理器
        self.centralManager = [[CBCentralManager alloc]initWithDelegate:self queue:nil];
        self.cbCharacteristicArray = [NSMutableArray array];
        _linkState = OBDLinkStateBluetoothOff;
    }
    return self;
}

- (void)setLinkState:(OBDLinkState)linkState
{
    _linkState = linkState;
    
    
    if (linkState == OBDLinkStateScanSuccess)
    {
        [OBDThisTimeData isAgainLinkedOBD:YES];
    }
    else
    {
        [OBDThisTimeData isAgainLinkedOBD:NO];
    }
}

- (NSString *)productName
{
    NSString *name = @"";
    switch ([AuthorizationManager getUserBrandType])
    {
        case UserProductTypeNone:
            name = @"";
            break;
        case UserProductTypeDefault:
            name = @"iexhaust";
            break;
        case UserProductTypeFWD:
            name = @"iexhaust";
            break;
        default:
            break;
    }
    return name;
}

//中央管理器状态 ----> 查看蓝牙开关状态
- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    switch (central.state)
    {
        case CBCentralManagerStatePoweredOff://蓝牙关闭
        {
            [CurrentOBDModel sharedCurrentOBDModel].processStatus = @"1";
            [self brokeBluetoothLink];
            [[CurrentOBDModel sharedCurrentOBDModel]cleanData];
            self.linkState = OBDLinkStateBluetoothOff;
            NSLog(@"蓝牙关闭");
        }
            break;
        case CBCentralManagerStatePoweredOn://蓝牙打开
        {
            [CurrentOBDModel sharedCurrentOBDModel].processStatus = @"2";
            self.linkState = OBDLinkStateBluetoothOn;
            [self scanPeripherals];
            if (self.cbCharacteristicArray && self.cbCharacteristicArray.count > 0)
            {
                [self.cbCharacteristicArray removeAllObjects];
            }
            NSLog(@"蓝牙打开");
        }
            break;
        case CBCentralManagerStateUnknown://未知
            self.linkState = OBDLinkStateBluetoothOff;
            NSLog(@">>>CBCentralManagerStateUnknown");
            break;
        case CBCentralManagerStateResetting:// 复位
            self.linkState = OBDLinkStateBluetoothOff;
            NSLog(@">>>CBCentralManagerStateResetting");
            break;
        case CBCentralManagerStateUnsupported://蓝牙外设不可用
            self.linkState = OBDLinkStateBluetoothOff;
            NSLog(@">>>CBCentralManagerStateUnsupported");
            break;
        case CBCentralManagerStateUnauthorized://该应用程序是无权使用蓝牙低功耗。
            self.linkState = OBDLinkStateBluetoothOff;
            NSLog(@">>>CBCentralManagerStateUnauthorized");
            break;
        default:
            break;
    }
}

#pragma mark CBCentralManagerDelegate  连接外设

/*
 serviceUUIDs：代表该app所感兴趣的服务uuids数组（也就是该app想要连接的外设）
 扫描周边设备方法
 */
- (void)scanPeripherals
{
    if ([AuthorizationManager getUserBrandType] == UserProductTypeNone)
    {
        //如果没有选择产品类型，提醒用户去选择产品类型
    }
    else
    {
        //只有选择了产品类型 扫描才有意义
        self.linkState = OBDLinkStateStartScan;
        [_centralManager scanForPeripheralsWithServices:nil options:nil];
        NSLog(@"开始扫描外设");
    }
}

/*
 *  每当扫描到一个外部设备，就会调用委托对象中的以下方法
 */
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *,id> *)advertisementData RSSI:(NSNumber *)RSSI
{
    NSLog(@"扫描到的外设名字 ------ %@",peripheral);

    NSLog(@"扫描到的外设名字:%@",peripheral.name);
    if (self.discoveredPeripheral != peripheral)
    {
        self.discoveredPeripheral = peripheral;
        if ([peripheral.name isEqualToString:self.productName])
        {
            //连接外设
            [central connectPeripheral:peripheral options:nil];
        }
    }
    else
    {
        [central stopScan]; //停止扫描
        [self brokeBluetoothLink];
        [self brokeBluetoothLink];//开始扫描外设
    }
}

/*
 * 成功的连接到了外部设备
 */
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    NSLog(@"连接到设备了");
    if ([peripheral.name isEqualToString:self.productName])
    {
        [CurrentOBDModel sharedCurrentOBDModel].processStatus = @"3";
        peripheral.delegate = self;
        [peripheral discoverServices:nil];
        [central stopScan];
        self.linkState = OBDLinkStateScanSuccess;
    }
}

/*
 * 连接到外设失败
 */
- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    self.discoveredPeripheral = nil;
    [self scanPeripherals];
    self.linkState = OBDLinkStateScanFail;
    
    NSLog(@"连接到外设失败 error： %@", [error localizedDescription]);
}

/*
 *  取消连接到外设
 */
- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(nullable NSError *)error
{
    NSLog(@"取消连接到外设 error： %@", [error localizedDescription]);
    
    self.discoveredPeripheral = nil;
    [self scanPeripherals];
    self.linkState = OBDLinkStateScanFail;
}

#pragma mark --The Transfer Service was discovered 发现了外设发送的服务--

/*
 设备连接成功后，就可以扫描设备的服务了，同样是通过委托形式，扫描到结果后会进入委托方法。
 但是这个委托已经不再是主设备的委托（CBCentralManagerDelegate），而是外设的委托（CBPeripheralDelegate）,
 这个委托包含了主设备与外设交互的许多回调方法，包括获取services，获取characteristics，获取characteristics的值，获取characteristics的Descriptor，和Descriptor的值，写数据，读rssi，用通知的方式订阅数据等等。
 */

/*
 * 确定发现了服务，调用下面的方法
 */
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
{
    if (error)
    {
        [self brokeBluetoothLink];
        return;
    }
    for (CBService * service in peripheral.services)
    {
        // 发现服务成功后去扫描该服务的特征
        [peripheral discoverCharacteristics:nil forService:service];
    }
}


/*
 *  针对某个服务确定发现了特征；设备下面有服务，服务下面有特征；服务有UUID，特征也有UUID
 */
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
{
    if (error)
    {
        NSLog(@"Error discovering characteristics: %@", [error localizedDescription]);
        [self brokeBluetoothLink];
        return;
    }
    
    [self.cbCharacteristicArray addObjectsFromArray:service.characteristics];
   // [NSMutableArray arrayWithArray:service.characteristics];
    for (CBCharacteristic * characteristic in service.characteristics)
    {
        if ([characteristic.UUID.UUIDString isEqualToString:@"FFF1"])
        {
            //设置通知，数据通知会进入：didUpdateValueForCharacteristic方法
            [peripheral setNotifyValue:YES forCharacteristic:characteristic];
        }
        
        NSLog(@"%@\n_____%@",characteristic,[[NSString alloc]initWithData:characteristic.value encoding:NSUTF8StringEncoding]);
    }
}

#pragma mark --服务特征数据 一直更新--

- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    if (error)
    {
        NSLog(@"Error discovering characteristics: %@", [error localizedDescription]);
        return;
    }
    
    NSString *stringFromData = [[NSString alloc]initWithData:characteristic.value encoding:NSUTF8StringEncoding];
    
    if ([stringFromData containsString:@"$OBD,00"] == NO)
    {
        NSLog(@"stringFromData ======= %@",stringFromData);
    }
//    NSLog(@"stringFromData ======= %@",stringFromData);

    
    [[OBDModelManager sharedOBDModelManager]managerODBMessageWithStr:stringFromData complete:^(id object, BOOL isByteFlue)
    {
        if ([object isKindOfClass:[OBDModel class]])
        {
            [CurrentOBDModel sharedCurrentOBDModel].currentModel = (OBDModel*)object;
        }
        else if ([object isKindOfClass:[CommandModel class]])
        {
            CommandModel * model = (CommandModel*)object;
            [CurrentOBDModel sharedCurrentOBDModel].currentCommandModel = (CommandModel*)object;
//            NSLog(@"model.message ==== %@",model.message);
        }
    }];
}

- (void)brokeBluetoothLink
{
    if (self.discoveredPeripheral.services != nil && self.discoveredPeripheral.services.count > 0 )
    {
        for (CBService * service in self.discoveredPeripheral.services)
        {
            if (service.characteristics != nil&&service.characteristics.count>0)
            {
                for (CBCharacteristic * characteristic in service.characteristics)
                {
                    if (characteristic.isNotifying)
                    {
                        [self.discoveredPeripheral setNotifyValue:NO forCharacteristic:characteristic];
                        return;
                    }
                }
            }
        }
    }
    // If we've got this far, we're connected, but we're not subscribed, so we just disconnect
    if (_discoveredPeripheral != nil)
    {
        //取消外设连接
        //该方法调用后会触发委托中的方法：centralManager:didDisconnectPeripheral:error:
        [self.centralManager cancelPeripheralConnection:self.discoveredPeripheral];
        _discoveredPeripheral = nil;
    }
}
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForDescriptor:(CBDescriptor *)descriptor error:(NSError *)error
{
    NSLog(@"didUpdateValueForDescriptor ======= error : %@",error.domain);
}

- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    NSLog(@"didWriteValueForCharacteristic ======= error : %@",error.domain);
}

- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForDescriptor:(CBDescriptor *)descriptor error:(NSError *)error
{
    NSLog(@"didWriteValueForDescriptor ======= error : %@",error.domain);
}


@end

/*
 链接的流程
 
 1、判断蓝牙开关状态：是否处于打开状态
 2、扫描外部设备 [manager scanForPeripheralsWithServices:nil options:options];
 3、连接外设 ：一个主设备最多能连7个外设，每个外设最多只能给一个主设备连接,连接成功，失败，断开会进入各自的委托
 4、
 */

