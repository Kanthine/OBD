//
//  AppDelegate.m
//  OBD
//
//  Created by Why on 16/1/12.
//  Copyright © 2016年 Why. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+LaunchImage.h"
#import "AccountInfo.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    
    self.window = [[UIWindow alloc]initWithFrame:UIScreen.mainScreen.bounds];
    [self.window makeKeyAndVisible];
    
    //配置界面
    [self launch_Application:application didFinishLaunchingWithOptions:launchOptions];
    // 阻止锁屏
    //[[UIApplication sharedApplication]setIdleTimerDisabled:YES];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application{
//    NSLog(@"\n ===> 程序暂行 !");
}

- (void)applicationDidEnterBackground:(UIApplication *)application{
//    [[OBDCentralMangerModel sharedOBDCentralMangerModel]cleanup];
//      NSLog(@"\n ===> 程序进入后台 !");
}

- (void)applicationWillEnterForeground:(UIApplication *)application{
//    if ([OBDCentralMangerModel sharedOBDCentralMangerModel].discoveredPeripheral == nil)
//    {
//        [[OBDCentralMangerModel sharedOBDCentralMangerModel]scanPeripherals];
//    }
//    
//    NSLog(@"\n ===> 程序进入前台 !");
}

- (void)applicationDidBecomeActive:(UIApplication *)application{
//    if ([OBDCentralMangerModel sharedOBDCentralMangerModel].discoveredPeripheral == nil)
//    {
//        [[OBDCentralMangerModel sharedOBDCentralMangerModel]scanPeripherals];
//    }
//    NSLog(@"\n ===> 程序重新激活 !");
}

- (void)applicationWillTerminate:(UIApplication *)application{
     NSLog(@"\n ===> 程序意外暂行 !");
    [[OBDCentralMangerModel sharedOBDCentralMangerModel]brokeBluetoothLink];
}

@end
