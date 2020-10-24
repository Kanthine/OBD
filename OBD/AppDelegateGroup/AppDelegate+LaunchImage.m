//
//  AppDelegate+LaunchImage.m
//  OBD
//
//  Created by 苏沫离 on 2017/4/24.
//  Copyright © 2017年 苏沫离. All rights reserved.
//

#import "AppDelegate+LaunchImage.h"

#import "StartHelp.h"


#import "OBD-Swift.h"
#import "AuthorizationManager.h"

#import "PageOneViewController.h"
#import "WHYNavigationController.h"


@implementation AppDelegate (LaunchImage)
SpLanuchView * spLaunchView;

- (void)launch_Application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlackTranslucent];
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"nav_BarBack"] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage:[UIImage new]];
    
    
    /** 1、是否第一次启动APP
     2、是否登录
     3、是否选择产品类型
     4、跳转蓝牙链接界面：（是否开启蓝牙，是否开始扫描）
        <1>、是否链接盒子
        <2>、进入主界面
     */
    
    //Xcode7需要所有UIWindow必须有一个rootViewController
    if ([AuthorizationManager isLoginState] == NO){
        LoginViewController *loginVC = [[LoginViewController alloc]init];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:loginVC];
        nav.navigationBarHidden = YES;
        self.window.rootViewController = nav;
    }else if ([AuthorizationManager getUserBrandType] == UserProductTypeNone){
        ProductTypeSetVC *kindVC = [[ProductTypeSetVC alloc]init];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:kindVC];
        nav.navigationBarHidden = YES;
        self.window.rootViewController = nav;
    }else{
        BluetoothSetVC *setVC = [[BluetoothSetVC alloc]init];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:setVC];
        nav.navigationBarHidden = YES;
        self.window.rootViewController = nav;
    }
    
    
    if ([StartHelp isFirstLaunchApp]){
        // 启动页
        spLaunchView = [[SpLanuchView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        spLaunchView.delegate = self;
        [self.window addSubview:spLaunchView];
        [self.window bringSubviewToFront:spLaunchView];
    }
}

- (void)goMainView{
    PageOneViewController *vc = [[PageOneViewController alloc]init];
    vc.navigationBarHidden = YES;
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
    self.window.rootViewController = nav;
}

- (void)spLaunVctartButtonTouchEvent{
    [UIView animateWithDuration:0.65 animations:^{
        spLaunchView.alpha = 0.1;
    } completion:^(BOOL finished){
        [spLaunchView removeFromSuperview];
        [StartHelp saveIsFirstOpen:YES];
    }];
}

@end
