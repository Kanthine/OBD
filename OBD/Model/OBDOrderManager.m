//
//  OBDOrderManager.m
//  OBD
//
//  Created by Why on 16/4/6.
//  Copyright © 2016年 Why. All rights reserved.
//

#import "OBDOrderManager.h"
static OBDOrderManager * orderManager ;
@interface OBDOrderManager()
@property (nonatomic,copy) NSString * commandStr;
@end

@implementation OBDOrderManager

+ (OBDOrderManager*)sharedOBDOrderManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        orderManager = [[OBDOrderManager alloc]init];
    });
    return orderManager;
}

- (void)setOrderWithOrderIndex:(NSInteger)orderIndex isCheck:(BOOL)ischeck newOrder:(NSString*)newOrder
{
    self.index = orderIndex;
    self.setOderStr = newOrder;
    self.commandStr = ischeck ? [self getCheckOrderStr] : [self getCommonStr];
    if ([OBDCentralMangerModel sharedOBDCentralMangerModel].cbCharacteristicArray&&[OBDCentralMangerModel sharedOBDCentralMangerModel].cbCharacteristicArray.count>11)
    {
        CBCharacteristic * charactic = [[OBDCentralMangerModel sharedOBDCentralMangerModel].cbCharacteristicArray objectAtIndex:11];
       // NSLog(@"%@",[self.commandStr dataUsingEncoding:NSUTF8StringEncoding]);
        [[OBDCentralMangerModel sharedOBDCentralMangerModel].discoveredPeripheral writeValue:[self.commandStr dataUsingEncoding:NSUTF8StringEncoding] forCharacteristic:charactic type:CBCharacteristicWriteWithoutResponse];
    }
}
#pragma mark --得到查询的命令  读取值或者查询值--
- (NSString*)getCheckOrderStr
{
    NSString * checkStr;
    switch (self.index)
    {
        case 0:
        {
            checkStr = @"AT+GTRPM\r\n";//查询转速阀值
        }
            break;
        case 2:
        {
            checkStr = @"AT+GTBOX\r\n";
            //查询盒子状态 AT+GTBOX\r\n (MANON/MANOFF
            // AUTO)
        }
            break;
        case 4:
        {
            checkStr = @"AT+GTOBD\r\n";
            //查询数据流设置状态 AT+GTOBD\r\n
        }
            break;
        case 6:
        {
            checkStr = @"AT+GTITV\r\n";
            //查询数据流间隔(s) AT+GTITV\r\n
        }
            break;
        case 8:
        {
           checkStr = @"AT+GTBID\r\n";
            //读取已配对盒子ID AT+GTBID\r\n
        }
            break;
        case 9:
        {
            checkStr = @"AT+STBID\r\n";
            //配对指令
        }
            break;
        case 10:
        {
            checkStr = @"AT+GTDTC\r\n";
            //读取故障码 AT+GTDTC\r\n
        }
            break;
        case 12:
        {
            checkStr = @"AT+GTBDL\r\n";
            //查询延时时间
        }
            break;
        case 14:
        {
            checkStr = @"AT+GTOOS\r\n";
            //查询氧故障
        }
            break;
        default:
            break;
    }
    return checkStr;
}
- (NSString*)getCommonStr{
    NSString * str;
    switch (self.index) {
        case 1:
        {
            /**
             *  设置转速阀值
             */
            str = [NSString stringWithFormat:@"AT+STRPM=%@\r\n",self.setOderStr];
        }
            break;
        case 3:
        {
            /**
             *  控制盒子状态 MANON/MANOFF/AUTO
             */
            str = [NSString stringWithFormat:@"AT+STBOX=%@\r\n",self.setOderStr];
        }
            break;
        case 5:
        {
            /**
             *  设置数据流开关 ON/OFF
             */
            str = [NSString stringWithFormat:@"￼AT+STOBD=%@\r\n",self.setOderStr];
            
        }
            break;
        case 7:
        {
            /**
             *  设置数据流间隔 200>=T>=1
             */
            str = [NSString stringWithFormat:@"￼AT+STITV=%@\r\n",self.setOderStr];
        }
            break;
        case 11:{
            /**
             *  清除故障码
             */
            str = @"AT+STDTC\r\n";
        }
            break;
        case 13:
        {
            str = [NSString stringWithFormat:@"￼AT+STBDL=%@\r\n",self.setOderStr];
            //设置延时时间
        }
            break;
        case 15:
        {
            str = [NSString stringWithFormat:@"￼AT+STOOS=%@\r\n",self.setOderStr];
            //设置氧故障
        }
            break;
        default:
            break;
    }
    return str;
}


@end
