//
//  AppDelegate.m
//  OBD
//
//  Created by Why on 16/1/12.
//  Copyright © 2016年 Why. All rights reserved.
//

#import "AppDelegate.h"

#import <Bugtags/Bugtags.h>

#import "AppDelegate+UM.h"
#import "AppDelegate+LaunchImage.h"

#import "AccountInfo.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    
    //配置bugtag
    [Bugtags startWithAppKey:@"32e461e54d4279b379db40d1c52ce9ae" invocationEvent:BTGInvocationEventNone];
    //配置友盟统计
    [self um_Application:application didFinishLaunchingWithOptions:launchOptions];
    //配置界面
    [self launch_Application:application didFinishLaunchingWithOptions:launchOptions];
    // 阻止锁屏
    [[UIApplication sharedApplication]setIdleTimerDisabled:YES];

    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
    
//    NSLog(@"\n ===> 程序暂行 !");
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
//    [[OBDCentralMangerModel sharedOBDCentralMangerModel]cleanup];
    
//      NSLog(@"\n ===> 程序进入后台 !");
    
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
//    
//    if ([OBDCentralMangerModel sharedOBDCentralMangerModel].discoveredPeripheral == nil)
//    {
//        [[OBDCentralMangerModel sharedOBDCentralMangerModel]scanPeripherals];
//    }
//    

//    NSLog(@"\n ===> 程序进入前台 !");

}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
//    if ([OBDCentralMangerModel sharedOBDCentralMangerModel].discoveredPeripheral == nil)
//    {
//        [[OBDCentralMangerModel sharedOBDCentralMangerModel]scanPeripherals];
//    }
//    NSLog(@"\n ===> 程序重新激活 !");
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
     NSLog(@"\n ===> 程序意外暂行 !");
        
    [[OBDCentralMangerModel sharedOBDCentralMangerModel]brokeBluetoothLink];
}

#pragma mark -

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}


- (BOOL)application:(UIApplication *)app
            openURL:(NSURL *)url
            options:(NSDictionary<NSString *,id> *)options
{
    
    BOOL result = [[UMSocialManager defaultManager]  handleOpenURL:url options:options];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;

};


@end
