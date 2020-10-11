//
//  OBDMainViewController.m
//  OBD
//
//  Created by Why on 16/1/14.
//  Copyright © 2016年 Why. All rights reserved.
//

#import "OBDMainViewController.h"
#import "TopThreeView.h"
#import "SetAndCheckViewController.h"
@interface OBDMainViewController ()<UITableViewDataSource,UITableViewDelegate>


@end

@implementation OBDMainViewController
{
    UIButton * _goButton;
}
+ (OBDMainViewController*)sharedOBDMainViewController{
    static OBDMainViewController * vc = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        vc = [[OBDMainViewController alloc]init];
    });
    return vc;
}
- (void)viewWillAppear:(BOOL)animated{
    [[UIApplication sharedApplication]setIdleTimerDisabled:YES];
    [[UIApplication sharedApplication]setStatusBarHidden:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //[self.view addSubview:self.tableView];
    // Do any additional setup after loading the view from its nib.
    //[self textLable];
    
    _goButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _goButton.frame = CGRectMake(100, ScreenHeight-100, ScreenWidth-200, 60);
    [_goButton setTitle:@"查询/设置" forState:UIControlStateNormal];
    _goButton.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:_goButton];
    [_goButton addTarget:self action:@selector(goNextClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.textLable];
    [self.view bringSubviewToFront:self.textLable];
    self.obdMessageArray = [NSMutableArray array];
    [OBDCentralMangerModel sharedOBDCentralMangerModel];
}

- (UILabel*)textLable{
    if (!_textLable) {
        _textLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 60, ScreenWidth-20, ScreenHeight-120)];
        _textLable.font = [UIFont boldSystemFontOfSize:16];

        _textLable.textColor = [UIColor whiteColor];
        _textLable.backgroundColor = [UIColor clearColor];
        _textLable.text = [NSString stringWithFormat:@"%u",arc4random()%100];
        _textLable.numberOfLines = 0;
        _textLable.tag = 99;
    }
    return _textLable;
}

- (void)goNextClick{
    SetAndCheckViewController * vc = [[SetAndCheckViewController alloc]init];
    UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];
}
- (void)reloadData{
   // self.nowModel = [OBDCentralMangerModel sharedOBDCentralMangerModel].currentOBDModel;
    _textLable.text = [NSString stringWithFormat:@"%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n%@\n",[NSString stringWithFormat:@"转速 : %@rpm",_nowModel.turnSpeed],[NSString stringWithFormat:@"车速 : %@km/h",_nowModel.carSpeed],[NSString stringWithFormat:@"涡轮压力 : %@",_nowModel.turboPressure],[NSString stringWithFormat:@"油压 : %@",_nowModel.oilPressure],[NSString stringWithFormat:@"油温 : %@°C",_nowModel.oilTemperature],[NSString stringWithFormat:@"水温 : %@°C",_nowModel.waterTemperature],[NSString stringWithFormat:@"进气压力 : %@",_nowModel.intakePressure],[NSString stringWithFormat:@"节气开度 : %@%@",_nowModel.feastsOpeningValve,@"%"],[NSString stringWithFormat:@"进气温度 : %@°C",_nowModel.intakeTemperature],[NSString stringWithFormat:@"发送机负荷 : %@%@",_nowModel.engineLoad,@"%"],[NSString stringWithFormat:@"排气温度 : %@°C",_nowModel.exhaustTemperature],[NSString stringWithFormat:@"空燃比 : %@%@",_nowModel.fuelRatio,@"%"],[NSString stringWithFormat:@"进气流量 : %@",_nowModel.intakeAirFlow],[NSString stringWithFormat:@"故障码数量 : %@",_nowModel.errorCodeNumber],[NSString stringWithFormat:@"平均油耗 : %@L/100km",_nowModel.oilAverageLoss],[NSString stringWithFormat:@"盒子状态 : %@",_nowModel.boxStatus]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    change[NSKeyValueChangeNewKey];
}


@end
