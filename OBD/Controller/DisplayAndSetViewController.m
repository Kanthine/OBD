//
//  DisplayAndSetViewController.m
//  OBD
//
//  Created by Why on 16/1/18.
//  Copyright © 2016年 Why. All rights reserved.
//

#import "DisplayAndSetViewController.h"

@interface DisplayAndSetViewController ()
@property (nonatomic,copy)NSString * commandStr;
@end

@implementation DisplayAndSetViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = self.titleStr;
    [self setUpView];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveMessage) name:@"why" object:nil];
}
- (void)receiveMessage
{
    self.displayLable.text = [OBDCentralMangerModel sharedOBDCentralMangerModel].commendModel.message;
    if (!self.isCheck)
    {
        NSString * coomstr = [OBDCentralMangerModel sharedOBDCentralMangerModel].commendModel.message;
        if ([@"OK" isEqualToString:coomstr])
        {
            Alert(@"设置成功");
        }
        else if ([@"ERROR" isEqualToString:coomstr])
        {
            Alert(@"设置失败");
        }
    }
}
- (void)setAndDisplayOBD{
    switch (self.index) {
        case 0:
        {
            self.commandStr = @"AT+GTRPM\r\n";//查询转速阀值
        }
            break;
        case 1:
        {
            //设置转速阀值 AT+STRPM=3000\r\n
        }
            break;
        case 2:
        {
            self.commandStr = @"AT+GTBOX\r\n";
            //查询盒子状态 AT+GTBOX\r\n (MANON/MANOFF
            // AUTO)
        }
            break;
        case 3:
        {
            
            //控制盒子状态 AT+STBOX=MANON\r\n (MANON/MANOFF
            // AUTO)

        }
            break;
        case 4:
        {
            self.commandStr = @"AT+GTOBD\r\n";
            //查询数据流设置状态 AT+GTOBD\r\n
        }
            break;
        case 5:
        {
            //设置数据流开关 AT+STOBD=ON\r\n
        }
            break;
        case 6:
        {
            self.commandStr = @"AT+GTITV\r\n";
            //查询数据流间隔(s) AT+GTITV\r\n
        }
            break;
        case 7:
        {
            //设置数据流间隔 AT+STITV=1\r\n  200>=T>=1
        }
            break;
        case 8:
        {
            self.commandStr = @"AT+GTBID\r\n";
            //读取已配对盒子ID AT+GTBID\r\n
        }
            break;
        case 9:
        {
            self.commandStr = @"AT+STBID\r\n";
            //获取当前配对成功的ID AT+STBID\r\n
        }
            break;
        case 10:
        {
            self.commandStr = @"AT+GTDTC\r\n";
            //读取故障码 AT+GTDTC\r\n
        }
            break;
        case 12:
        {
            self.commandStr = @"AT+STDTC\r\n";
            //AT+STDTC\r\n
        }
            break;
            
        default:
            break;
    }
  
    CBCharacteristic * charactic = [[OBDCentralMangerModel sharedOBDCentralMangerModel].cbCharacteristicArray objectAtIndex:11];
    [[OBDCentralMangerModel sharedOBDCentralMangerModel].discoveredPeripheral writeValue:[self.commandStr dataUsingEncoding:NSUTF8StringEncoding] forCharacteristic:charactic type:CBCharacteristicWriteWithoutResponse];
}
- (void)setUpView{
    
    if (self.isCheck) {
        self.backView.hidden = YES;
        [self setAndDisplayOBD];
    }else{
        self.displayLable.hidden = YES;
        self.textField.placeholder = [self getStr];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString*)getStr{
    NSString * str;
    switch (self.index) {
        case 1:
        {
            str = @"阀值范围为1-16383";
        }
            break;
        case 3:
        {
            str = @"MANON/MANOFF/AUTO";
        }
            break;
        case 5:
        {
            str = @"ON/OFF 关闭就不能收到盒子发来的数据了";
        }
            break;
        case 7:
        {
            str = @"时间 200>=T>=1";
        }
            break;
        case 11:{
            str = @"点击确定按钮即可清除故障码";
        }
        default:
            break;
    }
    return str;
}
- (IBAction)containButtonClick:(UIButton *)sender {
    
    if (!(self.textField.text.length>0)) {
        if (self.index!=11) {
            Alert(@"您当前没有输入任何内容");
            return;
        }
       
    }
    self.commandStr = [self getCommonStr];
    [self setAndDisplayOBD];
}
- (NSString*)getCommonStr{
    NSString * str;
    switch (self.index) {
        case 1:
        {
            str = [NSString stringWithFormat:@"AT+STRPM=%@\r\n",self.textField.text];
        }
            break;
        case 3:
        {
            str = [NSString stringWithFormat:@"AT+STBOX=%@\r\n",self.textField.text];
        }
            break;
        case 5:
        {
             str = [NSString stringWithFormat:@"￼AT+STOBD=%@\r\n",self.textField.text];

        }
            break;
        case 7:
        {
             str = [NSString stringWithFormat:@"￼AT+STITV=%@\r\n",self.textField.text];
        }
            break;
        case 11:{
            str = @"AT+STDTC\r\n";
        }
        default:
            break;
    }
    return str;
}
@end
